package
{
	import code.app.AppControllerList;
	import code.app.AppModelList;
	import code.app.AppView;
	
	import com.fminutes.vinciBase.App;
	import com.fminutes.vinciMVC.view.AppContainer;
	import com.fminutes.vinciUI.manager.UIManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import log.Logger;

	public class main extends Sprite
	{
		public function main()
		{
			Logger.debug();
			super();
			if (this.stage)
			{
				init();
			}else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, addToStage);
			}
		}
		
		private function addToStage(e:Event):void
		{
			Logger.debug(e);
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStage);
			init();
		}
		
		protected function init():void
		{
			Logger.debug();
			AppView.getInstance().init(App.appStage, this);
			
			UIManager.getDragManager().parent = AppView.getInstance().mouseLayer;
			UIManager.getMouseManager().parent = AppView.getInstance().mouseLayer;
			UIManager.getPopUpManager().parent = AppView.getInstance().popupLayer;
			UIManager.getToolTipManager().parent = AppView.getInstance().tipLayer;
			UIManager.getToolTipManager().popTipsParent = AppView.getInstance().popupLayer;
			UIManager.getFullScreenPanelManager().parent = AppView.getInstance().panelLayer;
			
			AppControllerList.getInstance().appController.start();
		}
	}
}