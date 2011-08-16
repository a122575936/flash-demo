package code.app
{
	import com.fminutes.vinciMVC.controller.ControllerList;
	import code.mvc.controller.SceneController;
	
	/**
	 * @author lipi
	 * 存储所有 Controller实例
	 */
	public class AppControllerList extends ControllerList
	{
		public function AppControllerList()
		{
			if(_instance==null)
			{
				super();
				_instance = this;
			}else{
				throw new Error("实例化单例类出错-AppControllerList");
			}
		}
		
		
		
		private static var _instance:AppControllerList;
		public static function getInstance():AppControllerList
		{
			if(_instance == null)
				_instance = new AppControllerList();
			
			return _instance;
		}
		
		
///////////////////////////////////////////////实例
		
		public var appController:AppController = new AppController();
		/**
		 * 场景控制器
		 */
		public var sceneController:SceneController=new SceneController();
	}
}