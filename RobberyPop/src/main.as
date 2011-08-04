package
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	 
	[SWF(width="1024", height="600",backgroundColor=0xEEEEEE)]
	public class main extends Sprite
	{
		private var _appDomain:ApplicationDomain;
		public function main()
		{
			init();
		}
		
		private function init():void { 
			var loader:Loader = new Loader();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.load(new URLRequest("files/robberyPop.swf"));
		}
		
		private function onCompleteHandler(e:Event):void{  
			var contextInfo:LoaderInfo = e.target as LoaderInfo;
			_appDomain = contextInfo.applicationDomain;
			
			var bg:Sprite = getMat(ResConst.BACKGROUND);
			var title:Sprite = getMat(ResConst.TITLE_WIN);
			var fightingImage:Sprite = getMat(ResConst.FIGHTING_IMAGE_WIN);
			var fightingInfoBg:Sprite = getMat(ResConst.FIGHTING_INFO_BG);
			var matArray:Array = getMatArray();
			var fightingInfo:InfoComponent = new InfoComponent(fightingInfoBg, matArray);
			var okButton:Sprite = getMat(ResConst.OK_BUTTON);
			
			var pop:Sprite = new PopComponent(bg, title, fightingImage, fightingInfo, okButton);
			addChild(pop);
			pop.x = (this.stage.stageWidth - pop.width) / 2;
			pop.y = (this.stage.stageHeight - pop.height) / 2;
			trace(this.stage.stageWidth, pop.width);
			trace(this.stage.stageHeight, pop.height);
		}
		
		private function getMatArray():Array
		{
			var retArray:Array = new Array();
			var infoItem:InfoItem = new InfoItem();
			infoItem.key = "获得悬赏值:";
			infoItem.icon = getMat(ResConst.REWARD_VALUE_ICON);
			infoItem.value = "200";
			retArray.push(infoItem);
			
			infoItem = new InfoItem();
			infoItem.key = "获得金币:";
			infoItem.icon = getMat(ResConst.GOLD_ICON);
			infoItem.value = "2000";
			retArray.push(infoItem);
			
			infoItem = new InfoItem();
			infoItem.key = "获得经验:";
			infoItem.icon = getMat(ResConst.EXPERIENCE_VALUE_ICON);
			infoItem.value = "3500";
			retArray.push(infoItem);
			
			infoItem = new InfoItem();
			infoItem.key = "战斗表现:";
			infoItem.icon = null;
			infoItem.value = "20%";
			retArray.push(infoItem);
			
			return retArray;
		}
		
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