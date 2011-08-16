package
{
	import code.app.AppController;
	import code.app.AppControllerList;
	
	import com.fminutes.vinciBase.App;
	import com.fminutes.vinciDll.Dll;
	import com.fminutes.vinciDll.DllEvent;
	import com.fminutes.vinciDll.DllFileObject;
	import com.fminutes.vinciDll.FileObject;
	import com.fminutes.vinciDll.MultiLoader;
	import com.fminutes.vinciDll.MultiLoaderEvent;
	import com.fminutes.vinciMVC.view.AppContainer;
	import com.fminutes.vinciNet.PlatformFlashValue;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.ui.ContextMenu;
	import flash.utils.ByteArray;
	
	import log.Logger;

	/**
	 * @author lipi
	 * 程序入口。
	 */
	[SWF(width="720", height="650",backgroundColor=0xEEEEEE)]
	public class entry extends Sprite
	{
		public function entry()
		{
			Logger.debug();
			super();
			setStage();
			App.appStage = this.stage;
			
			if(stage.stageWidth > 0 && stage.stageHeight>0)
			{
				init();
			}else{
				stage.addEventListener(Event.RESIZE,onResize);
			}
		}
		
		private function onResize(e:Event):void
		{
			if(stage.stageWidth > 0 && stage.stageHeight>0)
			{
				stage.removeEventListener(Event.RESIZE,onResize);
				init();
			}
		}
		
		private function init():void
		{
			PlatformFlashValue.value = this.stage.loaderInfo.parameters;
			
			Dll.getInstance().addEventListener(DllEvent.LOADING_COMPLETE,loadingComplete);
			Dll.getInstance().addEventListener(DllEvent.PROGRESS,loadingProgress);
			Dll.getInstance().addEventListener(DllEvent.COMPLETE,allComplete);
			Dll.getInstance().loadINIXML(["ini.xml","outini.xml"])
		}
		
		private function allComplete(e:DllEvent):void
		{
			Logger.debug(e);
			Dll.getInstance().removeEventListener(DllEvent.PROGRESS,mainProgress);
			// 根据名字 加载 返回 loader
			addChild(Dll.getInstance().getLoaderByName("main"));
			// 主 ApplicationDomain  
			Logger.info("mainAppDomain",Dll.getInstance().mainAppDomain as ApplicationDomain);
//			var testObjec:Object = 
			//addChild(Dll.getInstance().getLoaderByName("ui"));
		}
		
		private function loadingComplete(e:DllEvent):void
		{
			Logger.debug(e);
			Dll.getInstance().removeEventListener(DllEvent.PROGRESS,loadingProgress);
			Dll.getInstance().addEventListener(DllEvent.PROGRESS,mainProgress);
		}
		
		
		private function loadingProgress(e:DllEvent):void
		{
			Logger.info("loading.....",e.data["progress"]);
		}
		
		private function mainProgress(e:DllEvent):void
		{
			Logger.info("mainProgress.....",e.data["progress"]);
		}
		
		/**
		 * 设置stage属性
		 */
		private function setStage():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 24;
			var contextMenu:ContextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
//			var contextMenuItem:ContextMenuItem = new ContextMenuItem("20100430_05",false,false);
//			contextMenu.customItems.push(contextMenuItem);
//			this.contextMenu = contextMenu;
		}
	}
}