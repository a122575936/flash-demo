package event
{
	public class SceneEvent
	{
		public static const DESTROY_BUILDDING:String = "destroy_buildding";
		public static const CANCEL_NEW_BUILDDING:String = "cancel_new_buildding";
		/**
		 * 场景改变
		 */ 
		public static const SCENE_CHANGED:String = "scene_changed";
		/**
		 * 场景即将刷新
		 */ 
		public static const SCENE_PREV_FRESHED:String = "scene_prev_freshed";
		/**
		 * 场景刷新完毕
		 */ 
		public static const SCENE_REFRESHED:String = "scene_refreshed";
		/**
		 * 建筑信息改变
		 */ 
		public static const SCENE_UPDATED:String = "scene_updated";
		/**
		 * MP增长下一点时间
		 */ 
		public static const MP_ADDTIME_UPDATED:String = "mp_addtime_updated";
		
		/**
		 * PVE场景 触发事件
		 */ 
		public static const PVE_ATTACT_EVENTPOINT:String = "pve_attact_eventpoint";
		/**
		 * PVE场景 探索点事件完成
		 */ 
		public static const PVE_EVENTPOINT_COMPLETE:String = "pve_eventpoint_complete";
		
		public function SceneEvent()
		{
		}
	}
}