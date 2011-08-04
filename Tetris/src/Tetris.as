package
{
	import code.Box;
	import code.Cube;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Tetris extends Sprite
	{
		/**
		 * 下降速度 
		 */		
		private var delay:uint = 500;
		private var myTimer:Timer = new Timer(delay);
		private var speed:int = 500;
		
		/**
		 * 当前下降方块 
		 */		
		private var fall:Box;
		/**
		 * 落地方块数据层 
		 */		
		private var floorArray:Array;
		/**
		 * 落地方块显示层 
		 */		
		private var floorShape:Array;
		/**
		 * 右边显示的下一个方块 
		 */		
		private var showNext:Box;
		/**
		 * 右边显示的得分 
		 */		
		private var score:TextField;
		private var scoreData:int;
		
		/**
		 * 落地显示层的索引 
		 */		
		private var indexFloor:int = 0;
		
		/**
		 * 所有载入的素材 
		 */		
		public var bitmaps:Array;		
		private var loader:Loader;
		
		public function Tetris()
		{
			loadSwf();			
		}
		
		public function loadSwf():void
		{
			bitmaps = new Array();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,comp);
			loader.load(new URLRequest("blue.swf"));
			loader.load(new URLRequest("cyan.swf"));
			loader.load(new URLRequest("green.swf"));
			loader.load(new URLRequest("orange.swf"));
			loader.load(new URLRequest("purple.swf"));
			loader.load(new URLRequest("red.swf"));	
			loader.load(new URLRequest("yellow.swf"));
		}
		
		private function comp(e:Event):void
		{
			var TereisBoxBgBlue:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgBlue") as Class;
			var TereisBoxBgCyan:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgCyan") as Class;
			var TereisBoxBgGreen:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgGreen") as Class;
			var TereisBoxBgOrange:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgOrange") as Class;	
			var TereisBoxBgPurple:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgPurple") as Class;
			var TereisBoxBgRed:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgRed") as Class;
			var TereisBoxBgYellow:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("TetrisBoxBgYellow") as Class;
			
			var b:BitmapData = new TereisBoxBgBlue(24,24);
			var c:BitmapData = new TereisBoxBgCyan(24,24);
			var g:BitmapData = new TereisBoxBgGreen(24,24);
			var o:BitmapData = new TereisBoxBgOrange(24,24);
			var p:BitmapData = new TereisBoxBgPurple(24,24);
			var r:BitmapData = new TereisBoxBgRed(24,24);
			var y:BitmapData = new TereisBoxBgYellow(24,24);
			
			this.bitmaps[0] = b;
			this.bitmaps[1] = c;
			this.bitmaps[2] = g;
			this.bitmaps[3] = o;
			this.bitmaps[4] = p;
			this.bitmaps[5] = r;
			this.bitmaps[6] = y;
    
			init();
			show();
			myTimer.addEventListener(TimerEvent.TIMER,timerHandle);
			myTimer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyboard);
		}	
	
		private function init():void
		{
		    score = new TextField();
			floorShape = new Array();
			floorArray = new Array();
			for(var i:int = 0;i<15;i++)
			{
				floorArray.push(new Array());
				floorShape.push(new Array());
				
				for(var j:int = 0;j<15;j++)
				{
					floorArray[i][j] = 0;
				}
			}
		}	
		
		private function show():void
		{
			this.drawBackground();
			showNext = createNext();;
			fall = newBox();
			scoreData = 0;
			score.text = scoreData.toString();
			score.x = 24 *18;
			score.y = 24* 8;
			
			this.addChild(score);
			this.addChild(fall);
			this.addChild(showNext);
		}	
	
		private function newBox():Box
		{
			var f:Box;
			
			f = new Box(showNext.typeShape,showNext.type);
			
			var random:int = Math.floor(Math.random() * 14)*24 +24;
			f.x = 24;
			for(var i:int;i<4;i++)
			{
				f.shape[i].position_x++;
			}
			return f;
		}
		
		private function createNext():Box
		{
			var random:int = Math.floor(Math.random()*7);
			var randomShape:int = random*10+10;
			var f:Box = new Box(randomShape,bitmaps[random]);
			
			f.x = 24 * 17;
			f.y = 24 * 3;
			return f;
		}
		
		/**
		 * 下降 速度重置 游戏结束判断 落地后数据层设置 重新产生方块
		 * 
		 */		
		private function timerHandle(event:TimerEvent):void
		{
			if(checkCollision()==false)
			{
				fall.moveDown();
			}
			else
			{
				myTimer.delay = speed;
				for(var i:int = 0;i<4;i++)
				{					
					if((fall.shape[i].position_y + fall.shape[i].shape_y)<=0)
						gameOver();		
					else
						for(i = 0;i<4;i++)
							floorArray[fall.shape[i].position_y + fall.shape[i].shape_y][fall.shape[i].position_x + fall.shape[i].shape_x] = fall.shape[i].color;
				}
				refreshFloor(fall.type);
				
				this.removeChild(fall);
				this.removeChild(showNext);
				while(remove())
					remove();
				fall = newBox();
				showNext = createNext();
				this.addChild(showNext);
				this.addChild(fall);
			}
		}
		
		
		/**
		 * 落地后重绘落地方块
		 * 
		 */
		private function refreshFloor(t:BitmapData):void
		{		
			for(var i:int = 0;i<15;i++)
				for(var j:int = 0;j<15;j++)
				{
					if(floorArray[j][i] !=0 )
					{
						var c:Cube = new Cube(floorArray[j][i],this.bitmaps[(floorArray[j][i]-10)/10]);
						c.x = i * 24;
						c.y = j * 24;
						floorShape[indexFloor] = c;
						this.addChild(floorShape[indexFloor]);
						indexFloor++;
					}
				}
		}
		
		private function drawBackground():void
		{
			var _back:Shape = new Shape();
			_back.graphics.beginFill(0x000000,1.);
			_back.graphics.drawRect(0,0,24*15,24*15);
			_back.graphics.endFill();
			this.addChild(_back);
		}
		
		/**
		 * 消除方块检测
		 * 
		 */
		private function remove():Boolean
		{
			var chain:Array = new Array();
			for(var i:int=14;i>=0;i--)
			{
				var sum:int = 0;
				var flag:int = 1;
				var counter:int = 0;

				for(var j:int = 0;j<15;j++)
				{
					if(floorArray[i][j]==0)
						flag = 0;
				}
				if(flag!=0)
				{
					counter++;
					removeAction(i);
					scoreData+=10;
					score.text = scoreData.toString();
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 数据层移除 和 显示层移除
		 * @param a 第a行该移除
		 * 
		 */		
		private function removeAction(a:int):void
		{
			for(var i:int=a;i>=1;i--)
			{
				for(var j:int= 0;j<15;j++)
				{
					floorArray[i][j] = floorArray[i-1][j];
				}
			}
			var iof:int = indexFloor;
			if(indexFloor>0)
			{
				for(var f:int = 0;f<iof;f++)
				{
					this.removeChild(this.floorShape[f]);
					indexFloor--;
				}
				
			}
			for(i = 0;i<15;i++)
				for(j = 0;j<15;j++)
				{
					if(floorArray[j][i] !=0)
					{
						var c:Cube = new Cube(floorArray[j][i],this.bitmaps[(floorArray[j][i]-10)/10]);
						c.x = i * 24;
						c.y = j * 24;
						floorShape[indexFloor] = c;
						this.addChild(floorShape[indexFloor]);
						indexFloor++;
					}
				}			
		}
		
		/**
		 * 	可移动检测 和 键盘控制
		 * 
		 */
		private function keyboard(event:KeyboardEvent):void
		{
			var keyFlag:Boolean = true;
			for each (var b:Cube in fall.shape)
				if(b.position_y+b.shape_y<0)
					keyFlag = false;
			
			if(keyFlag)
			{
				switch(event.keyCode)
				{
					case Keyboard.LEFT:
						var leftable:Boolean = true;
						for each (var c:Cube in fall.shape)
						{
							if((c.position_x + c.shape_x)-1<0||floorArray[c.position_y + c.shape_y][c.position_x + c.shape_x-1]!=0)
								leftable = false;
						}
						if(leftable)
							fall.moveLeft();
						break;
					case Keyboard.RIGHT:
						var rightable:Boolean = true;
						for each (var u:Cube in fall.shape)
						{
							if((u.position_x + u.shape_x)+1>14||floorArray[u.position_y + u.shape_y][u.position_x + u.shape_x+1]!=0)
								rightable = false;
						}
						if(rightable)
							fall.moveRight();
						break;
					case Keyboard.UP:
						fall.rotate();
						break;
					case Keyboard.DOWN:
						myTimer.delay = 10;
						break;
					default:
						break;
				}
			}
		}

		/**
		 *碰撞检测,落地检测	 
		 */		
		private function checkCollision():Boolean
		{
			
			for(var i:int = 0;i<4;i++)
				if(fall.shape[i].position_y+fall.shape[i].shape_y+1>=15)
				{
					return true;	
				}

			if(checkCubeCol())
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 块与块碰撞检测
		 * 
		 */		
		private function checkCubeCol():Boolean
		{
			for(var i:int = 0;i<4;i++)
			{
				if(floorArray[fall.shape[i].position_y + fall.shape[i].shape_y+1][fall.shape[i].position_x + fall.shape[i].shape_x]!=0)
				{
					return true;
				}
			}			
			return false;
		}
		
		private function gameOver():void
		{
			myTimer.stop();
			var showlost:TextField = new TextField();
			showlost.text = "You Lose!";
			showlost.x = 24*17;
			showlost.y = 24*9;
			showlost.backgroundColor = 0xFFFFFF;
			this.addChild(showlost);
		}
		
	}
}