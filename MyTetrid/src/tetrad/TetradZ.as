package tetrad
{
	import ultis.Color;

	public class TetradZ extends Tetrad
	{
		public function TetradZ()
		{
			color = Color.yellow;
			shapeArray = [
				[0,0,0,0],
				[1,1,0,0],
				[0,1,1,0],
				[0,0,0,0],
			];
		}
	}
}