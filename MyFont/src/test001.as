package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class test001
	{
		private var _loader:Loader;

		public function test001()
		{
			_loader = new Loader();
			_loader.load(new URLRequest("MyFont.swf"));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function onComplete(event:Event):void
		{
			var fontClass:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition("MyFont") as Class;
			
			var arr:Array = Font.enumerateFonts(false);
			trace(arr[0].fontName);
			var textField:TextField = new TextField();
			textField.embedFonts = true;
			var textFormat:TextFormat = new TextFormat(arr[0].fontName,35);
			textField.setTextFormat(textFormat);
			textField.text = "出售";
			textField.autoSize = TextFieldAutoSize.LEFT;
			this.addChild(textField);
		}
	}
}

	}
}