package
{
	import flash.display.Sprite;

	public class PopComponent extends Sprite
	{
		private var _bg:Sprite;
		private var _title:Sprite;
		private var _fightingImage:Sprite;
		private var _fightingInfo:InfoComponent;
		private var _okButton:Sprite;
		
		public static const DIS:int = 15;
		
		public function PopComponent(bg:Sprite,  title:Sprite, fightingImage:Sprite, fightingInfo:InfoComponent, okButton:Sprite )
		{
			_bg = bg;
			_title = title;
			_fightingImage = fightingImage;
			_fightingInfo = fightingInfo;
			_okButton = okButton;
			initView();
		}
		
		private function initView():void
		{
			addChild(_bg);
			addChild(_title);
			addChild(_fightingImage);
			addChild(_fightingInfo);
			addChild(_okButton);
			
			update();
		}
		
		public function update():void
		{
			_title.x = (this._bg.width - this._title.width) / 2;
			
			_fightingImage.x = (_bg.width - _fightingImage.width) / 2;
			_fightingImage.y =  DIS;
			
			_fightingInfo.x =  (_bg.width - _fightingInfo.width) / 2;
			_fightingInfo.y = _fightingImage.y + _fightingImage.height;
			
			_okButton.x = (_bg.width - _okButton.width) / 2;
			_okButton.y = _fightingInfo.y + _fightingInfo.height + DIS;
			
			this.width = 460;
			this.height = _okButton.y + _okButton.height + DIS;
		}
	}
}