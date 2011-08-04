/*
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2007
 * Version: 1.0.0
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	import uk.co.bigroom.tetris.Controller;
	import uk.co.bigroom.tetris.TetrisEvent;

	/**
	 * Main class used in the Blox game.
	 */

	[SWF(width="1024", height="600",backgroundColor=0xEEEEEE)]
	public class Blox extends Sprite 
	{
		public var game:Controller;
		private var score:Number;
		private var screen:Sprite;
		
		private var _loader:Loader;
		public static var _appDomain:ApplicationDomain;
		
		
		public function Blox()
		{	
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.load(new URLRequest("files/src.swf"));
		}

		private function onComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = e.target as LoaderInfo;
			_appDomain = loaderInfo.applicationDomain;
			
			screen = new StartScreen();
			addChild( screen );
			StartScreen( screen ).play_btn.addEventListener( MouseEvent.CLICK, playGame, false, 0, true );
		}
		
		public static function getMat(className:String):Object
		{
			if(_appDomain && _appDomain.hasDefinition(className))
			{
				var mat:Class = _appDomain.getDefinition(className) as Class;
				return new mat();
			}
			return null;
		}
		
		public function playGame( ev:MouseEvent ):void
		{
			removeChild( screen );
			screen = new GameScreen();
			addChild( screen );
			
			game = new Controller( screen, new BloxConfig() );
			game.addEventListener( TetrisEvent.SCORE_CHANGE, scoreChanged, false, 0, true );
			game.addEventListener( TetrisEvent.GAME_OVER, gameOver, false, 0, true );
			game.startGame();
			
			GameScreen( screen ).pause.addEventListener( PauseButton.PAUSE, pauseGame, false, 0, true );
			GameScreen( screen ).pause.addEventListener( PauseButton.RESUME, resumeGame, false, 0, true );
			GameScreen( screen ).mute.addEventListener( MuteButton.SOUND_OFF, soundOff, false, 0, true );
			GameScreen( screen ).mute.addEventListener( MuteButton.SOUND_ON, soundOn, false, 0, true );
		}
		
		public function scoreChanged( ev:TetrisEvent ):void
		{
			score = ev.score;
			GameScreen( screen ).score_txt.text = ev.score.toString();
		}
		
		public function gameOver( ev:TetrisEvent ):void
		{
			game.removeEventListener( TetrisEvent.SCORE_CHANGE, scoreChanged );
			game.removeEventListener( TetrisEvent.GAME_OVER, gameOver );
			score = game.score;
			removeChild( screen );
			screen = new EndScreen();
			addChild( screen );
			EndScreen( screen ).play_btn.addEventListener( MouseEvent.CLICK, playGame );
			EndScreen( screen ).score_txt.text = score.toString();
		}
		
		public function pauseGame( ev:Event ):void
		{
			game.pauseGame();
		}
		
		public function resumeGame( ev:Event ):void
		{
			game.playGame();
		}
		
		public function soundOff( ev:Event ):void
		{
			game.soundOn = false;
		}
		
		public function soundOn( ev:Event ):void
		{
			game.soundOn = true;
		}
	}
}
