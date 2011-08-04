package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 *游戏画面类 
	 * @author liweiwei
	 * 
	 */	
	public class GameScreen extends Sprite
	{
		private var _score_txt:TextField;
		
		public function GameScreen(score_txt:TextField)
		{
			_score_txt = score_txt;
		}
	}
}