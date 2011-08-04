package code
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class Cube extends Sprite
	{
		/**
		 * 方块颜色 
		 */		
		public var color:int;
		/**
		 * 在游戏格子区域中x轴坐标 
		 */		
		public var position_x:int = 0;
		/**
		 * 在游戏格子区域中y轴坐标 
		 */		
		public var position_y:int = 0;
		/**
		 * 在形状方块中以旋转点（0,0）为原点x轴坐标
		 */		
		public var shape_x:int;
		/**
		 * 在形状方块中以旋转点（0,0）为原点y轴坐标
		 */		
		public var shape_y:int;
		
		/**
		 * 
		 * @param i 颜色
		 * @param b 位图数据
		 * 
		 */
		public function Cube(i:int,b:BitmapData)
		{
			super();
			this.color = i;			
			position_x = this.x;
			position_y = this.y;
			addChild(new Bitmap(b));
		}
	}
}