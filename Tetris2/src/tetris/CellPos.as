package tetris
{
	/**
	 *cell在游戏区域中的坐标 
	 * @author zhouqin
	 * 
	 */
	public class CellPos
	{
		/**
		 *x坐标 
		 */
		public var x:Number;
		/**
		 *y坐标 
		 */
		public var y:Number;
		
		/**
		 *构造函数 
		 * @param x
		 * @param y
		 * 
		 */
		public function CellPos( x:Number, y:Number )
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 *设置cell的位置 
		 * @param p
		 * 
		 */
		public function assign( p:CellPos ):void
		{
			if ( this != p )
			{
				x = p.x;
				y = p.y;
			}
			return this;
		}
		
		/**
		 * 求两个cellpos的和
		 * @param u
		 * @param v
		 * @return 
		 * 
		 */
		public static function sum( u:CellPos, v:CellPos ):CellPos
		{
			return new CellPos( u.x + v.x, u.y + v.y );
		}
		
		/**
		 *将cellPos旋转到左边 
		 * @return 
		 * 
		 */		
		public function rotateLeft():CellPos
		{
			return new CellPos( y, -x );	
		}
		
		public function rotateLeftOffset():CellPos
		{
			return new CellPos( y, 1 - x);	
		}
		
		/**
		 *将cellpos旋转到右边 
		 * @return 
		 * 
		 */
		public function rotateRight():CellPos
		{
			return new CellPos( -y, x );
		}
	}
}