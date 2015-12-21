package com.pavgame.Blims {
	import starling.events.Event;
	import flash.utils.getTimer;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.text.TextField;

	/**
	 * @author Pavlinus
	 */
	public class Timer extends TextField {
		var lastUpdate : Number = 0;
		var curTime : int;
		
		public function Timer(width : int, height : int, 
			text : String, fontName : String = "Verdana", 
			fontSize : Number = 12, color : uint = 0, 
			bold : Boolean = false) 
		{
			super(width, height, text, fontName, fontSize, color, bold);
		}
		
		public function Activate() : void
		{
			if(!this.hasEventListener(Event.ENTER_FRAME))
			{
				this.addEventListener(Event.ENTER_FRAME, onTimerUpdate);	
			}
			curTime = 120;
		}
		
		public function Deactivate() : void 
		{
			removeEventListener(Event.ENTER_FRAME, onTimerUpdate);
		}
		
		function AnimateTimer(time:Number, scale:Number, delay:Number) : void
		{
			var tween:Tween = new Tween(this, time);
			
			tween.animate("scaleX", scale);
			tween.animate("scaleY", scale);
			tween.delay = delay;
				
			Starling.juggler.add(tween);
		}
		
		function onTimerUpdate() : void
		{
			var elapsed:Number = getTimer() - lastUpdate;
			
			if(elapsed >= 1000)
			{
				AnimateTimer(0.15, 1.1, 0);
				SetTime();
				AnimateTimer(0.15, 1, 0.15);
				
				lastUpdate = getTimer();
			}
		}
		
		function SetTime() : void
		{
			var min : int = curTime / 60;
			var sec : int = curTime - min * 60;
			var textStr : String;
			
			if(curTime == 0)
			{
				removeEventListener(Event.ENTER_FRAME, onTimerUpdate);
				this.dispatchEvent(new NavigationEvent(
					NavigationEvent.CHANGE_SCREEN, {id: "gameover", victory: false}, true));
			} else {;
				curTime -= 1;
			}
			
			min < 10 ? textStr = "0" + min : min;
			textStr += " : ";
			sec < 10 ? textStr += "0" + sec : textStr += sec;
			text = textStr;
		}
	}
}
