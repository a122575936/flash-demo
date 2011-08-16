package code.app
{
	import code.mvc.view.SceneView;
	import code.mvc.view.scene.CityWorld;
	
	import com.fminutes.vinciMVC.view.AppContainer;
	import flash.display.Stage;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author lipi
	 * 程序容器,视图层入口.程序中的视图均存在此类中,外部通过AppView向显示列表添加元素
	 */
	public class AppView extends AppContainer
	{
		public function AppView()
		{
			if(_instance==null)
			{
				super();
				_instance = this;
			}else{
				throw new Error("实例化单例类出错-AppView");
			}
		}
		
		override public function init(appStage:Stage, mainSprite:Sprite):void
		{
			super.init(appStage, mainSprite);
		}
		
		private static var _instance:AppView;
		public static function getInstance():AppView
		{
			if(_instance == null)
				_instance = new AppView();
			
			return _instance;
		}
		
		public function get cityWorld():CityWorld 
		{
			return sceneView.sceceContainer.cityWorld;
		}
		
		private var _sceneView:SceneView;
		public function get sceneView():SceneView { return _sceneView; }
		
		public function set sceneView(value:SceneView):void
		{
			if (_sceneView == value)
				return;
			_sceneView = value;
		}
		
	}
}