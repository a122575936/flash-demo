package code.mvc.view
{
	import code.mvc.view.scene.CityWorld;
	import code.mvc.view.scene.SceneContainer;
	
	import com.fminutes.vinciUI.containers.RollContainer;
	
	
	/**
	 *场景视图，可拖动，部分显示场景 
	 * @author zhouqin
	 * 
	 */
	public class SceneView extends RollContainer
	{
		private var _sceceContainer:SceneContainer;
		public function get cityWorld():CityWorld 
		{
			return sceceContainer.cityWorld;
		}
		public function get sceceContainer():SceneContainer { return _sceceContainer; }
		
		public function set sceceContainer(value:SceneContainer):void
		{
			if (_sceceContainer == value)
				return;
			_sceceContainer = value;
		}
		
		public function SceneView(width:int, height:int)
		{
			super();
			this.width = width;
			this.height = height;
			
			init();
		}
		
		protected function init():void
		{
			_sceceContainer = new SceneContainer();
			addChild(_sceceContainer);
			
			_sceceContainer.x = (width - _sceceContainer.width) / 2;
			_sceceContainer.y = (height - _sceceContainer.height) / 2;
		}
		
		private function setCenter():void
		{
			var gridCount:int = Math.ceil(Math.sqrt(100));
			rool((_sceceContainer.width - width)/2, (_sceceContainer.height - height)/2 - gridCount * CityWorld.GRID_SIZE * CityWorld.GRID_GROUP - 300);
		}
		
		/**
		 * 移动可视框, 修改可视区域
		 * @param left
		 * @param top
		 */
		public function rool(left:Number, top:Number):void
		{
			this.left = left;
			this.top = top;
			
			reRoll();
		}
	}
}