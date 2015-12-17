package com.pavgame.Blims {
	import starling.events.Event;
	import starling.utils.Color;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class Game extends Sprite {
		public function Game() {	
			var quad:Quad = new Quad(960, 640, Color.WHITE);
			var arrLeft : Arrow = new Arrow(GameTextures.LeftArrow);
			var arrRight : Arrow = new Arrow(GameTextures.RightArrow);
					
			var oCont:SpriteContainer = new SpriteContainer(
				GameTextures.OrangeBack, quad.width / 2, GameTextures.TrooperLight);
			var bCont:SpriteContainer = new SpriteContainer(
				GameTextures.BlueBack, -240, GameTextures.DarkLight);
			var rCont:SpriteContainer = new SpriteContainer(
				GameTextures.RedBack, quad.width + 240, GameTextures.StarLight);
				
			GameComponents.Container_orange = oCont;
			GameComponents.Container_blue = bCont;
			GameComponents.Container_red = rCont;
			
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
			addChild(oCont);
			addChild(bCont);
			addChild(rCont);
			addChild(arrLeft);
			addChild(arrRight);
			
			addEventListener(Event.ENTER_FRAME, CheckGameOver);
		}
		
		function CheckGameOver() : void
		{
			if(GameComponents.rightPositions >= 21)
			{
				// Game over win
			}
		}
	}
}
