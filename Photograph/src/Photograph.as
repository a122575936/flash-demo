package
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	[SWF(width="1024", height="768",backgroundColor=0xEEEEEE)]
	public class Photograph extends Sprite
	{
		/**
		 *场景 
		 */		
		private var sceneLoader:Loader = new Loader();
		/**
		 *图片容器 
		 */
		private var _bmpSp:Sprite;
		
		public function Photograph()
		{
			initView();
		}
		
		private function initView():void
		{		
			sceneLoader.load(new URLRequest("files/src.swf"));
			sceneLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			addChild(sceneLoader);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyboardEvent); 
		}
		
		/**
		 *loader完成时间处理 
		 * @param e
		 * 
		 */
		private function onCompleteHandler(e:Event):void{  
			sceneLoader.x = (stage.stageWidth - sceneLoader.width)  / 2; 
			sceneLoader.y = (stage.stageHeight - sceneLoader.height) / 2; 	
		}
		
		/**
		 *键盘事件处理 
		 * @param event
		 * 
		 */		
		public function onKeyboardEvent(event:KeyboardEvent):void { 
			switch (event.keyCode) { 
				case Keyboard.SPACE : 
					screenShot();
					break;
				case Keyboard.ENTER :
					clearBmpSp();
					break;
			}
		} 
		
		/**
		 *截图 
		 * 
		 */		
		private function screenShot():void
		{
			clearBmpSp();
			_bmpSp = new Sprite();
			addChild(_bmpSp);
		    var bmpData:BitmapData  = new BitmapData(sceneLoader.width, sceneLoader.height, false);
			bmpData.draw(sceneLoader);
			var bmp:Bitmap = new Bitmap(bmpData);
			_bmpSp.addChild(bmp);
			//白色背景
			_bmpSp.graphics.beginFill(0xFFFFFF, 100);
			_bmpSp.graphics.drawRect(0, 0, bmp.width + 30, bmp.height + 30);
			_bmpSp.graphics.endFill( );
			//画图像边框 
			_bmpSp.graphics.lineStyle(5, 0xc0c0c0, 1); 
			_bmpSp.graphics.drawRect(0, 0, bmp.width + 30, bmp.height + 30); 
			_bmpSp.x = (this.stage.stageWidth - _bmpSp.width) / 2;
			_bmpSp.y = (this.stage.stageHeight - _bmpSp.height) / 2; 
			bmp.x = (_bmpSp.width - bmp.width)  / 2; 
			bmp.y = (_bmpSp.height - bmp.height) / 2; 	
			
			TweenLite.to(_bmpSp, 1, {x:sceneLoader.x - sceneLoader.width / 4, y:(stage.stageHeight) / 2 - sceneLoader.height / 5, rotation:-35});
		}
		
		/**
		 *在舞台中清除截到的图片 
		 * 
		 */
		private function clearBmpSp():void
		{
			if(_bmpSp)
			{
				removeChild(_bmpSp);
				_bmpSp = null;
			}
		}
	}
}