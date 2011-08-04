package tetrad
{
	import ultis.Color;

	public class TetradL extends Tetrad
	{
		public function TetradL()
		{
			color = Color.orange;
			shapeArray = [
				[0,0,0,0],
				[0,1,0,0],
				[0,1,0,0],
				[0,1,1,0]
			];
		}
	}
}