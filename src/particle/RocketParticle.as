package particle 
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	public class RocketParticle extends FlxParticle {
		
		public function RocketParticle() {
			loadGraphic(Resource.IMPORT_ROCKET_SPARK);
			exists = false;
			visible = false;
			this.color = 0xFFFFAA;
		}
		
		public override function update():void {
			super.update();
			_ct = Math.max(_ct - 1, 0);
			var pct:Number = _ct / 50;
			this.color = (0xFFA500 - 0xFFFFAA) * (1 - pct) + 0xFFFFAA;
			this.alpha = pct;
		}
		
		var _ct:Number = 0;
		public override function onEmit():void {
			_ct = 50;
			super.onEmit();
		}
		
	}

}