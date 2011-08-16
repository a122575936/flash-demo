package
{
	import com.fminutes.vinciIsometric.core.IsoWorld;
	import com.fminutes.vinciUI.containers.RollContainer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import log.Logger;
	
	import utils.align.alignCenter;
	import utils.object.inspect;
	import utils.object.toString;
	import utils.tostring.ToString;
	
	/**
	 *主类 
	 * @author zhouqin
	 * 
	 */
	[SWF(width="720", height="650", backgroundColor=0xEEEEEE)]
	public class Main extends Sprite
	{
		protected var _rollContainer:RollContainer;
		protected var _isoWorld:IsoWorld;
		protected var _mousePosition:Point;
		private var startX:Number;
		private var startY:Number;
		
		public function Main()
		{
			//Logger.level = Logger.LEVEL_INFO;
			initView();
			initListener();
		}
		
		private function initListener():void
		{
			stage.addEventListener(MouseEvent.CLICK, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
		}
		
		protected function onMouseEvent(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.CLICK:
					break;
				case MouseEvent.MOUSE_DOWN:
					break;
				case MouseEvent.MOUSE_UP:
					break;
				case MouseEvent.MOUSE_MOVE:
					break;
				default:
					break;
			}
		}
		
		private function LeftTopProperty(rollContainer:RollContainer):Object
		{
			return rollContainer + "left, top:" + rollContainer.left.toString() +", " + rollContainer.top.toString();
		}
		
		private function initView():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_isoWorld = new IsoWorld(10, 10, 32, 1);
			
			
			
			Logger.info(ToString.WidthHeightProperty(_isoWorld));
			Logger.info(ToString.XYProperty(_isoWorld));
			Logger.info(ToString.WidthHeightProperty(_rollContainer));
		}
	}
}