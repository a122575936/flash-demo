package code.app
{
	import com.fminutes.vinciMVC.model.ModelList;
	
	/**
	 * @author lipi
	 * 存储所有 ModelData实例
	 */
	public class AppModelList extends ModelList
	{
		public function AppModelList()
		{
			if(_instance==null)
			{
				super();
				_instance = this;
			}else{
				throw new Error("实例化单例类出错-AppModelList");
			}
		}
		
		private static var _instance:AppModelList;
		public static function getInstance():AppModelList
		{
			if(_instance == null)
				_instance = new AppModelList();
			
			return _instance;
		}
	}
}
