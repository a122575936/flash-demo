package code.app
{
	import com.fminutes.vinciNet.PlatformFlashValue;

	/**
	 * 
	 * @author lipi
	 * 通过flash value 传入值
	 */
	public class AppData
	{
		public function AppData()
		{
			if(_instance == null)
			{
				super();
				_instance = this;
				setValue(PlatformFlashValue.value);
			}else{
				throw new Error("实例化单例类出错-AppData");
			}
		}
		
		private static var _instance:AppData;
		public static function getInstance():AppData
		{
			if(_instance == null)
				_instance = new AppData();
			
			return _instance;
		}
		
		private var _flashValue:Object;
		
		/**
		 * 设置外部传入值
		 * @param v 外部传入值
		 */
		public function setValue(v:Object):void
		{
			if(_flashValue == null) return;
			_flashValue = v;
			if(v.hasOwnProperty("userid")) myID = v["userid"];
			if(v.hasOwnProperty("action")) action = v["action"];
			if(v.hasOwnProperty("inuId")) sessionkey = v["inuId"];
			if(v.hasOwnProperty("session_key")) facebookSessionkey = v["session_key"];
			if(v.hasOwnProperty("ss")) facebookSS = v["ss"];
			if(v.hasOwnProperty("api_key")) facebookApiKey = v["api_key"];
			if(v.hasOwnProperty("host")) socket = v["host"];
			if(v.hasOwnProperty("port")) socketPort = v["port"];
			if(v.hasOwnProperty("userFrom")) userFrom = v["userFrom"];
			if(v.hasOwnProperty("userIsNew")) userIsNew = v["userIsNew"];
			if(v.hasOwnProperty("platform")) platform = v["platform"];
			if(v.hasOwnProperty("inviteUrl")) inviteUrl = v["inviteUrl"];
			if(v.hasOwnProperty("isDebug")) isDebug = v["isDebug"];
			if(v.hasOwnProperty("platform")) platform = v["platform"];
			if(v.hasOwnProperty("platform")) platform = v["platform"];
		}
		
		/**
		 * 
		 * @param key
		 * @return 输出
		 */
		public function getValue(key:String,defaultValue:String = null):Object
		{
			if(_flashValue == null) return defaultValue;
			return _flashValue[key] || null;
		}
		
		public var myID:String = "";
		public var isDebug:Boolean = false;
		public var inviteUrl:String = "";
		public var platform:String = "";
		public var userIsNew:Boolean = false;//是否为新用户 
		public var userFrom:String = "";//用户通过何种方式进入游戏的 
		public var socketPort:String = "";
		public var socket:String = "";
		public var facebookApiKey:String = "";
		public var facebookSS:String = "";
		public var facebookSessionkey:String = "";
		public var sessionkey:String = "";
		public var action:String = "";
		
	}
}