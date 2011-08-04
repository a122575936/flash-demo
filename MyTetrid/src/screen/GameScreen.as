package screen
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import tetrad.Tetrad;
	
	import ultis.Color;

	public class GameScreen extends Sprite
	{
		/**
		 *游戏界面的方块存储数组
		 * 宽和高由blockWildth and blockHeight决定
		 */
		private var _blockArray:Array;
		private var _blockWildth:uint = 10;
		private var _blockHeight:uint = 20;
		/**
		 *每个小方块的边长 
		 */
		private var _blockSize:uint = 20;
		/**
		 *游戏定时器
		 * 用来控制tetrad的下落 
		 */
		private var _gameTimer:Timer;
		/**
		 *所有添加到游戏区域的tetrad保存在一个数组 
		 */
		private var _tetradArray:Array;
		private var _tetrad:Tetrad;
		/**
		 *下按键的keycode 
		 */
		public var _downKeycode:uint = Keyboard.DOWN;
		/**
		 *左按键的keycode 
		 */
		public var _leftKeycode:uint = Keyboard.LEFT;
		/**
		 *右按键的keycode 
		 */
		public var _rightKeycode:uint = Keyboard.RIGHT;
		/**
		 *上按键的keycode 
		 */
		public var _upKeycode:uint = Keyboard.UP;
		/**
		 *tetrad的移动类型
		 * 在类TetradMoveType中定义 
		 */
		private var _tetradMovingType:String;
		/**
		 * tetrad左边的空白距离
		 */
		private var _spaceLeft:Number;
		/**
		 * tetrad右边的空白距离
		 */
		private var _spaceRight:Number;
		/**
		 * tetrad下面的空白距离
		 */
		private var _spaceDown:Number;
		
		public function GameScreen()
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		protected function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			init();
		}
		
		protected function init():void
		{
			_gameTimer = new Timer(2000);
			_tetradArray  = new Array();
			_blockArray = new Array(_blockHeight);
			for (var i:int = 0; i < _blockHeight; i++) 
			{
				_blockArray[i] = new Array(_blockWildth);
				for (var j:int = 0; j < _blockWildth; j++) 
				{
					_blockArray[i][j] = 0;
				}
			}
			
			_tetrad = Tetrad.createTetrad();
			initTetradPos(_tetrad);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_gameTimer.addEventListener(TimerEvent.TIMER, onGameTimer);
			_gameTimer.start();
		}
			
		protected function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode) {
				case this._downKeycode:
					_tetradMovingType = TetradMoveType.DOWN;
					//连续下移三格
					for (var i:int = 0; i < 3; i++) 
					{
						move(0, 1);
					}
					break;
				case this._leftKeycode:
					_tetradMovingType = TetradMoveType.LEFT;
					move( -1, 0);
					break;
				case this._rightKeycode:
					_tetradMovingType = TetradMoveType.RIGHT;
					move(1, 0);
					break;
				case this._upKeycode:
					_tetradMovingType = TetradMoveType.ROLL;
					roll();   
					break;
			}
			updateGameScreen();
		}
		/**
		 *旋转tetrad 
		 * 
		 */		
		private function roll():void
		{
			//开始翻转
			var newTetris:Array = new Array(4);
			for ( var i:int=0; i <_tetrad.shapeArray.length; i++ ) {
				newTetris[i] = new Array(4);
				for (var j:int=0; j <_tetrad.shapeArray.length; j++ ) {
					newTetris[i][j] = _tetrad.shapeArray[(4-1)-j][i];
				}
			}
			//判断翻转后是否会与原有方块重合，如果重合return,不让翻转
			for ( i = 0; i <4;i++ ) {
				for ( j = 0; j <4; j++ ) {
					if (newTetris[i][j] == 1) {
						if (i+_tetrad.y > _blockHeight - 1) return;
						if (_blockArray[i + _tetrad.y][j + _tetrad.x] == 2 ) return;
					}
				}
			}
			
			this._tetrad.shapeArray = newTetris;
			
			//考虑在左右板边翻转超出舞台的情况
			getSpaceAroundTetrad();
			if ( _tetrad.x + _spaceLeft <0 ) _tetrad.x = 0;
			if ( _tetrad.x + _spaceLeft + _tetrad.shapeArray[0].length - _spaceRight > 10 ) _tetrad.x = 10 - _tetrad.shapeArray[0].length - _spaceRight;	
		}
		
		protected function onGameTimer(event:TimerEvent):void
		{
			_tetradMovingType = TetradMoveType.DOWN;
			move(0, 1);
			updateGameScreen();//刷新游戏界面
		}
		
		/**
		 *更新游戏区域 
		 * 
		 */
		private function updateGameScreen():void
		{
			clearScreen();
			for (var i:int = 0; i < _blockHeight; i++ ) {
				var clearState:int = 0;
				for (var j:int = 0; j < _blockWildth; j++ ) {
					var newBrick:Sprite = this.drawBrick(_tetrad.color);
					newBrick.x = j * _blockSize;
					newBrick.y = i * _blockSize;
					if(_blockArray[i][j]==0){//添加空白方格
						var newBrick2:Sprite = this.drawBrick(0xc0c0c0);
						newBrick2.x = j * _blockSize;
						newBrick2.y = i * _blockSize;
						_tetradArray.push(newBrick2);
						addChild(newBrick2);
					}else if (_blockArray[i][j] == 2) {//addChild已经下落的方格
						clearState++;
						var newBrick3:Sprite = this.drawBrick(Color.black);
						newBrick3.x = j * _blockSize;
						newBrick3.y = i * _blockSize;
						_tetradArray.push(newBrick3);
						addChild(newBrick3);
					}
					//把Tetris数组转换并addchild到舞台
					if (i < _tetrad.y + _tetrad.shapeArray.length
						&& i >= _tetrad.y
						&& j >= _tetrad.x
						&& j < _tetrad.x + _tetrad.shapeArray[0].length) 
					{
						if (_tetrad.shapeArray[i - _tetrad.y][j - _tetrad.x] == 1) 
						{
							newBrick.graphics.beginFill(0x000000);
							_tetradArray.push(newBrick);
							addChild(newBrick);
						}
					}               
				}
				
				/*消掉一行*/
				if (clearState >= _blockWildth) {
					_blockArray.splice(i, 1) ;
					/*_blockArray.unshift([0,0,0,0,0,0,0,0,0,0]);*/
					var array:Array = new Array();
					for (var k:int = 0; k < _blockWildth; k++) 
					{
						array.push(0);
					}
					_blockArray.unshift(array);
				}
			}
		}
		
		private function drawBrick(color:Number):Sprite
		{
			var mySprite:Sprite = new Sprite();
			mySprite.graphics.beginFill(color);
			mySprite.graphics.lineStyle(1,0xffffff);
			mySprite.graphics.drawRect(0, 0, _blockSize, _blockSize);
			mySprite.graphics.endFill();
			return mySprite;
		}
		
		/**
		 *清空游戏区域 
		 * 
		 */
		private function clearScreen():void
		{
			//删除所有tetrad
			if (_tetradArray.length > 0) {
				for ( i = 0; i < _tetradArray.length; i++ ) {
					removeChild(_tetradArray[i]);
				}
				_tetradArray = [];
			}      
			//game over
			for (var i:int = 0; i < _blockWildth; i++ ) {
				if (_blockArray[0][i] == 2
					|| _blockArray[1][i] == 2
					|| _blockArray[2][i] == 2
					|| _blockArray[3][i] == 2) {
					init();
				}
			}
		}
		
		/**
		 *移动tetrad 
		 * @param xOffset
		 * @param yOffset
		 * 
		 */		
		private function move(xOffset:int, yOffset:int):void
		{
			getSpaceAroundTetrad();
			var hit:Array = hitTest();
			if (_tetrad.x + _spaceLeft + xOffset >= 0 && _tetrad.x + xOffset - _spaceRight <= _blockWildth - _tetrad.shapeArray[0].length && !hit[0])
			{
				_tetrad.x += xOffset;
			}
			
			if (hit[0] && hit[1] == TetradMoveType.DOWN)
			{
				floor(); //tetrad落地
			}		
			
			if (xOffset == 0 && _tetrad.y - _spaceDown + 4 < _blockHeight)
			{
				_tetrad.y += yOffset;
			}	
		}
		
		/**
		 *tetrad落地 
		 * 
		 */		
		private function floor():void
		{
			for ( var i:int = 0; i <4; i++ ) {
				for ( var j:int = 0; j <4; j++ ) {
					if (_tetrad.shapeArray[i][j] == 1) {
						_blockArray[i + _tetrad.y][j + _tetrad.x] = 2;
					}
				}
			}	
			_tetrad = Tetrad.createTetrad();
			initTetradPos(_tetrad);
		}
		
		/**
		 *初始化tetrad的坐标 
		 * @param _tetrad
		 * 
		 */		
		private function initTetradPos(_tetrad:Tetrad):void
		{
			_tetrad.x = _blockWildth / 2 - 2;
			_tetrad.y = 0;
		}
		
		/**
		 *碰撞检测 
		 * 对tetrad里的每一个方块做检测
		 * @return array[0]:是否碰撞  array[1]:碰撞方向
		 */
		private function hitTest():Array
		{
			getSpaceAroundTetrad();
			//检测左右是否有方格
			for (var i:int = 0; i < 4; i++) 
			{
				for (var j:int = 0; j < 4; j++) 
				{
					if (_tetrad.shapeArray[i][j] == 1)
					{
						if (_tetradMovingType == TetradMoveType.LEFT || _tetradMovingType == TetradMoveType.ROLL) 
						{
							if (_blockArray[i + _tetrad.y][j + _tetrad.x - 1] == 2) 
							{
								return [true, TetradMoveType.LEFT];
							}
						}
						if (_tetradMovingType == TetradMoveType.RIGHT || _tetradMovingType == TetradMoveType.ROLL) 
						{
							if (_blockArray[i + _tetrad.y][j + _tetrad.x + 1] == 2) 
							{
								return [true, TetradMoveType.RIGHT];
							}
						}
						if (_tetradMovingType == TetradMoveType.DOWN || _tetradMovingType == TetradMoveType.ROLL) 
						{
							if (i + _tetrad.y + 1 < _blockHeight) 
							{
								if (_blockArray[i + _tetrad.y + 1][j + _tetrad.x] == 2) 
								{
									return [true, TetradMoveType.DOWN];
								}	
							}		
						}
					}
				}	
			}
			//检测是否到下边界
			if (_tetrad.y - _spaceDown + _tetrad.shapeArray.length >= _blockHeight && 
				(_tetradMovingType == TetradMoveType.DOWN || _tetradMovingType == TetradMoveType.ROLL)) 
			{
				return [true, TetradMoveType.DOWN];
			}
			else
			{
				return [false, TetradMoveType.NONE];
			}
		}
		
		/**
		 *得到一个tetrad四周空的空间距离
		 * [0,0,0,0],
		   [0,1,1,0],
		   [0,1,1,0],
		   [0,0,0,0], 
		 * _spaceLeft = 1；  _spaceRight = 1；  _spaceDown = 1；
		 */
		private function getSpaceAroundTetrad():void
		{
			var tempint1:int = 0;
			var tempint2:int = 0;
			var tempint3:int = 0;
			
			_spaceLeft = 0;
			for ( var j:int= 0; j < 2;j++) {
				for (var i:int = 0; i < 4; i++) {
					if (_tetrad.shapeArray[i][j] == 1 ) tempint1++;
				}
				if (tempint1 == 0) 
					_spaceLeft++;
			}
			
			_spaceRight = 0;
			for (  j = 3; j > 1;j-- ) {
				for ( i = 0; i <4; i++ ) {
					if (_tetrad.shapeArray[i][j] == 1 ) tempint2++;
				}
				if (tempint2 == 0) 
					_spaceRight++;
			}
			
			_spaceDown = 0;
			for ( j = 3; j>1;j-- ) {
				for ( i = 0; i <4; i++ ) {
					if (_tetrad.shapeArray[j][i] == 1 ) tempint3++;
				}
				if (tempint3 == 0) 
					_spaceDown++;
			}
		}
	}
}