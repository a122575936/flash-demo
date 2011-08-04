package
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	/**
	 *素材加载器 
	 * @author zhouqin
	 * 
	 */
	public class MaterialLoader
	{
		/**
		 * MaterialLoader的唯一实例
		 */
		public static var _materialLoader:MaterialLoader;
		
		private var _loader:Loader;
		private var _appDomain:ApplicationDomain;
		
		private function MaterialLoader()
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			var uriReq = new URLRequest("Blox.swf");
		}
		
		private function onComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			_appDomain = loaderInfo.applicationDomain;
		}
		
		public function getMat(className:String):Object
		{
			var c:Class = _appDomain.getDefinition(className);
			return new c();
		}
		
		public function getInstance():MaterialLoader
		{
			if (_materialLoader == null) 
			{
				_materialLoader
			}
		}
	}
}