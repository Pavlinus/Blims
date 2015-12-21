package com.pavgame.Blims {
	import flash.desktop.NativeApplication;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.display.Image;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class Welcome extends Sprite {
		var playText : TextField;
		var exitText : TextField;
		var titleText:TextField;
		
		public function Welcome() {
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
				GameTextures.WelcomeBackground));
			
			titleText = new TextField(550, 65, "somewhere wars", 
				"StarJedi", 50, 0xffa800, true);
			titleText.alignPivot("center", "top");
			titleText.x = background.width / 2;
			titleText.y = 50;
			
			playText = new TextField(200, 60, "play", 
				"StarJedi", 40, 0xffffff, true);
			playText.alignPivot("left", "center");
			playText.x = 50;
			playText.y = background.height / 2 - 70;
			
			exitText = new TextField(200, 60, "quit", 
				"StarJedi", 40, 0xffffff, true);
			exitText.alignPivot("left", "center");
			exitText.x = 50;
			exitText.y = background.height / 2;
			
			this.addEventListener(TouchEvent.TOUCH, onItemTouch);
			
			addChild(background);
			addChild(titleText);
			addChild(playText);
			addChild(exitText);
		}
		
		function onItemTouch(event:TouchEvent) : void
		{
			var target : TextField = event.target as TextField;
			
			if(target == titleText)
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
			} else if((target as TextField) == exitText) {
				NativeApplication.nativeApplication.exit();
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
		
		public function Initialize() : void
		{
			this.visible = true;
			this.addEventListener(TouchEvent.TOUCH, onItemTouch);
		}
	}
}
