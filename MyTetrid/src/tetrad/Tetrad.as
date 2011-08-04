package tetrad
{
	public class Tetrad
	{
		public var shapeArray:Array;
		public var color:uint;
		public var x:Number;
		public var y:Number;
		
		public function Tetrad()
		{
			
		}
		
		public static function createTetrad():Tetrad
		{
			var randNum:Number = Math.random();
			
			if (randNum <0.2) {
				return new TetradL();
			}else if (randNum <0.4) {
				return new TetradO();
			}else if (randNum <0.6) {
				return new TetradI();
			}else if (randNum <0.7) {
				return new TetradS();
			}else if(randNum<0.8){
				return new TetradT();
			}else {
				return new TetradZ();
			}
			
			return null;
		}
	}
}