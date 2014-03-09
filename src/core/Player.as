package core {
	import misc.FlxGroupSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import flash.display.Bitmap;
	
	public class Player extends FlxGroupSprite {
		
		public static var ANIM_STAND:String = "ANIM_STAND";
		public static var ANIM_WALK:String = "ANIM_WALK";
		public static var ANIM_HURT:String = "ANIM_HURT";
		public static var ANIM_STANDFRONT:String = "ANIM_STANDFRONT";
		public static var ANIM_SALUTEFRONT:String = "ANIM_SALUTEFRONT";
		
		public static var MAX_HP:Number = 10;
		
		public var _hurt_ct:Number = 0;
		
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
			_body.addAnimation(ANIM_HURT, [6,2], 10);
			_body.addAnimation(ANIM_STANDFRONT, [4], 0);
			_body.addAnimation(ANIM_SALUTEFRONT, [3, 5], 10);
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
			_hurt_ct = Math.max(0, _hurt_ct - 1);
			if (_hurt_ct > 0) {
				this.continue_animation(ANIM_HURT);
			} else if (g._is_moving) {
				this.continue_animation(ANIM_WALK);
			} else {
				this.continue_animation(ANIM_STAND);
			}
		}
		
		
	}

}