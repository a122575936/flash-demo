package
{
	import com.fminutes.vinciIsometric.core.IsoWorld;
	import com.fminutes.vinciUI.containers.RollContainer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
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
			// TODO Auto-generated method stub
			switch(event.type)
			{
				case MouseEvent.CLICK:
					break;
				case MouseEvent.MOUSE_DOWN:
					_mousePosition = new Point(event.stageX, event.stageY);
					break;
				case MouseEvent.MOUSE_UP:
					break;
				case MouseEvent.MOUSE_MOVE:
					if (event.buttonDown && _mousePosition)
					{
						var p:Point = new Point(event.stageX, event.stageY);
						p = p.subtract(_mousePosition);
						Logger.debug(LeftTopProperty(_rollContainer));
						_rollContainer.left -= p.x;
						_rollContainer.top -= p.y;
						_rollContainer.reRoll();
					}
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
			
			_rollContainer = new RollContainer();
			_isoWorld = new IsoWorld(10, 10, 16, 2);
			
			_rollContainer.width = stage.stageWidth;
			_rollContainer.height = stage.stageHeight;
			
			_rollContainer.addChild(_isoWorld);
			addChild(_rollContainer);
			
			_isoWorld.isoGridVisible = true;
			
			Logger.info(ToString.WidthHeightProperty(_isoWorld));
			Logger.info(ToString.XYProperty(_isoWorld));
			Logger.info(ToString.WidthHeightProperty(_rollContainer));
		}
	}
}