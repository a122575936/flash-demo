package
{
	import flash.display.DisplayObject;

	public class InfoItem
	{
		private var _key:String;
		private var _icon:DisplayObject;
		private var _value:String;
		
		public function InfoItem()
		{
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}

		public function get icon():DisplayObject
		{
			return _icon;
		}

		public function set icon(value:DisplayObject):void
		{
			_icon = value;
		}

		public function get key():String
		{
			return _key;
		}

		public function set key(value:String):void
		{
			_key = value;
		}

	}
}