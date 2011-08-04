package controller
{
	import flash.display.Sprite;
	import flash.utils.Timer;

	/**
	 *这是游戏的主要接口
	 * 所有的用户交互都是通过这个类 
	 * @author zhouqin
	 * 
	 */
	public class Controller
	{
		public function Controller()
		{
			private var _tetris:Tetris2;
			private var _score:uint;
			private var _speed:Number;
			private var _keyTimer:Timer;
			private var _playTimer:Timer;
			private var _clip:Sprite;
			
		}
	}
}