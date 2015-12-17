package com.pavgame.Blims {
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;

	/**
	 * @author Pavlinus
	 */
	public class SpriteContainer extends Sprite 
	{
		var cDimension:int = 3;
		var offset:int = 10;
		var centerImg:Class;
		var gTextures:GameTextures;
		var indSequence:Array;
		var moved:Boolean;
		var moveRightPos:int;
		var startPosition:int;
		var moveLeftPos:int;
		var moveDirection:int;
		var highlightImg:Class;
		
		public function SpriteContainer(cImg:Class, 
			startPos:int, 
			highlightedImg:Class = null) 
		{
			moved = false;
			centerImg = cImg;
			gTextures = new GameTextures();
			indSequence = gTextures.GetSequence(cImg);
			moveLeftPos = startPos - 720;
			moveRightPos = startPos + 720;
			startPosition = startPos;
			moveDirection = 0;
			highlightImg = highlightedImg;
			
			InitContainer();
			addEventListener(Event.ENTER_FRAME, onMoveContainer);
			Starling.current.stage.addEventListener("moveContainer", onMoveEvent);
		}
		
		function InitContainer():void 
		{			
			for(var row:int = 0; row < cDimension; row++) 
			{
				for(var col:int = 0; col < cDimension; col++) 
				{
					var imgItem:Item;
					
					// Central item
					if(row == 1 && col == 1) 
					{
						imgItem = new Item(this, centerImg, highlightImg, false);
						imgItem.x = imgItem.width * col - 20;
						imgItem.y = imgItem.height * row - 20;
						addChild(imgItem);
						continue;
					} else if(row == 0 && col == 0) {
						imgItem = new Item(this, GameTextures.GrayBack, null, true);
					} else {
						imgItem = new Item(this, GetTextureClass(indSequence.pop()), null, true);
					}
					
					imgItem.x = imgItem.width * col + offset * col;
					imgItem.y = imgItem.height * row + offset * row;
										
					addChild(imgItem);
				}
			}
		}
		
		function GetTextureClass(index:Object):Class
		{
			var texClass:Class;
			
			switch(int(index))
			{
				case 0:
					texClass = GameTextures.BlueBack;
					break;
				
				case 1:
					texClass = GameTextures.OrangeBack;
					break;
				
				case 2:
					texClass = GameTextures.RedBack;
					break;
			}
			
			return texClass;
		}
		
		function onMoveContainer() : void
		{			
			// Is moving
			if(moveDirection != 0)
			{		
				// If on position
				if((x == moveLeftPos || x == moveRightPos || x == startPosition) && moved)
				{
					if(moved)
					{
						moved = false;
						moveDirection = 0;
					} 		
				} else {
					x += moveDirection;
					moved = true;
				}
			} else {
				dispatchEventWith("moveContainerEnd", true);
			}
		}
		
		// When arrow was clicked
		function onMoveEvent() : void
		{
			moveDirection = GameComponents.moveDirection;
		}
		
		public function GetContainerClass():Class
		{
			return centerImg;
		}
	}
}
