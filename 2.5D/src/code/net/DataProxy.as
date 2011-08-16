package code.net
{
	import com.fminutes.vinciNet.DataChannel;
	
	/**
	 * 
	 * @author lipi
	 * 数据代理类.游戏通过此类调用服务器接口,服务器数据返回通过此类向外发布事件
	 */
	public class DataProxy extends DataChannel
	{
		public function DataProxy()
		{
			if(_instance==null)
			{
				super();
				_instance = this;
			}else{
				throw new Error("实例化单例类出错-DataProxy");
			}
		}
		
		private static var _instance:DataProxy;
		public static function getInstance():DataProxy
		{
			if(_instance == null)
				_instance = new DataProxy();
			
			return instance;
		}
	}
}