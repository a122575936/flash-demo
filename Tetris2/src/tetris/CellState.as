package tetris
{
	/**
	 *代表一个cell的状态 
	 * @author zhouqin
	 * 
	 */
	public class CellState
	{
		/**
		 *cell中tetrad的形状 
		 */
		public var shape:TetradShape;
		
		/**
		 *tetrad的那一部分在cell中 
		 * 从1-4的数字
		 */
		public var number:uint;
		
		/**
		 *旋转的角度 
		 */
		public var rotationDegree:int;
		
		public function CellState( shape:TetradShape, number:uint, rotation:int )
		{
			this.shape = shape;
			this.number = number;
			this.rotationDegree = rotation;
		}
	}
}