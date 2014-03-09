package gameobj 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class HealthPack extends FlxSprite {
		
		public var _aid:int;
		public var _taken:Boolean;
		
		public function HealthPack(x:Number = 0) {
			super(x, -64);
			
			this._aid = 20 + Util.int_random(0, 5);
			this._taken = false;
			
			this.loadGraphic(Resource.IMPORT_ENERGY_DRINK, true, false, 20, 48);
			this.addAnimation("spin", [1, 2, 3, 4, 5], 15);
			this.play("spin");
		}
		
		public function health_pack_update(game:GameEngine):void {
			this.y += 1;
		}
		
		public function taken():void {
			this._taken = true;
		}
		
		public function do_remove():void { }
		
		public function should_remove():Boolean {
			return this.y >= 500 || this._taken;
		}
	}

}