package gameobj 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class HealthPack extends FlxSprite {
		
		public var _aid:int;
		public var _taken:Boolean;
		
		public function HealthPack(x:Number = 0) {
			super(x, -64);
			
			this._aid = Util.int_random(15, 20);
			this._taken = false;
			
			this.loadGraphic(Resource.IMPORT_ENERGY_DRINK, true, false, 20, 48);
			this.addAnimation("spin", [1, 2, 3, 4, 5], 15);
			this.play("spin");
		}
		
		public function powerup_update(game:GameEngine):void {
			this.y += 1;
		}
		
		public function taken():void {
			this._taken = true;
			FlxG.play(Resource.IMPORT_SOUND_POWER_UP);
		}
		
		public function do_remove():void { }
		
		public function should_remove():Boolean {
			return this.y >= 500 || this._taken;
		}
	}

}