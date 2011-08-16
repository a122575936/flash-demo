package code.mvc.view.layer
{
	import code.mvc.view.scene.CityWorld;
	import code.mvc.view.scene.iso.CityIsoObject;
	
	import com.fminutes.vinciBase.VinciSprite;
	import com.fminutes.vinciDll.Dll;
	import com.fminutes.vinciIsometric.core.IsoUtils;
	import com.fminutes.vinciUI.controls.Button;
	
	import event.SceneEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class DiyLayer extends VinciSprite
	{
		private var _diyIso:CityIsoObject;
		
		private var _mousePoint:Point;
		
		private var _offsetPoint:Point;
		
		private var _diyVector:Vector3D;
		
		private var _mouseIso:CityIsoObject;
		
		public function DiyLayer()
		{
			super();
			
			_mousePoint = new Point();
			_offsetPoint = new Point();
			
			//			initButton();
		}
		
		//		private var _cancelBtn:Button;
		//		private var _destroyBtn:Button;
		//		
		//		private var _skin:DisplayObject;
		//		
		//		private function initButton():void{
		//			_skin = Dll.getInstance().getDisplayObjectByName(ResourceConst.FIX_UP_CANCEL_BUILD_BTN) as DisplayObject;
		//			_cancelBtn = new Button(_skin);
		//			_destroyBtn = new Button(Dll.getInstance().getDisplayObjectByName(ResourceConst.FIX_UP_DESTROY_BTN) as DisplayObject);
		//			
		//			addChild(_destroyBtn);
		//			
		//			_cancelBtn.visible = true;
		//			_destroyBtn.visible = true;
		//			
		//			_cancelBtn.addEventListener(MouseEvent.CLICK, onCancelHandler);
		//			_destroyBtn.addEventListener(MouseEvent.CLICK, onDestroyHandler);
		//			_cancelBtn.addEventListener(MouseEvent.MOUSE_OVER,onButttonMouseOverHandler);
		//			_destroyBtn.addEventListener(MouseEvent.MOUSE_OVER,onButttonMouseOverHandler);
		//		}
		
		private function onCancelHandler(e:MouseEvent):void
		{
			this.dispatchEvent(new Event(SceneEvent.CANCEL_NEW_BUILDDING, true));
		}
		
		private function onDestroyHandler(e:MouseEvent):void
		{
			this.dispatchEvent(new Event(SceneEvent.DESTROY_BUILDDING, true));
		}
		
		private function update():void
		{
			if (_diyIso == null)
				return;
			
			var p:Point = globalToLocal(_mousePoint);
			p.x -= _offsetPoint.x;
			p.y -= _offsetPoint.y;
			_diyVector = IsoUtils.screenToIso(p);
			
			var size:Number = CityWorld.GRID_SIZE * CityWorld.GRID_GROUP;
			_diyVector.x = (Math.floor(_diyVector.x / size) + Math.ceil(_diyOffset.x / 2)) * size;
			_diyVector.z = (Math.floor(_diyVector.z / size) + Math.ceil(_diyOffset.y / 2)) * size;
			p = IsoUtils.isoToScreen(_diyVector);
			p.x += _offsetPoint.x;
			p.y += _offsetPoint.y;
			
			_diyIso.x2d = p.x;
			_diyIso.y2d = p.y;
		}
		
		public function set diyIso(value:CityIsoObject):void
		{
			if (_diyIso != null)
			{
				if (this.contains(_diyIso))
					removeChild(_diyIso);
				_diyIso = null;
			}
			
			if (value != null)
			{
				_diyIso = value;
				addChild(_diyIso);
			}
			
			update();
		}
		
		public function setMouse(isoX:Number, isoY:Number):void
		{
			_mousePoint.x = isoX;
			_mousePoint.y = isoY;
			
			update();
		}
		
		private var _diyOffset:Point = new Point(0, 0);
		// 设置diy物件的坐标点相对于鼠标的偏移量
		public function setDiyIsoOffset(offsetP:Point):void
		{
			_diyOffset = offsetP;
		}
		
		public function setOffset(offsetX:Number, offsetY:Number):void
		{
			_offsetPoint.x = offsetX;
			_offsetPoint.y = offsetY;
		}
		
		public function get diyIso():CityIsoObject
		{
			return _diyIso;
		}
		
		public function get diyVector():Vector3D
		{
			return _diyVector.clone();
		}
		
		public function get mouseIso():CityIsoObject
		{
			return _mouseIso;
		}
		
		//		public function set mouseIso(value:CityIsoObject):void
		//		{
		//			if(value==null){
		//				//如果null 1秒内隐藏按钮
		//				return;
		//			}
		//			_mouseIso = value;
		//			
		//		}
		private function onButttonMouseOverHandler(e:MouseEvent):void
		{
			
		}
		
		//		public function updataMouseIso(mouseIso:CityIsoObject,isNew:Boolean):void{
		////			if(mouseIso==null){
		////				//如果null 1秒内隐藏按钮
		////				//return;
		////				_cancelBtn.visible = false;
		////				_destroyBtn.visible = false;
		////			}
		////			_mouseIso = mouseIso;
		////			//显示按钮 确定位置
		////			var pos:Point = IsoUtils.isoToScreen(_mouseIso.xyz);
		////			_cancelBtn.x = _destroyBtn.x = 100+_offsetPoint.x;
		////			_cancelBtn.y = _destroyBtn.y = 100+_offsetPoint.y;
		////			_cancelBtn.visible = isNew;
		////			_destroyBtn.visible = !isNew;
		//			
		//		}
		
		
		
	}
}