package
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	public class ResolveSWF extends Sprite
	{
		private var stream:URLStream;
		
		public function ResolveSWF()
		{
			initView();
		}
		
		private function initView():void
		{	
			// creates a URLStream object 
			stream = new URLStream(); 
			stream.addEventListener ( Event.COMPLETE, onCompleteHandler ); 
			// download the remote image 
			stream.load ( new URLRequest ("files/robberyPop.swf" ) ); 
			//stream.load ( new URLRequest ("files/src.swf" ) ); 
		}
		
		private function onCompleteHandler(e:Event):void{  
			// store the incoming bytes 
			var buffer:ByteArray= new ByteArray(); 
			stream.readBytes( buffer, buffer.length );
			
			var swf:SWF = new SWF(buffer);
			for each (var tag:ITag in swf.tags)
			{
				if (tag is TagSymbolClass)
				{
					trace(tag);
				}
			}
		}
	}
}