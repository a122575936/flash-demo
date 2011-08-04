package
{
	import flash.display.Sprite;
	
	import screen.GameScreen;
	
	[SWF(width="480", height="640",backgroundColor=0xEEEEEE)]
	public class MyTetrid extends Sprite
	{
		public function MyTetrid()
		{
			initView();
		}
		
		private function initView():void
		{
			// TODO Auto Generated method stub
			var gameScreen:GameScreen = new GameScreen();
			addChild(gameScreen);
		}
	}
}