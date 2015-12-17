package com.pavgame.Blims {
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	import starling.display.Image;

	/**
	 * @author Pavlinus
	 */
	public class Arrow extends Image 
	{
		var arrowClass : Class;
		var enabled:Boolean;
		const moveByX : int = 40;
		
		public function Arrow(textureClass : Class) {
			super(GameTextures.GetTexture(textureClass));
			arrowClass = textureClass;
			enabled = true;
			
			addEventListener(TouchEvent.TOUCH, onArrowTouch);
			Starling.current.stage.addEventListener("moveContainerEnd", onMoveEventEnd);
		}
		
		function onArrowTouch(event:TouchEvent) : void
		{
			if (event.getTouch(this, TouchPhase.ENDED) != null) 
			{	
				AnimateArrow(0.15, 1, 1);
				
				if(enabled)
				{
					// Left arrow touched
					if(arrowClass == GameTextures.LeftArrow && 
						GameComponents.positionIndex >= 0)
					{
						GameComponents.positionIndex--;
						GameComponents.moveDirection = moveByX;
					// Right arrow touched
					} else if (arrowClass == GameTextures.RightArrow && 
						GameComponents.positionIndex <= 0) 
					{
						GameComponents.positionIndex++;
						GameComponents.moveDirection = -moveByX;
					} else {
						return;
					}
				
					enabled = false;
					dispatchEventWith("moveContainer", true);
				}
			} else if (event.getTouch(this, TouchPhase.BEGAN) != null) {
				AnimateArrow(0.15, 0.7, 0.5);
			}
		}
		
		function AnimateArrow(timer:Number, scale:Number, alpha:Number) : void
		{
			var tween:Tween = new Tween(this, timer);
				
			tween.animate("scaleX", scale);
			tween.animate("scaleY", scale);
			tween.animate("alpha", alpha);
				
			Starling.juggler.add(tween);
		}
		
		// Containers stopped movement
		function onMoveEventEnd() : void
		{
			enabled = true;
		}
	}
}
