package tetrad
{
	import ultis.Color;

	public class TetradT extends Tetrad
	{
		public function TetradT()
		{
			color = Color.blue;
			shapeArray = [
				[0,0,0,0],
				[0,1,0,0],
				[1,1,1,0],
				[0,0,0,0]
			];
		}
	}
}