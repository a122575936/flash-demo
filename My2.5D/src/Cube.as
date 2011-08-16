package core
{
	import com.fminutes.vinciIsometric.core.IsoUtils;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class Cube extends Sprite
	{
		public function Cube(fw:int = 64,fh:int=32,height:int = 20,color:uint = 0x0099FF)
		{//
			var lineColor:uint = 0x666666;
			
			
			
			super();
			this.graphics.beginFill(color&0xEEEEEE,1);
			this.graphics.lineStyle(0,lineColor,0);
			
			var pt:Point;
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,0,fh));
			this.graphics.moveTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,0,0));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,-height,0));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,-height,fh));
			this.graphics.lineTo(pt.x,pt.y);
			
			this.graphics.endFill();
			
			/////////////////////////////////
			
			
			this.graphics.beginFill(color&0xCCCCCC,1);
			this.graphics.lineStyle(0,lineColor,0);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,0,fh));
			this.graphics.moveTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(0,0,fh));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(0,-height,fh));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,-height,fh));
			this.graphics.lineTo(pt.x,pt.y);
			
			this.graphics.endFill();
			
			//////////////////////////////////////////////
			
			this.graphics.beginFill(color,1);
			this.graphics.lineStyle(0,lineColor,0);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,-height,fh));
			this.graphics.moveTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(0,-height,fh));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(0,-height,0));
			this.graphics.lineTo(pt.x,pt.y);
			
			pt = IsoUtils.isoToScreen(new Vector3D(fw,-height,0));
			this.graphics.lineTo(pt.x,pt.y);
			
			this.graphics.endFill();
			
			
		}
	}
}