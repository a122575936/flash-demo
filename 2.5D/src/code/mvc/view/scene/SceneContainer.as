package code.mvc.view.scene
{
	import code.app.AppView;
	import code.mvc.view.layer.DiyLayer;
	
	import com.fminutes.vinciBase.App;
	import com.fminutes.vinciBase.VinciSprite;
	import com.fminutes.vinciUI.general.VinciFont;
	
	/**
	 *场景容器 
	 * @author zhouqin
	 * 
	 */
	public class SceneContainer extends VinciSprite
	{
		//场景宽高
		public static const SCENE_W:Number=2644;
		public static const SCENE_H:Number=1612;
		private var _diyLayer:DiyLayer;
		private var _cityWorld:CityWorld;
		private var _mouseLayer:VinciSprite;
		
		public function get mouseLayer():VinciSprite { return _mouseLayer; }
		
		public function set mouseLayer(value:VinciSprite):void
		{
			if (_mouseLayer == value)
				return;
			_mouseLayer = value;
		}
		
		public function get cityWorld():CityWorld { return _cityWorld; }
		
		public function set cityWorld(value:CityWorld):void
		{
			if (_cityWorld == value)
				return;
			_cityWorld = value;
		}
		
		public function SceneContainer()
		{
			super();
			
			init();
		}
		
		protected function init():void
		{
			_cityWorld = new CityWorld();
			_diyLayer = new DiyLayer();
			_mouseLayer = getMouseLayer(App.appStage.stageWidth, App.appStage.stageHeight);
			
			addChild(_cityWorld);
			addChild(_diyLayer);
			AppView.getInstance().mouseLayer.addChild(_mouseLayer);
		}
		
		/**
		 * @private
		 * 生成鼠标层
		 */
		private function getMouseLayer(w:Number, h:Number):VinciSprite
		{
			var sm:VinciSprite = new VinciSprite();
			sm.graphics.beginFill(0x000000, 0);
			sm.graphics.drawRect(0, 0, w, h);
			sm.graphics.endFill();
			return sm;
		}
		
		public function get diyLayer():DiyLayer { return _diyLayer; }
		
		public function set diyLayer(value:DiyLayer):void
		{
			if (_diyLayer == value)
				return;
			_diyLayer = value;
		}
	}
}