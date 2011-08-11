package ultis
{
	import flash.display.Sprite;

	public class SpriteUtils
	{
		public function SpriteUtils()
		{
		}
		
		public static function removeAllChild(sp:Sprite):void
		{
			while (sp.numChildren != 0)
			{
				sp.removeChildAt(0);
			}
		}
	}
}