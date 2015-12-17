package com.pavgame.Blims {
	import starling.animation.Tween;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	/**
	 * @author Pavlinus
	 */
	public class GameOver extends Sprite {
		public function GameOver() 
		{
			width = 960;
			height = 540;
			x = 0;
			y = 0;
			alpha = 0;
			
			InitQuad();
		}
		
		function InitQuad() : void
		{
			var textValue:String = GameComponents.victory ? "victory" : "defeat";
			var text:TextField = new TextField(400, 60, textValue, 
				"StarJedi", 50, 0xffa800, true);
			text.alignPivot("left", "center");
			text.x = this.width / 2;
			text.y = 50;
			
			var background : Image = new Image(GameTextures.GetTexture(
				GameTextures.GameOverBackground));
			background.x = 0;
			background.y = 0;
			
			var playText : TextField = new TextField(400, 60, "play", 
				"StarJedi", 40, 0xffffff, true);
			playText.alignPivot("left", "center");
			playText.x = 0;
			playText.y = height / 2 + 10;
			playText.addEventListener(TouchEvent.TOUCH, PlayTouched);
			
			addChild(background);
			addChild(text);
			addChild(playText);
		}
		
		function PlayTouched(event:TouchEvent) : void
		{
			if(event.getTouch(this, TouchPhase.HOVER) != null)
			{
				var tween : Tween = new Tween(this, 0.15);
			}
		}
	}
}
