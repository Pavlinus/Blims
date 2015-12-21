package com.pavgame.Blims {
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class Game extends Sprite {
		var screenGameOver : GameOver;
		var screenInGame : InGame;
		var screenWelcome:Welcome;
		
		public function Game() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		function onAddToStage(event : Event) : void
		{
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenWelcome = new Welcome();
			//screenWelcome.disposeTemporarely();
			this.addChild(screenWelcome);
			
			screenInGame = new InGame();
			screenInGame.disposeTemporarely();
			this.addChild(screenInGame);
			
			screenGameOver = new GameOver();
			screenGameOver.disposeTemporarely();
			this.addChild(screenGameOver);
		}
		
		function onChangeScreen(event : NavigationEvent) : void
		{
			switch(event.params.id)
			{
				case "play":
					screenWelcome.disposeTemporarely();
					screenInGame.Initialize();
					break;
					
				case "replay":
					screenGameOver.disposeTemporarely();
					screenInGame.Initialize(true);
					break;
					
				case "gameover":
					screenInGame.disposeTemporarely();
					screenGameOver.Initialize(event.params.victory as Boolean);
					break;
					
				case "welcome":
					screenGameOver.disposeTemporarely();
					screenWelcome.Initialize();
					break;
			}
		}
	}
}
