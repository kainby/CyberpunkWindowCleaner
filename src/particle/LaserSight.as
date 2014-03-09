package particle {
	public class LaserSight extends Particle {
		public function LaserSight() {}
		public override function should_remove():Boolean {
			return false;
		}
	}

}