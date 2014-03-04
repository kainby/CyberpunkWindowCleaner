package core {
	import misc.FlxGroupSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import flash.display.Bitmap;
	
	public class Player extends FlxGroupSprite {
		
		public var _cable:FlxSprite = new FlxSprite();
		public var _cable_offset:FlxPoint = new FlxPoint(15, -480);
		
		public var _body:FlxSprite = new FlxSprite();
		
		public function Player() {
			super();
			
			_cable.loadGraphic(Resource.IMPORT_CLEANER_GUY_CABLE);
			this.add(_cable);
			
			_body.loadGraphic(Resource.IMPORT_CLEANER_GUY);
			this.add(_body);
			
			this.set_pos(Util.WID / 2, Util.HEI / 2);
		}
		public override function update_position():void {
			_cable.set_position(x()+_cable_offset.x, y()+_cable_offset.y);
			_body.set_position(x(), y());
		}
		
		
	}

}