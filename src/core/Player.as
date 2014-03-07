package core {
	import misc.FlxGroupSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import flash.display.Bitmap;
	
	public class Player extends FlxGroupSprite {
		
		public static var ANIM_STAND:String = "ANIM_STAND";
		public static var ANIM_WALK:String = "ANIM_WALK";
		
		public var _cable:FlxSprite = new FlxSprite();
		public var _cable_offset:FlxPoint = new FlxPoint(5, -470);
		
		public var _body:FlxSprite = new FlxSprite();
		
		public function Player() {
			super();
			
			_cable.loadGraphic(Resource.IMPORT_CLEANER_GUY_CABLE);
			this.add(_cable);
			
			_body.loadGraphic(Resource.IMPORT_CLEANER_GUY,true,true,35,69);
			_body.addAnimation(ANIM_WALK, [0, 1, 2], 10);
			_body.addAnimation(ANIM_STAND, [0], 0);
			this.continue_animation(ANIM_STAND);
			this.add(_body);
			
			this.set_pos(Util.WID / 2, Util.HEI / 2);
		}
		public override function update_position():void {
			_cable.set_position(x()+_cable_offset.x, y()+_cable_offset.y);
			_body.set_position(x(), y());
			
		}
		
		private var _cur_anim:String = "NONE";
		private function continue_animation(anim:String):void {
			if (anim != _cur_anim) {
				_cur_anim = anim;
				_body.play(anim);
			}
		}
		
		public function update_player(g:GameEngine):void {
			this.continue_animation(g._is_moving ? ANIM_WALK : ANIM_STAND);
		}
		
		
	}

}