package code
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class Box extends Sprite
	{
		/**
		 * 构成形状方块的Cube
		 */		
		public var shape:Array;
		/**
		 * 填充该方块的位图数据 
		 */		
		public var type:BitmapData;
		/**
		 *  指代形状方块的类型
		 */		
		public var typeShape:int;
		
		public var init_x:int = 5;

		/**
		 * 
		 * @param i 形状类型
		 * @param ptype 位图数据
		 * 
		 */
		public function Box(i:int,ptype:BitmapData)
		{
			super();

			this.type = ptype;
			this.typeShape = i;
			init();
			createShape(typeShape);
			draw();
			
		}
		
		private function init():void
		{
			shape = new Array();
			for(var i:int = 0;i<4;i++)
				shape.push(new Cube(this.typeShape,this.type));
		}
		
		private function draw():void
		{
			for(var i:int;i<4;i++)
			{
				shape[i].x += shape[i].shape_x*24;
				shape[i].y += shape[i].shape_y*24;
				this.addChild(shape[i]);
			}
		}
		
		/**
		 *同步数据层和显示层 
		 * 
		 */
		private function refresh():void
		{
			for(var i:int;i<4;i++)
			{
				shape[i].x = shape[i].shape_x*24;
				shape[i].y = shape[i].shape_y*24;
			}
		}
		
		/**
		 *数据层旋转并判断旋转后是否越界，越界取消旋转 
		 * 
		 */		
		public function rotate():void
		{
			
			rotateAction();
			
			for(var i:int = 0;i<4;i++ )
			{
				if(shape[i].position_x+shape[i].shape_x<0||shape[i].position_x+shape[i].shape_x>14)
				{
					cancelRotateAction();
					break;
				}
			}
			refresh();
		}
		
		/**
		 *显示层的旋转 
		 * 
		 */		
		private function rotateAction():void
		{
			for(var i:int = 0;i<4;i++ )
			{
				var t_x:int = shape[i].shape_x;
				var t_y:int = shape[i].shape_y;
				shape[i].shape_x = -t_y;
				shape[i].shape_y = t_x;
			}
		}
		
		private function cancelRotateAction():void
		{
			for(var i:int = 0;i<4;i++ )
			{
				var t_x:int = shape[i].shape_x;
				var t_y:int = shape[i].shape_y;
				shape[i].shape_x = t_y;
				shape[i].shape_y = -t_x;
			}
		}
		
		public function moveLeft():void
		{	
			x -= 24;
			for(var i:int = 0;i<4;i++)			
				shape[i].position_x --;		
		}
		
		public function moveRight():void
		{			
			x += 24;
			for(var i:int = 0;i<4;i++)
				shape[i].position_x ++;			
		}
		
		public function moveDown():void
		{
			y += 24;
			for(var i:int = 0;i<4;i++)
				shape[i].position_y ++;
		}
		
		/**
		 * 
		 * @param t 类型参数
		 * 
		 */		
		private function createShape(t:int):void
		{
			switch(t)
			{
				case 10:  	
					/*  正方形*/
					shape[0].shape_x = -1;
					shape[0].shape_y = -1;
					shape[1].shape_x = 0;
					shape[1].shape_y = -1;
					shape[2].shape_x = -1;
					shape[2].shape_y = 0;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;  
				case 20:  	
					/* 7型*/
					shape[0].shape_x = -1;
					shape[0].shape_y = -1;
					shape[1].shape_x = 0;
					shape[1].shape_y = -1;
					shape[2].shape_x = 0;
					shape[2].shape_y = 1;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;  
				case 30: 
					/* s型*/
					shape[0].shape_x = 0;
					shape[0].shape_y = -1;
					shape[1].shape_x = 1;
					shape[1].shape_y = -1;
					shape[2].shape_x = -1;
					shape[2].shape_y = 0;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					break;  
				case 40: 
					/* 倒7型*/
					shape[0].shape_x = 0;
					shape[0].shape_y = -1;
					shape[1].shape_x = 1;
					shape[1].shape_y = 0;
					shape[2].shape_x = 2;
					shape[2].shape_y = 0;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;  
				case 50:  
					/* Z型*/
					shape[0].shape_x = 0;
					shape[0].shape_y = -1;
					shape[1].shape_x = 1;
					shape[1].shape_y = 0;
					shape[2].shape_x = -1;
					shape[2].shape_y = -1;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;  
				case 60:
					/* T型*/
					shape[0].shape_x = 0;
					shape[0].shape_y = -1;
					shape[1].shape_x = 1;
					shape[1].shape_y = 0;
					shape[2].shape_x = -1;
					shape[2].shape_y = 0;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;  
				case 70:
					/* 一型*/
					shape[0].shape_x = 0;
					shape[0].shape_y = -1;
					shape[1].shape_x = 0;
					shape[1].shape_y = 2;
					shape[2].shape_x = 0;
					shape[2].shape_y = 1;
					shape[3].shape_x = 0;
					shape[3].shape_y = 0;
					
					break;
			}
		}
	}
}