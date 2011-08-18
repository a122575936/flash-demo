package utils.tostring
{
	import flash.display.DisplayObject;
	
	public  function WidthHeightProperty(object:DisplayObject):String
	{
		return object.toString() + "width, height:" + object.width.toString() + ", " + object.height.toString();
	}
}