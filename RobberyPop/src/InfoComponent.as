package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class InfoComponent extends Sprite
	{
		private var _bg:Sprite;
		private var _matArray:Array;
		public static const DIS:int = 25;
		public static const ITEM_HEIGHT:int = 25;
		public function InfoComponent(bg:Sprite, matArray:Array)
		{
			super();
			_bg = bg;
			_matArray = matArray;
			initView();
		}
		
		private function initView():void
		{
			addChild(_bg);
			
			for(var i:int = 0; i < _matArray.length; i++)
			{
				var info:Sprite = new Sprite();
				var infoItem:InfoItem = _matArray[i];
				var textFieldA:TextField = new TextField();
				textFieldA.autoSize = TextFieldAutoSize.LEFT;
				textFieldA.text = infoItem.key;
				textFieldA.mouseEnabled = false;
				info.addChild(textFieldA);
				
				var icon:DisplayObject = infoItem.icon;
				var textFieldB:TextField = new TextField();
				textFieldB.text = infoItem.value;
				textFieldB.autoSize = TextFieldAutoSize.LEFT;
				textFieldB.mouseEnabled = false;
				info.addChild(textFieldB);
				if(icon)
				{
					info.addChild(icon);
					icon.x = textFieldA.x + textFieldA.width + icon.width;
					textFieldB.x = icon.x + icon.width;
				}else
				{	
					textFieldB.x = textFieldA.x + textFieldA.width;
				}
				
				info.x = 120;
				info.y = i * ITEM_HEIGHT +DIS;
				addChild(info);
			}
			
			_bg.width = 362;
			_bg.height = _matArray.length * ITEM_HEIGHT + 2 * DIS;
		}
	}
}