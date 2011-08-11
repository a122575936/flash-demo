package {
	import flash.display.Sprite;
	
	import log.Logger;
	
	[SWF(width="480", height="640",backgroundColor=0xEEEEEE)]
	public class Test extends Sprite {
		
		public function Test():void {
			Logger.error("出错啦！！！");
		}
	}
}