package com.pavgame.Blims {
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import starling.events.TouchEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	/**
	 * @author Pavlinus
	 */
	public class GameOver extends Sprite {
		var playText : TextField;
		var menuText : TextField;
		var victoryText:TextField;
		var victory : Boolean;
			
		public function GameOver() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		function onAddedToStage(event : Event) : void
		{
			DrawScreen();
		}
		
		function DrawScreen() : void
		{			
			var background : Image = new Image(GameTextures.GetTexture(
				GameTextures.GameOverBackground));
			
			var vicText : String = victory ? "victory" : "defeat";
			
			victoryText = new TextField(300, 60, vicText, 
				"StarJedi", 50, 0xffa800, true);
			victoryText.alignPivot("left", "center");
			victoryText.x = 40;
			victoryText.y = 50;
			
			playText = new TextField(200, 60, "play", 
				"StarJedi", 40, 0xffffff, true);
			playText.alignPivot("left", "center");
			playText.x = 50;
			playText.y = background.height / 2 - 60;
			
			menuText = new TextField(200, 60, "menu", 
				"StarJedi", 40, 0xffffff, true);
			menuText.alignPivot("left", "center");
			menuText.x = 50;
			menuText.y = background.height / 2 + 30;
			
			this.addEventListener(TouchEvent.TOUCH, onItemTouch);
			
			addChild(background);
			addChild(victoryText);
			addChild(playText);
			addChild(menuText);
		}
		
		function onItemTouch(event:TouchEvent) : void
		{
			var target : TextField = event.target as TextField;
			
			if(target == victoryText)
			{
				return;
			}
			
			if(event.getTouch(target, TouchPhase.BEGAN) != null)
			{
				AnimateTouch(target, 0.95, 0xffa800);
			} else if (event.getTouch(target, TouchPhase.ENDED) != null) {
				AnimateTouch(target, 1, 0xffffff);
				PushTextButton(target);
			} else if (event.getTouch(target, TouchPhase.HOVER) != null) {
				AnimateTouch(target, 1, 0xffa800);
			} else if (event.getTouch(target, TouchPhase.HOVER) == null) {
				AnimateTouch(target, 1, 0xffffff);
			}
		}
		
		function PushTextButton(target : TextField) : void
		{
			if((target as TextField) == playText)
			{
				this.dispatchEvent(new NavigationEvent(
					NavigationEvent.CHANGE_SCREEN, {id: "replay"}, true));
			} else if((target as TextField) == menuText) {
				this.dispatchEvent(new NavigationEvent(
					NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
			}
		}
		
		function AnimateTouch(target:TextField, scale:Number, color:Number,
			time:Number = 0.15) : void
		{
			var tween : Tween = new Tween(target, time);
			
			tween.animate("color", color);
			tween.animate("scaleX", scale);
			tween.animate("scaleY", scale);
			
			Starling.juggler.add(tween);
		}
		
		public function disposeTemporarely() : void
		{
			this.visible = false;
			
			if(this.hasEventListener(TouchEvent.TOUCH))
			{
				this.removeEventListener(TouchEvent.TOUCH, onItemTouch);
			}
		}
		
		public function Initialize(_victory : Boolean) : void
		{
			if(_victory)
			{
				victory = _victory;
				DrawScreen();
			} else {
				this.addEventListener(TouchEvent.TOUCH, onItemTouch);
			}
			
			this.visible = true;
		}
	}
}
