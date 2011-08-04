package tetris
{
	/**
	 *包含能够表明tetrad形状的字符串 
	 * @author zhouqin
	 * 
	 */
	public class TetradShape
	{
		/**
		 *tetrad的形状为I 
		 */
		public static var I:TetradShape = new TetradShape( "I" );
		/**
		 *tetrad 的形状为O
		 */
		public static var O:TetradShape = new TetradShape( "O" );
		/**
		 *tetrad 的形状为T
		 */
		public static var T:TetradShape = new TetradShape( "T" );
		/**
		 *tetrad 的形状为Z
		 */
		public static var Z:TetradShape = new TetradShape( "Z" );
		/**
		 *tetrad 的形状为S
		 */
		public static var S:TetradShape = new TetradShape( "S" );
		/**
		 *tetrad 的形状为L
		 */
		public static var L:TetradShape = new TetradShape( "L" );
		/**
		 *tetrad 的形状为F
		 */
		public static var F:TetradShape = new TetradShape( "F" );
		/**
		 *表示当前的tetrad
		 */
		public static var CURRENT:TetradShape = new TetradShape( "CURRENT" );
		/**
		 *表示cell没有tetrad
		 */
		public static var CLEAR:TetradShape = new TetradShape( "CLEAR" );
		/**
		 * 表示cell已经超出了边界
		 */
		public static var OUT:TetradShape = new TetradShape( "OUT" );
		/**
		 *表明cell的形状 
		 */
		public static var shapeString:String;
		
		/**
		 *构造函数 
		 * @param shape
		 * 
		 */
		public function TetradShape(shape:String)
		{
			shapeString = shape;
		}
	}
}