package com.pavgame.Blims {
	import starling.text.TextField;
	import starling.display.Image;
	import starling.events.Event;
	import starling.utils.Color;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class InGame extends Sprite {
		var timer : Timer;
		var itemsLeftText : TextField;
		
		public function InGame() {
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		function onAddedToStage() : void
		{
			DrawScreen();
		}
		
		function DrawScreen() : void 
		{
			GameComponents.rightPositions = 0;
			
			var quad:Quad = new Quad(960, 540, Color.WHITE);
			var background:Image = new Image(GameTextures.GetTexture(
				GameTextures.Background));
			var arrLeft : Arrow = new Arrow(GameTextures.LeftArrow);
			var arrRight : Arrow = new Arrow(GameTextures.RightArrow);
			var oCont:SpriteContainer = new SpriteContainer(
				GameTextures.OrangeBack, quad.width / 2, 
				GameTextures.TrooperLight);
			var bCont:SpriteContainer = new SpriteContainer(
				GameTextures.BlueBack, -240, 
				GameTextures.DarkLight);
			var rCont:SpriteContainer = new SpriteContainer(
				GameTextures.RedBack, quad.width + 240, 
				GameTextures.StarLight);
			
			itemsLeftText = new TextField(400, 60, 
				"21 items left", "StarJediOut", 40, 0xffa800, true);
			timer = new Timer(300, 60, "", "StarJedi", 35, Color.WHITE, true);
				
			GameComponents.Container_orange = oCont;
			GameComponents.Container_blue = bCont;
			GameComponents.Container_red = rCont;
			
			background.alpha = 0.85;
			
			itemsLeftText.alignPivot();
			itemsLeftText.x = quad.width / 2;
			itemsLeftText.y = 50;
			
			timer.alignPivot();
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
			
			this.addEventListener(Event.ENTER_FRAME, CheckGameOver);
		}
		
		function CheckGameOver() : void
		{
			itemsLeftText.text = (21 - GameComponents.rightPositions) + " items left";
			
			if(GameComponents.rightPositions >= 21)
			{
				GameComponents.rightPositions = 0;
				dispatchEvent(new NavigationEvent(
					NavigationEvent.CHANGE_SCREEN, {id: "gameover", victory: true}, true));
			}
		}
		
		public function disposeTemporarely() : void
		{
			this.visible = false;
			
			if(this.hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, CheckGameOver);
			}
		}
		
		public function Initialize(replay : Boolean = false) : void
		{
			if(replay)
			{
				DrawScreen();
			} else {
				this.addEventListener(Event.ENTER_FRAME, CheckGameOver);
			}
			
			this.visible = true;
			
			timer.Activate();
		}
	}
}
