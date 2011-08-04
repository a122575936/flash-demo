package tetris
{
	/**
	 *管理一个cell在游戏中的状态 
	 * @author zhouqin
	 * 
	 */
	public class Cell
	{
		/**
		 *cell 在游戏区域中的位置 
		 */
		public var location:CellPos;
		
		/**
		 *cell的状态 
		 */
		public var state:CellState;
		
		public function Cell( l:CellPos, s:CellState)
		{
			location = l;
			state = s;
		}
	}
}