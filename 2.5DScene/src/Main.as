package
{
	import com.fminutes.vinciIsometric.core.IsoWorld;
	import com.fminutes.vinciUI.containers.RollContainer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import log.Logger;
	
	import utils.align.alignCenter;
	import utils.tostring.ToString;
	
	[SWF(width="720", height="650", backgroundColor=0xFFFFFF)]
	public class Main extends Sprite
	{
		public function Main()
		{
			initView();
			initListener();
		}
		
		private function initListener():void
		{
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event:MouseEvent):void
		{
			
		}
		
		protected var _isoWorld:IsoWorld;
		protected var _rollContainer:RollContainer;
		
		private function initView():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_isoWorld = new IsoWorld(10, 10, 32, 1);
			_rollContainer = new RollContainer();
			
			_rollContainer.width = stage.stageWidth;
			_rollContainer.height = stage.stageHeight;
			//_rollContainer.reRoll();
			
			_isoWorld.isoGridVisible = true;
			
			alignCenter(_rollContainer, _isoWorld);
			
			_rollContainer.addChild(_isoWorld);
			stage.addChild(_rollContainer);
			
			Logger.info(ToString.WidthHeightProperty(_isoWorld));
			Logger.info(ToString.WidthHeightProperty(_rollContainer));
		}
	}
}