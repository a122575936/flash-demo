package event
{
	import flash.display.Shape;
	import flash.events.Event;
	
	import org.osmf.events.FacetValueChangeEvent;
	
	import tetris.TetradShape;

	/**
	 *游戏的主要事件 
	 * @author zhouqin
	 * 
	 */
	public class TetrisEvent extends Event
	{
		/**
		 *当游戏结束时出触发此事件 
		 * 没有什么被添加到事件对象
		 * 
		 */
		public static const GAME_OVER:String = "gameOver";
		/**
		 *当next tetrad改变时触发此事件 
		 * shape属性为新的tetrad
		 */
		public static const UPDATE_NEXT:String = "updateNext";
		/**
		 *当cells在游戏区域改变状态时触发此事件
		 *  
		 */
		public static const UPDATE_CELLS:String = "updateCells";
		/**
		 *挡在游戏区域消除lines是触发此事件
		 * lines属性为消除的行数 
		 */
		public static const LINES_REMOVED:String = "linesRemoved";
		/**
		 *当玩家移动tetrad后触发此事件 
		 */
		public static const TETRAD_MOVED:String = "tetradMoved";
		/**
		 *当游戏分数改变是触发此事件
		 * score属性为游戏的新分数 
		 */
		public static const SCORE_CHANGE:String = "scoreChange";、
		
		public var shape:TetradShape;
		public var lines:uint;
		public var cells:Array;
		public var score:uint;
		
		public function TetrisEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		public function clone():Event
		{
			var e:TetrisEvent = new TetrisEvent( type, bubbles, cancelable );
			e.shape = shape;
			e.lines = lines;
			e.cells = cells;
			e.score = score;
			
			return e;
		}
	}
}