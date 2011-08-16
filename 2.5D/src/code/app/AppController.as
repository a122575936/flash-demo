package code.app
{
	
	import com.fminutes.vinciBase.App;
	import com.fminutes.vinciBase.VinciSprite;
	import com.fminutes.vinciIsometric.scene.SceneBase;
	import com.fminutes.vinciMVC.controller.Controller;
	
	/**
	 * 
	 * @author lipi
	 * 程序初始控制器.在程序加载完成,服务器连接完毕后将调完该类的start();
	 */
	public class AppController extends Controller
	{
		public function AppController()
		{
			super();
		}
		
		override public function start():void
		{
			super.start();
			AppControllerList.getInstance().sceneController.start();
		}
	}
}