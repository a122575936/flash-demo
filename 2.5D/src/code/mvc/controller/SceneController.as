package code.mvc.controller
{
	import code.app.AppView;
	import code.mvc.view.SceneView;
	
	import com.fminutes.vinciBase.App;
	import com.fminutes.vinciBase.VinciSprite;
	import com.fminutes.vinciDll.IniToFlieList;
	import com.fminutes.vinciMVC.controller.Controller;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flashx.textLayout.elements.BreakElement;
	
	import log.Logger;
	
	/**
	 *场景控制器 
	 * @author zhouqin
	 * 
	 */
	public class SceneController extends Controller
	{
		private var _mousePosition:Point;
		private var _scenePosition:Point;
		public function SceneController()
		{
			super();
		}
		
		override public function start():void
		{
			super.start();
			init();
			initListener();
		}
		
		private function initListener():void
		{
			var _mouseLayer:VinciSprite = AppView.getInstance().sceneView.sceceContainer.mouseLayer;
			_mouseLayer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			_mouseLayer.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
			_mouseLayer.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			_mouseLayer.addEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			_mouseLayer.addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
		}
		
		/**
		 *鼠标事件处理函数 
		 * @param event
		 * 
		 */
		protected function onMouseEvent(e:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var sceneView:SceneView = AppView.getInstance().sceneView;
			
			Logger.level = Logger.LEVEL_INFO;
			Logger.debug(e.type);
			Logger.info(sceneView.width, sceneView.height);
			switch(e.type)
			{
				//鼠标事件
				case MouseEvent.MOUSE_DOWN:
					
					_mousePosition = new Point(e.stageX, e.stageY);
					_scenePosition = new Point(sceneView.left, sceneView.top);
					break;
				case MouseEvent.MOUSE_MOVE:
					if (e.buttonDown && _mousePosition && _scenePosition)
					{
						var point:Point = new Point(e.stageX, e.stageY);
						point = point.subtract(_mousePosition);
						point = _scenePosition.clone().subtract(point);
						sceneView.rool(point.x, point.y);
					}
					//调用2.5D世界移动方法
					sceneView.cityWorld.executeMouseOver(e);
					break;
				case MouseEvent.MOUSE_UP:
					sceneView.cityWorld.executeClick(e);
					break;
				case MouseEvent.MOUSE_OVER:
					break;
				case MouseEvent.MOUSE_OUT:
					break;
				default:
					break;
			}
		}
		
		/**
		 *初始化场景 
		 * 
		 */
		protected function init():void
		{
			if(!AppView.getInstance().sceneView)
				AppView.getInstance().sceneView = new SceneView(App.appStage.stageWidth, App.appStage.stageHeight);
			
			AppView.getInstance().sceneLayer.addChild(AppView.getInstance().sceneView);
			AppView.getInstance().sceneView.sceceContainer.cityWorld.isoGridVisible = true;
		}
	}
}