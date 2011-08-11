package log
{
	public class Logger
	{
		public static const LEVEL_NOTSET:int = 0;
		public static const LEVEL_DEBUG:int = 10;
		public static const LEVEL_INFO:int = 20;
		public static const LEVEL_WARN:int = 30;
		public static const LEVEL_ERROR:int = 40;
		
		public static var level:int = LEVEL_NOTSET;
		/*
		* 用法：
		* 1、包含相应的包
		*	import com.shendian.utils.SimpleLog;
		* 2、示例
		*	SimpleLog.debug('一个来自 simplelog 的日志');
		*	SimpleLog.level = SimpleLog.LEVEL_INFO; // 提高日志级别
		*	SimpleLog.debug('不会被输出的日志');
		*	SimpleLog.info('一个 Info 日志');
		*/
		private static function log(level:String, ... args):void
		{
			var stackTrace:String = new Error().getStackTrace();
			if(!Boolean(stackTrace))
			{
				return;
			}
			// 获取第 3 个调用  frame，
			// 第 1 个是自己
			// 第 2 个是 debug/warn/error/...
			// 第 3 个是真正的业务逻辑函数
			var s:String = stackTrace.split("\n", 4)[3];
			// 函数名[文件名:行数]
			var tmp:Array = s.split('[', 2);
			// 提取函数名
			var funcName:String = tmp[0].split(' ').pop();
			// 提取行号
			s = tmp[1].split('\\').pop();
			var lineNo:String = s.split(']').shift();
			// 输出
			trace(level, '[' +funcName + ':' + lineNo + ']', args);
		}
		
		public static function debug(... args):void
		{
			if(level > LEVEL_DEBUG)
			{
				return;
			}
			log('[DEBUG]', args);
		}
		
		public static function info(... args):void
		{
			if(level > LEVEL_INFO)
			{
				return;
			}
			log('[INFO]', args);
		}
		
		public static function warn(... args):void
		{
			if(level > LEVEL_WARN)
			{
				return;
			}
			log('[WARN]', args);
		}
		
		public static function error(... args):void
		{
			if(level > LEVEL_ERROR)
			{
				return;
			}
			log('[ERROR]', args);
		}
	}
}