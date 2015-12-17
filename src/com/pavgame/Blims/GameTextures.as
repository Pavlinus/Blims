package com.pavgame.Blims {
	import starling.utils.ArrayUtil;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	/**
	 * @author Pavlinus
	 */
	public class GameTextures {
		[Embed(source="/../res/empire_100.png")]
		public static const GrayBack:Class;
		
		[Embed(source="/../res/dark_100.png")]
		public static const BlueBack:Class;
		
		[Embed(source="/../res/trooper_100.png")]
		public static const OrangeBack:Class;
		
		[Embed(source="/../res/death_star_100.png")]
		public static const RedBack:Class;
		
		[Embed(source="/../res/arrow_left.png")]
		public static const LeftArrow:Class;
		
		[Embed(source="/../res/arrow_right.png")]
		public static const RightArrow:Class;
		
		[Embed(source="/../res/dark_100_light.png")]
		public static const DarkLight:Class;
		
		[Embed(source="/../res/death_star_100_light.png")]
		public static const StarLight:Class;
		
		[Embed(source="/../res/trooper_100_light.png")]
		public static const TrooperLight:Class;
		
		public static const texturesCount:int = 3;
		
		const arrCapacity:int = 7;
		
		public function GameTextures()
		{
		}
		
		public static function GetTexture(sBack:Class):Texture
		{	
			var bmp:Bitmap = new sBack();
			return Texture.fromBitmap(bmp);
		}
		
		// Returns sequence of texture class numbers
		public function GetSequence(texClass:Class):Array
		{
			var arr:Array;
			
			switch(texClass)
			{
				case BlueBack:
					arr = GenerateSequence(1, 4, 2);
					break;
					
				case OrangeBack:
					arr = GenerateSequence(3, 1, 3);
					break;
					
				case RedBack:
					arr = GenerateSequence(3, 2, 2);
					break;
			}
			
			return arr;
		}
		
		// Generates number sequence of texture classes
		// 0 - blue texture
		// 1 - orange texture
		// 2 - red texture
		function GenerateSequence(bCount:int, oCount:int, rCount:int):Array
		{
			var arr:Array = new Array();
			var index:int = 0;
			var count:int = bCount;
			
			AddRange(arr, index, count, 0);
			index += bCount;
			count += oCount;
			
			AddRange(arr, index, count, 1);
			index += oCount;
			count += rCount;
			
			AddRange(arr, index, count, 2);
			
			return arr;
		}
		
		// Pushes value to array in range [index, topBound]
		function AddRange(arr:Array, index:int, topBound:int, value:int):Array
		{
			for(var i:int = index; i < topBound; i++)
			{				
				ArrayUtil.insertAt(arr, i, value);
			}
			
			return arr;
		}
	}
}
