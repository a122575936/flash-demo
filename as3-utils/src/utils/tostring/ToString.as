package utils.tostring
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ToString
	{
		public function ToString()
		{
		}
		
		public static function WidthHeightProperty(object:DisplayObject):String
		{
			return object.toString() + "width, height:" + object.width.toString() + ", " + object.height.toString();
		}
		
		public static function XYProperty(object:DisplayObject):String
		{
			return object.toString() + "x, y:" + object.x.toString() + ", " + object.y.toString();
		}
	}
}