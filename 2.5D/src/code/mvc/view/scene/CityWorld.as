package code.mvc.view.scene
{
	import code.mvc.view.scene.iso.WallIsoObject;
	
	import com.fminutes.vinciIsometric.core.IsoWorld;
	
	/**
	 *2.5D城市 
	 * @author zhouqin
	 * 
	 */
	public class CityWorld extends IsoWorld
	{
		/**
		 * 2.5D世界的最大网格数
		 */
		public static const WORLD_SIZE:int = 10;
		/**
		 * 2.5D世界的格子尺寸
		 */
		public static const GRID_SIZE:int = 16;
		/**
		 * 最小格子数
		 */
		public static const GRID_GROUP:int = 2;
		
		private var _walls:Vector.<WallIsoObject>;
		public function get walls():Vector.<WallIsoObject> { return _walls; }
		
		public function set walls(value:Vector.<WallIsoObject>):void
		{
			if (_walls == value)
				return;
			_walls = value;
		}
		
		
		public function CityWorld()
		{
			super(WORLD_SIZE, WORLD_SIZE, GRID_SIZE);
		}
		
		public function addWall(wall:WallIsoObject):void
		{
			if (!_walls) 
			{
				_walls = new Vector.<WallIsoObject>();
			}
			
			_walls.push(wall);
			addToWorld(wall);
		}
	}
}