package view
{
	import event.TetrisEvent;
	
	import flash.display.Sprite;
	import flash.media.Camera;
	
	import tetris.Cell;
	import tetris.TetradShape;

	/**
	 *管理游戏的显示 
	 * @author zhouqin
	 * 
	 */	
	public class View
	{
		
		/**
		 *clip用开显示游戏的 网格（grid）
		 */
		private var _clip:Sprite;
		private var _cells:Array;
		private var _sprites:Object;
		
		public function View( clip:Sprite, sprites:Sprite)
		{
			_clip = clip;
			_sprites = sprites;
			
			//在游戏区域创建和初始化cell
			var id:uint = 0;
			var pos:Number = TetrisConfig.blockSize * 0.5;
			_cells = new Array();
			for (var i:int = 0; i < TetrisConfig.playWidth; i++) 
			{
				_cells[i] = new Array();
				for (var j:int = 0; j < TetrisConfig.playHeught; j++) 
				{
					var cell:Sprite = new Sprite();
					cell.x = TetrisConfig.blockSize * i + pos;
					cell.y = TetrisConfig.blockSize * j + pos;
					var mask:Sprite = new Sprite();
					mask.graphics.beginFill( 0, 0, TetrisConfig.blockSize, TetrisConfig.blockSize);
					mask.x = TetrisConfig.blockSize * i;
					mask.y = TetrisConfig.blockSize * j;
					++id;
					_clip.addChild(cell);
					_clip.addChild(mask);
					cell.mask = mask;
					_cells[i][j] = cell;
				}	
			}
			
			private function clearCell( cell:Sprite):void
			{
				while ( cell.numChildren )
				{
					cell.removeChildAt( 0 );
				}
			}
			
			/**
			 *清楚游戏区域的所有cell 
			 * 
			 */
			private function clearCells():void
			{
				for (var i:int = 0; i < TetrisConfig.playWidth; i++) 
				{
					for (var j:int = 0; j < TetrisConfig.playHeught; j++) 
					{
						clearCell( _cells[i][j];
					}
				}
			}
			
			/**
			 *updateCells 事件的处理函数
			 * 将更新过的cell设为新状态 
			 * @param e
			 * 
			 */
			private function onUpdateCells( e:TetrisEvent ):void
			{
				var offset:Number = TetrisConfig.blockSize * 0.5;
				for (var i:int = 0; i < e.cells.length; i++) 
				{
					var cell:Cell = e.cells[i];
					clearCell( _cells[cell.location.x][cell.location.y] )
					if ( cell.state.shape != TetradShape.CLEAR )
					{
						var id:Class = 
					}
				}
				
			}
		}
	}
}