package utils.tostring
{
	import flash.display.DisplayObject;
	
	public  function XYProperty(object:DisplayObject):String
	{
		return object.toString() + "x, y:" + object.x.toString() + ", " + object.y.toString();
	}
}