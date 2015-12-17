package com.pavgame.Blims {
	import flash.display.Sprite;
	import starling.core.Starling;

	/**

	 * @author Pavlinus
	 */
	[SWF(width="960", height="540", frameRate="60", backgroundColor="#FFFFFF")]
	public class Blims extends Sprite 
	{
		private var mStarling:Starling;
		
		public function Blims() {
			mStarling = new Starling(Game, stage);
			mStarling.start();
		}
	}
}
