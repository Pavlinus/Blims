package com.pavgame.Blims {
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.textures.Texture;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.Image;
	
	/**
	 * @author Pavlinus
	 */
	public class Item extends Image {
		var texClass:Class;
		var parentObj:SpriteContainer;
		
		public function Item(parentContainer:SpriteContainer, 
				tex:Class, pic:Class = null, listener:Boolean = false) {
			var tmp:Class = pic;
			
			if(tmp == null) 
			{
				tmp = tex;
			}
			
			super(GameTextures.GetTexture(tmp));
			
			texClass = tex;
			parentObj = parentContainer;
			
			// If item is on right position
			if(texClass == parentObj.GetContainerClass())
			{
				if (listener) 
				{
					GameComponents.rightPositions += 1;
				}
				
				listener = false;
			}
			
			if(listener) {
				addEventListener(TouchEvent.TOUCH, onImageTouch);
			}
		}
		
		function onImageTouch(event:TouchEvent):void
		{	
			var swapItem:Item;
			var tmpTexClass:Class = texClass;
			var tmpTexture:Texture = texture;
			
			if (event.getTouch(this, TouchPhase.ENDED) != null) 
			{
				// If the same button was touched
				if(SpriteSwap.swapImage == this) 
				{
					SpriteSwap.swapImage = null;
					AnimateImage(0.2, 1, 0xffffff);
					return;
				}
				
				if(SpriteSwap.swapImage != null) 
				{
					swapItem = SpriteSwap.swapImage;
					
					texture = swapItem.texture;
					texClass = swapItem.texClass;
					AnimateImage(0.2, 1, 0xffffff);
					
					swapItem.texClass = tmpTexClass;
					swapItem.texture = tmpTexture;
					SpriteSwap.swapImage = null;
					
					CheckRightPosition();
					swapItem.CheckRightPosition();
					swapItem.AnimateImage(0.2, 1, 0xffffff);
				} else if(texClass != GameTextures.GrayBack) {
					SpriteSwap.swapImage = this;
				} else {
					this.AnimateImage(0.2, 1, 0xffffff);
					SpriteSwap.swapImage = null;
				}
			} else if (event.getTouch(this, TouchPhase.BEGAN) != null) {
				AnimateImage(0.2, 1.05, 0xffa800);
			}
		}
		
		public function AnimateImage(timer:Number, scale:Number, color:Number) : void
		{
			var tween:Tween = new Tween(this, timer);
			
			tween.animate("scaleX", scale);
			tween.animate("scaleY", scale);
			tween.animate("color", color);
			
			Starling.juggler.add(tween);
		}
		
		// Check if image is on right position
		public function CheckRightPosition() : void
		{
			if(texClass == parentObj.GetContainerClass())
			{
				removeEventListener(TouchEvent.TOUCH, onImageTouch);
				GameComponents.rightPositions += 1;
				// play right position animation 
			}
		}
	}
}
