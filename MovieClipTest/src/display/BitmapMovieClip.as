package display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.System;
	/**
	 * 位图化的影片剪辑元件。
	 * 
	 */    
	public class BitmapMovieClip extends Sprite
	{
		private var _target:MovieClip;
		private var _movieClipBmp:Bitmap;
		private var _frameBmpDatas:Array;
		private var _currentFrame:int = 1;
		private var _totalFrames:int;
		
		public function BitmapMovieClip(target:MovieClip)
		{
			_target = target;
			_frameBmpDatas = new Array();
			_movieClipBmp = new Bitmap();
			_totalFrames = _target.totalFrames;
			addChild(_movieClipBmp);
			
			storeFrameAsBitmap();
			play();
		}
		/**
		 * 播放动画。 
		 * 
		 */        
		public function play():void
		{
			addEventListener(Event.ENTER_FRAME, loopFrame, false, 0, true);
		}
		/**
		 * 停止动画。 
		 * 
		 */
		public function stop():void{
			removeEventListener(Event.ENTER_FRAME, loopFrame);
		}
		/**
		 * 跳转到目标帧并开始播放。 
		 * @param frame
		 * 
		 */        
		public function gotoAndPlay(frame:int):void{
			_movieClipBmp.bitmapData = _currentFrame[frame];
			_currentFrame = frame;
			play();
		}
		/**
		 * 跳转到目标帧并停止。 
		 * @param frame
		 * 
		 */        
		public function gotoAndStop(frame:int):void{
			_movieClipBmp.bitmapData = _currentFrame[frame];
			_currentFrame = frame;
			stop();
		}
		/**
		 * 实例的时间轴当前所处的帧号。  
		 * @return 
		 * 
		 */        
		public function get currentFrame():int{
			return _currentFrame;
		}
		/**
		 * 实例中帧的总数。 
		 * 
		 */        
		public function get totalFrame():int{
			return _totalFrames;
		}
		/**
		 * 循环帧。 
		 * @param evt
		 * 
		 */        
		private function loopFrame(evt:Event):void
		{
			_movieClipBmp.bitmapData = _frameBmpDatas[_currentFrame];
			_currentFrame = _currentFrame < _totalFrames - 1 ? _currentFrame + 1 : 0;
		}
		/**
		 * 将目标影片剪辑缓存为位图数组。
		 * 
		 */        
		private function storeFrameAsBitmap():void
		{
			for (var i:int = 0; i < _totalFrames; i++)
			{
				var r:Rectangle = _target.getBounds(_target);
				var bmpData:BitmapData;
				if (r.width <= 0 || r.height <= 0)
				{
					bmpData =  new BitmapData(1, 1, true);
				}
				else
				{
					bmpData = new BitmapData(r.width, r.height, true);
				}
				bmpData.draw(_target);
				_frameBmpDatas.push(bmpData);
				_target.nextFrame();
			}
			
			_movieClipBmp.x = r.x;
			_movieClipBmp.y = r.y;
		}
	}
}