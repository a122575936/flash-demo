package
{
	import com.fminutes.vinciDll.Dll;
	import com.fminutes.vinciIsometric.core.IsoConst.IsoType;
	import com.fminutes.vinciIsometric.core.IsoUtils;
	import com.fminutes.vinciIsometric.core.IsoWorld;
	import com.fminutes.vinciUI.containers.RollContainer;
	import com.fminutes.vinciUI.controls.ScaleButton;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import iso.WallIsoObject;
	
	import log.Logger;
	
	import utils.color.randomColor;
	import utils.tostring.WidthHeightProperty;
	
	[SWF(width="720", height="650", backgroundColor=0xEEEEEE)]
	public class Main extends Sprite
	{
		private static const ISO_WORLD_X_NUM:Number = 30;
		private static const ISO_WORLD_Z_NUM:Number = 30;
		private static const ISO_WORLD_SIZE:Number = 32;
		private static const ISO_WORLD_SHOW_NUM:Number = 1;
		
		public function Main()
		{
			initView();
			initListener();
		}
		
		private function initListener():void
		{
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		private function onMouseMove(event:MouseEvent):void
		{
			if (event.buttonDown) 
			{
				_rollContainer.left += (_mousePosition.x - mouseX);
				_rollContainer.top += (_mousePosition.y - mouseY);
				_rollContainer.reRoll();
				updateMousePosition();
				Logger.debug(LeftTopProperty(_rollContainer));
			}	
		}
		
		private function updateMousePosition():void
		{
			_mousePosition.x = mouseX;
			_mousePosition.y = mouseY;
		}		
		
		private function onMouseDown(event:MouseEvent):void
		{
			_mousePosition = new Point(mouseX, mouseY);
			_rollContainerLeft = _rollContainer.left;
			_rollContainerTop = _rollContainer.top;
		}

		private function onClick(event:MouseEvent):void
		{
			if (_isDIYState) 
			{
				var wall:WallIsoObject = new WallIsoObject(ISO_WORLD_SIZE, ISO_WORLD_SIZE);
				var cube:Cube = new Cube(ISO_WORLD_SIZE, ISO_WORLD_SIZE, ISO_WORLD_SIZE, randomColor());
				
				wall.canPlaced = false;
				wall.isContainer = false;
				wall.displayChild = cube;
				wall.type = IsoType.STATIONARY;
				wall.xyz = IsoUtils.screenToIso(_isoWorld.getMousePoint());
				
				if (hasIsoObjectInIsoMapItem()) 
				{
					_isoWorld.addToWorld(wall);
				}
				else
				{
					cube = null;
					wall = null;
				}
			}
			else
			{
				
			}
		}

		private function hasIsoObjectInIsoMapItem():Boolean
		{
			return null != _isoWorld.getIsoMapItem(_isoWorld.getMousePosition()) && 0 == _isoWorld.getIsoMapItem(_isoWorld.getMousePosition()).isoList.length;
		}

		
		protected var _isoWorld:IsoWorld;
		protected var _rollContainer:RollContainer;
		private var _mousePosition:Point;
		/**
		 *rollContainer的left属性 
		 */
		private var _rollContainerLeft:Number;
		/**
		 *rollContainer的top属性 
		 */
		private var _rollContainerTop:Number;
		private var _isDIYState:Boolean;
		private var _DIYScaleButton:ScaleButton;
		
		private function initView():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_isoWorld = new IsoWorld(ISO_WORLD_X_NUM, ISO_WORLD_Z_NUM, ISO_WORLD_SIZE, ISO_WORLD_SHOW_NUM);
			_rollContainer = new RollContainer();
			_DIYScaleButton = new ScaleButton(Dll.getInstance().getDisplayObjectByName());
			_DIYScaleButton.addEventListener(MouseEvent.CLICK, onDIYScaleButtonClick);
			
			Logger.info(WidthHeightProperty(_isoWorld));
			
			_rollContainer.showRect = new Rectangle(-(_isoWorld.width / 2), 0, _isoWorld.width, _isoWorld.height);
			_rollContainer.width = stage.stageWidth;
			_rollContainer.height = stage.stageHeight;
			_rollContainer.reRoll();
			
			Logger.info(LeftTopProperty(_rollContainer));
			
			_isoWorld.isoGridVisible = true;
			
			_rollContainer.addChild(_isoWorld);
			stage.addChild(_rollContainer);
			
			Logger.info(WidthHeightProperty(_isoWorld));
			Logger.info(WidthHeightProperty(_rollContainer));
		}

		private function onDIYScaleButtonClick(event:MouseEvent):void
		{
			if (_isDIYState) 
			{
				_isDIYState = false;
			}
			else
			{
				_isDIYState = true;
			}
		}
		
		private function LeftTopProperty(rollContainer:RollContainer):String
		{
			return rollContainer.toString() + "left, top:" + rollContainer.left.toString() + ", " + rollContainer.top.toString();
		}
	}
}