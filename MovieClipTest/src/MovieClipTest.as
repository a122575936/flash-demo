package
{
	import display.BitmapMovieClip;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	public class MovieClipTest extends Sprite
	{
		/**
		 *场景 
		 */		
		private var _sceneLoader:Loader = new Loader();
		private var _appDomain:ApplicationDomain;
		/**
		 *战斗胜利图像 
		 */
		public static const  CIRCLE_MOVING:String = "Cross";
		
		public function MovieClipTest()
		{
			initView();
		}
		
		private function initView():void
		{		
			_sceneLoader.load(new URLRequest("files/打劫弹出框.swf"));
			_sceneLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
		}
		
		/**
		 *loader完成时处理 
		 * @param e
		 * 
		 */
		private function onCompleteHandler(e:Event):void{  
			var contextInfo:LoaderInfo = e.target as LoaderInfo;
			_appDomain = contextInfo.applicationDomain;
			
			var bmpMc:BitmapMovieClip = new BitmapMovieClip(getMat(CIRCLE_MOVING) as MovieClip);
			addChild(bmpMc);
			//addChild(getMat(FIGHTING_IMAGE_WIN) as MovieClip);
			_sceneLoader.x = (stage.stageWidth - _sceneLoader.width)  / 2; 
			_sceneLoader.y = (stage.stageHeight - _sceneLoader.height) / 2; 	
		}
		
		/**
		 *从appDomain中得到素材 
		 * @param 素材的类名
		 * @return 素材容器
		 * 
		 */		
		private function getMat(className:String):Sprite
		{
			if(_appDomain && _appDomain.hasDefinition(className))
			{
				var mat:Class = _appDomain.getDefinition(className) as Class;
				return new mat();
			}
			return null;
		}
	}
}