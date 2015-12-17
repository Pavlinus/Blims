package com.pavgame.Blims {
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.text.TextField;
	import starling.display.Image;
	import starling.events.Event;
	import starling.utils.Color;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class Game extends Sprite {
		public function Game() {	
			var quad:Quad = new Quad(960, 540, Color.WHITE);
			
			var background:Image = new Image(GameTextures.GetTexture(
				GameTextures.Background));
			
			var arrLeft : Arrow = new Arrow(GameTextures.LeftArrow);
			var arrRight : Arrow = new Arrow(GameTextures.RightArrow);
			
			var timer : Timer = new Timer(300, 60, "", "StarJedi", 35, 
				Color.WHITE, true);
			
			var itemsLeftText : TextField = new TextField(400, 60, 
				"21 items left", "StarJediOut", 40, 0xffa800, true);
					
			var oCont:SpriteContainer = new SpriteContainer(
				GameTextures.OrangeBack, quad.width / 2, 
				GameTextures.TrooperLight);
			var bCont:SpriteContainer = new SpriteContainer(
				GameTextures.BlueBack, -240, 
				GameTextures.DarkLight);
			var rCont:SpriteContainer = new SpriteContainer(
				GameTextures.RedBack, quad.width + 240, 
				GameTextures.StarLight);
				
			GameComponents.Container_orange = oCont;
			GameComponents.Container_blue = bCont;
			GameComponents.Container_red = rCont;
			
			background.alpha = 0.85;
			
			itemsLeftText.alignPivot();
			itemsLeftText.x = quad.width / 2;
			itemsLeftText.y = 50;
			
			timer.alignPivot();
			//timer.border = true;
			timer.x = timer.width / 2;
			timer.y = 50;
			
			oCont.alignPivot();
			oCont.x = quad.width / 2;
			oCont.y = quad.height / 2 + 20;
			
			bCont.alignPivot();
			bCont.x = -240;
			bCont.y = quad.height / 2 + 20;
			
			rCont.alignPivot();
			rCont.x = quad.width + 240;
			rCont.y = quad.height / 2 + 20;
			
			arrLeft.alignPivot("left", "center");
			arrLeft.x = 25;
			arrLeft.y = quad.height / 2;
			
			arrRight.alignPivot("right", "center");
			arrRight.x = quad.width - 25;
			arrRight.y = quad.height / 2;
			
			addChild(quad);
			addChild(background);
			addChild(oCont);
			addChild(bCont);
			addChild(rCont);
			addChild(arrLeft);
			addChild(arrRight);
			addChild(itemsLeftText);
			addChild(timer);
			
			addEventListener(Event.ENTER_FRAME, CheckGameOver);
			Starling.current.stage.addEventListener("GameOver", GameOverTransition);
		}
		
		function CheckGameOver() : void
		{
			if(GameComponents.rightPositions >= 21)
			{
				GameComponents.victory = true;
				GameOverTransition();
				GameComponents.victory = false;
			}
		}
		
		function GameOverTransition() : void
		{
			var tween : Tween;
			var gameOver : GameOver = new GameOver();
			addChild(gameOver);
			
			tween = new Tween(gameOver, 1);
			tween.animate("alpha", 1);
			
			Starling.juggler.add(tween);
		}
	}
}
