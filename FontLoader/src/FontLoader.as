package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.*;
	
	public class FontLoader extends Sprite {
		private var _FontLibrary:Class;
		
		public function FontLoader() {
			loadFont("FontLibrary.swf");		}
		
		private function loadFont(url:String):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fontLoaded);
			loader.load(new URLRequest(url));
		}
		
		private function fontLoaded(event:Event):void {
			_FontLibrary = event.target.applicationDomain.getDefinition("FontLibrary") as Class;
			//Font.registerFont(FontLibrary.DefaultFont);
			drawText();
		}
		
		public function drawText():void {
			
			var textField:TextField = new TextField();
			var fmt:TextFormat=new TextFormat(); 
			fmt.font = "DefaultFont";
			fmt.size = 24;
			textField.defaultTextFormat = fmt;
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.border = true;
			textField.text = "你经过不懈的努力，终于学会了新技能{0}，战斗力将达到一个新的高度！";
			textField.rotation = 15;
			
			addChild(textField);
			textField.x = (stage.stageWidth - textField.width) / 2;
			textField.y = (stage.stageHeight - textField.height) / 2;
		}
	}
}