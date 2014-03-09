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
		
		public var _body:FlxSprite = new FlxSprite();
		
		public var _body_hit_box:FlxSprite = new FlxSprite();
		public var _wiper_hit_box:FlxSprite = new FlxSprite();
		
		public function Player() {
			super();
			
			_cable.loadGraphic(Resource.IMPORT_CLEANER_GUY_CABLE);
			this.add(_cable);
			
			_body.loadGraphic(Resource.IMPORT_CLEANER_GUY,true,true,37,76);
			_body.addAnimation(ANIM_WALK, [2, 1, 0, 1], 10);
			_body.addAnimation(ANIM_STAND, [2], 0);
			this.continue_animation(ANIM_STAND);
			this.add(_body);
			
			_body_hit_box.loadGraphic(Resource.IMPORT_25x40);
			_body_hit_box.alpha = 0;
			this.add(_body_hit_box);
			
			_wiper_hit_box.loadGraphic(Resource.IMPORT_12x8);
			_wiper_hit_box.alpha = 0;
			this.add(_wiper_hit_box);
			
			this.set_pos(Util.WID / 2, Util.HEI / 2);
		}
		public override function update_position():void {
			_cable.set_position(x()+5, y()-460);
			_body.set_position(x(), y());
			_body_hit_box.set_position(x()+4, y()+25);
			_wiper_hit_box.set_position(x()+15, y()-1);
			
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