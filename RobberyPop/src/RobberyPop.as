package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class RobberyPop extends Sprite
	{
		private var loader:Loader;
		
		public var Title:Class;  
		public var FightingImage:Class; 
		public var OkButton:Class; 
		public var Background:Class; 
		
		public var background:MovieClip;
		public var title:MovieClip;
		public var image:MovieClip;
		public var fightingInfo:FightingInfo;
		public var okButton:MovieClip;
		
		public function RobberyPop( Title:Class, FightingImage:Class, fightingInfo:FightingInfo, OkButton:Class, Background:Class ) { 
			this.Title = Title;
			this.FightingImage = FightingImage;
			this.fightingInfo = fightingInfo;
			this.OkButton = OkButton;
			this.Background = Background;

			init();
		}
		
		private function init():void
		{
			background = new Background();  
			background.x = 250; 
			background.y = 250;
			addChild(background);
			
			title = new Title();  
			title.x = -70; 
			title.y = -250;
			background.addChild(title);
			
			image = new FightingImage()  as MovieClip;
			image.x = -180; 
			image.y = -230;
			background.addChild(image);
			
			var fightingInfoBg:MovieClip = new fightingInfo.FightingInfoBg();
			background.addChild(fightingInfoBg);
			fightingInfoBg.x = -185;
			fightingInfoBg.y = 15;
			
			for (var key:String in fightingInfo.ValueMap){
				var textField:TextField = new TextField();
				textField.text = key;
				textField
				textField.x = 50;
				textField.y = 50;
				fightingInfoBg.addChild(textField);
			}
			
			okButton = new OkButton();  
			okButton.x = -50; 
			okButton.y = 170;
			background.addChild(okButton);
		}
	}
}