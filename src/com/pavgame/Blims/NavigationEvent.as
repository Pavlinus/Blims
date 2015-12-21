package com.pavgame.Blims {
	import starling.events.Event;

	/**
	 * @author Pavlinus
	 */
	public class NavigationEvent extends Event {
		public static const CHANGE_SCREEN : String = "changeScreen";
		
		var params : Object;
		
		public function NavigationEvent(type : String, 
			_params : Object = null, 
			bubbles : Boolean = false, 
			data : Object = null) 
		{
			super(type, bubbles, data);
			this.params = _params;
		}
	}
}
