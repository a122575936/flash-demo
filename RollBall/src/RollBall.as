package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard; 
	
	public class RollBall extends Sprite
	{
		private var ball:Sprite; 
		private var speed:Number = 1;
		private var isMoving:Boolean = true;  //if ball is moving
		
		
		public function RollBall()
		{
			init();
		}
		
		//if speed is valid
		public function checkSpeed():void
		{
			if(speed  <=  0)
				speed = 1;
		}
		
		private function init():void { 
			ball = new Sprite(); 
			addChild(ball); 
			ball.graphics.beginFill(0xff0000); 
			ball.graphics.drawCircle(0, 0, 40); 
			ball.graphics.endFill(); 
			ball.x = 20; 
			ball.y = stage.stageHeight / 2; 
			ball.addEventListener(Event.ENTER_FRAME, onEnterFrame); 
			ball.addEventListener(MouseEvent.ROLL_OVER, onRollOverBall);
			ball.addEventListener(MouseEvent.ROLL_OUT, onRollOutBall);
			ball.addEventListener(MouseEvent.CLICK, onClickBall);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyboardEvent); 
		} 
		
		//mouse roll over ball
		public function onRollOverBall(event:MouseEvent):void { 
			ball.useHandCursor = true;
			ball.mouseChildren = false;
			ball.buttonMode = true;
		} 
		
		//mouse roll out ball
		public function onRollOutBall(event:MouseEvent):void { 
			trace(event.type); 
		} 
		
		//mouse click  ball
		public function onClickBall(event:MouseEvent):void { 
			if(isMoving){
				isMoving = false;
				ball.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			}
			else{
				isMoving = true;
				ball.addEventListener(Event.ENTER_FRAME, onEnterFrame); 
			}
		} 
		
		private function onEnterFrame(event:Event):void { 
			ball.x += speed; 
			
			//ball was out of right of stage
			if(ball.x > stage.stageWidth) { 
				ball.x = 20;
			}
		}
		
		public function onKeyboardEvent(event:KeyboardEvent):void { 
			switch (event.keyCode) { 
				case Keyboard.UP : 
					speed += 1; 
					break; 
				case Keyboard.DOWN : 
					speed -= 1; 
					checkSpeed();
					break; 
			}
		} 
	}
}