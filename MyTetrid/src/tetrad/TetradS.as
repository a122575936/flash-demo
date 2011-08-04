package tetrad
{
	import ultis.Color;

	public class TetradS extends Tetrad
	{
		public function TetradS()
		{
			color = Color.red;
			shapeArray = [
				[0,0,0,0],
				[0,1,1,0],
				[1,1,0,0],
				[0,0,0,0]
			];
		}
	}
}