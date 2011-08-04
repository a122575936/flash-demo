package
{
	/**
	 *定义游戏的配置 
	 * 
	 */
	public class TetrisConfig
	{
		/**
		 *每消一行得多少分 
		 */
		public static var scorePerLine:uint = 10;
		/**
		 * 游戏进行的速度
		 * 0 < acceleration <= 1
		 * 1表示没有速度
		 * 越小速度越快
		 */
		public static var acceleration:Number = 1;
		/**
		 *游戏的初始速度
		 * tetrad每下一格所用的时间
		 * 单位是毫秒
		 */
		public static var startSpeed:Number = 400;
		/**
		 *向左的键盘码
		 * 0表示没有 
		 */		
		public static var keyLeft:uint = 0;
		/**
		 *向右的键盘码
		 * 0表示没有 
		 */	
		public static var keyRight:uint = 0;
		/**
		 * 让tetrad向左旋转的键盘码
		 * 0表示没有
		 */
		public static var keyRotLeft:uint = 0;
		/**
		 * 让tetrad向右旋转的键盘码
		 * 0表示没有
		 */
		public static var keyRotRight:uint = 0;
		/**
		 * 让tetrad加速下降的键盘码
		 * 0表示没有
		 */
		public static var keyDrop:uint = 0;
		/**
		 *游戏区域有多宽
		 * 以cell为单位 
		 */
		public static var playWidth:uint = 0;
		/**
		 *游戏区域有多高
		 * 以cell为单位 
		 */
		public static var playHeught:uint = 0;
		/**
		 *cell的高和宽 
		 */
		public static var blockSize:uint = 0;
		/**
		 *游戏的x坐标 
		 */
		public static var gameX:uint = 0;
		/**
		 *游戏的y坐标 
		 */
		public static var gameY:uint = 0;
		/**
		 *显示下一个tetrad区域的x坐标 
		 */
		public static var nextX:uint = 0;
		/**
		 *显示下一个tetrad区域的y坐标 
		 */
		public static var nextY:uint = 0;
		
		public function TetrisConfig()
		{
			
		}
		
	}
}