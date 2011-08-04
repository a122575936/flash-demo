package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	
	[SWF(width="480", height="640",backgroundColor=0xEEEEEE)]
	public class Test extends Sprite {
		public var worldArr:Array = new Array();//世界方块数组，由10*20的格子构成世界
		public var brickWH:int = 20;//每个小方块边长
		public var tetrisType:Array;//Tetris的数组(形状)
		public var tetrisX:int;//Tetris的世界X坐标（不是stage的x）
		public var tetrisY:int;//Tetris的世界y坐标
		public var worldTimer:Timer = new Timer(200);//世界时间
		public var tetrisBrickArr:Array = [];//所有添加到场景的小格子方块储存到一个数组
		public var downKeycode:int = 40;//下按键的keycode
		public var leftKeycode:int = 37;//左按键的keycode
		public var rightKeycode:int = 39;//右按键的keycode
		public var upKeycode:int = 38;//上按键的keycode
		public var tempL:int = 0;//Tetris的左边空白距离
		public var tempR:int = 0;//Tetris的右边空白距离
		public var tempD:int = 0;//Tetris的下边空白距离
		public var moveType:String;//移动状态
		
		public function Test():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			//构建世界数组
			for (var i:int = 0; i <20; i++ ) {
				worldArr[i] = [];
				for (var j:int = 0; j <10; j++ ) {
					worldArr[i][j] = 0;
				}
			}
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createTetris();
			worldTimer.addEventListener(TimerEvent.TIMER,onTimerHandler);
			worldTimer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
		}
		
		public function onTimerHandler(evnet:TimerEvent):void {
			moveType = 'd';//更改移动状态为下
			move(0, 1);//向下移动一格
			initWorld();//刷新世界
		}
		
		public function onKeyDownHandler(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case this.downKeycode:
					moveType = "d";
					move(0, 1);
					break;
				case this.leftKeycode:
					moveType = "l";
					move( -1, 0);
					break;
				case this.rightKeycode:
					moveType = "r";
					move(1, 0);
					break;
				case this.upKeycode:
					moveType = "ro";
					roll();   
					break;
			}
			initWorld();
			
		}
		
		public function initWorld():void {
			clearTetris();//构建世界前先清屏
			for (var i:int = 0; i <20; i++ ) {
				var clearState:int = 0;
				for (var j:int = 0; j <10; j++ ) {
					var newBrick:Sprite = this.drawBrick(0x000000);
					newBrick.x = j * brickWH;
					newBrick.y = i * brickWH;
					if(worldArr[i][j]==0){//添加空白方格
						var newBrick2:Sprite = this.drawBrick(0xE0E0E0);
						newBrick2.x = j * brickWH;
						newBrick2.y = i * brickWH;
						tetrisBrickArr.push(newBrick2);
						stage.addChild(newBrick2);
					}else if (worldArr[i][j] == 2) {//addChild已经下落的方格
						clearState++;
						var newBrick3:Sprite = this.drawBrick(0x787878);
						newBrick3.x = j * brickWH;
						newBrick3.y = i * brickWH;
						tetrisBrickArr.push(newBrick3);
						stage.addChild(newBrick3);
					}
					//把Tetris数组转换并addchild到舞台
					if (i <tetrisY + tetrisType.length
						&& i>= tetrisY
						&& j>= tetrisX
						&& j < tetrisX + tetrisType[0].length) {
						if (tetrisType[i - tetrisY ][j - tetrisX] == 1) {
							newBrick.graphics.beginFill(0x000000);
							tetrisBrickArr.push(newBrick);
							stage.addChild(newBrick);
						}
					}               
				}
				
				if (clearState>=10) {
					worldArr.splice(i, 1) ;
					worldArr.unshift([0,0,0,0,0,0,0,0,0,0]);
				}
			}
			
		}
		//清屏
		public function clearTetris():void {
			for (var i:int = 0; i <10;i++ ) {
				if (worldArr[0][i] == 2
					|| worldArr[1][i] == 2
					|| worldArr[2][i] == 2
					|| worldArr[3][i] == 2) {
					init();
					return;
				}
			}
			if (tetrisBrickArr.length> 0) {
				for ( i=0; i <tetrisBrickArr.length;i++ ) {
					stage.removeChild(tetrisBrickArr[i]);
				}
				tetrisBrickArr = [];
			}      
		}
		/*随机生成Tetris
		* 用一个4*4的数组存储
		* */
		public function createTetris():void {
			var randNum:Number = Math.random();
			tetrisType = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
			if (randNum <0.2) {
				tetrisType = [
					[0,0,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,1,0]
				];
			}else if (randNum <0.4) {
				tetrisType = [
					[0,0,0,0],
					[0,1,1,0],
					[0,1,1,0],
					[0,0,0,0],
				];
			}else if (randNum <0.6) {
				tetrisType = [
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0]
				];
			}else if (randNum <0.7) {
				tetrisType = [
					[0,0,0,0],
					[0,1,0,0],
					[1,1,1,0],
					[0,0,0,0]
				];
			}else if(randNum<0.8){
				tetrisType = [
					[0,0,0,0],
					[1,1,0,0],
					[0,1,1,0],
					[0,0,0,0],
				];
			}else {
				tetrisType = [
					[0,0,0,0],
					[0,1,1,0],
					[1,1,0,0],
					[0,0,0,0]
				];
			}
			tetrisX = 5; tetrisY = 0;
		}
		//翻转
		public function roll():void {
			//开始翻转
			var newTetris:Array = new Array(4);
			for ( var i:int=0; i <tetrisType.length; i++ ) {
				newTetris[i] = new Array(4);
				for (var j:int=0; j <tetrisType.length; j++ ) {
					newTetris[i][j] = tetrisType[(4-1)-j][i];
				}
			}
			//判断翻转后是否会与原有方块重合，如果重合return,不让翻转
			for ( i = 0; i <4;i++ ) {
				for ( j = 0; j <4; j++ ) {
					if (newTetris[i][j] == 1) {
						if (i+tetrisY>19) return;
						if (worldArr[i + tetrisY][j + tetrisX] == 2 ) return;
					}
				}
			}
			
			this.tetrisType = newTetris;
			
			//考虑在左右板边翻转超出舞台的情况
			getTempXy();
			if ( tetrisX + tempL <0 ) tetrisX = 0;
			if ( tetrisX + tempL+tetrisType[0].length-tempR>10 ) tetrisX = 10 - tetrisType[0].length-tempR;
		}
		
		public function move(lr:int, ud:int):void {
			getTempXy();
			var hit:Array = hitTest();
			if (this.tetrisX+tempL + lr>= 0 && this.tetrisX + lr-tempR <= 10 - tetrisType[0].length && hit[0]==0) {//左右移动
				this.tetrisX += lr;
			}
			
			if (hit[0] == 1 && hit[1] == 2 ) floor();//判断落地
			if(lr==0 && tetrisY-tempD+3<19) this.tetrisY += ud;//在场景内上下移动
		}
		/*碰撞检测
		* 对tetris里的每一个方格做检测
		* 返回array[0]:是否碰撞   array[1]:碰撞方向
		* */
		public function hitTest():Array {
			getTempXy();
			//检测左右是否有方格
			for (var i:int = 0; i <4;i++ ) {
				for (var j:int = 0; j <4;j++ ) {
					if (tetrisType[i][j] == 1) {
						if (moveType == 'l' || moveType == 'ro') {
							if (this.worldArr[i+tetrisY][j+tetrisX-1]==2) return [1,0];
						}
						if(moveType=='r' || moveType=='ro'){
							if (this.worldArr[i+tetrisY][j+tetrisX+1]==2) return [1,1];
						}
						if (moveType == 'd' || moveType=='ro') {
							if(i+tetrisY+1<20){
								if (this.worldArr[i + tetrisY + 1][j + tetrisX] == 2) return [1, 2];
							}
						}
					}
				}
			}
			//检测是否到下边界
			if (this.tetrisY  - tempD>= 20 - tetrisType.length && (moveType=="d" || moveType=='ro')) {
				return [1,2];
			}else {
				return [0,0];
			}
		}
		//落地
		public function floor():void {
			for ( var i:int = 0; i <4;i++ ) {
				for ( var j:int = 0; j <4;j++ ) {
					if (tetrisType[i][j] == 1) {
						this.worldArr[i + tetrisY ][j + tetrisX] = 2;
					}
				}
			}
			createTetris();//创建新的tetris
		}
		
		//计算tetris数组四周的空白距离
		public function getTempXy():void {
			var tempint1:int = 0;
			var tempint2:int = 0;
			var tempint3:int = 0;
			
			tempL = 0;
			for ( var j:int= 0; j <2;j++) {
				for (var i:int = 0; i <4; i++ ) {
					if (tetrisType[i][j] == 1 ) tempint1++;
				}
				if (tempint1 == 0) tempL ++;
			}
			
			tempR = 0;
			for (  j= 3; j>1;j-- ) {
				for ( i = 0; i <4; i++ ) {
					if (tetrisType[i][j] == 1 ) tempint2++;
				}
				if (tempint2 == 0) tempR ++;
			}
			
			tempD = 0;
			for ( j = 3; j>1;j-- ) {
				for ( i = 0; i <4; i++ ) {
					if (tetrisType[j][i] == 1 ) tempint3++;
				}
				if (tempint3 == 0) tempD ++;
			}
		}
		//绘出方格     
		public function drawBrick(color:uint):Sprite {
			var mySprite:Sprite = new Sprite();
			mySprite.graphics.beginFill(color);
			mySprite.graphics.lineStyle(1,0xffffff);
			mySprite.graphics.drawRect(0, 0, brickWH, brickWH);
			mySprite.graphics.endFill();
			return mySprite;
		}
	}
}