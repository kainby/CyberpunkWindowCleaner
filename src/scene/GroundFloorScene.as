package scene {
	import core.*;
	import misc.ScrollingTextBubble;
	import particle.CableParticle;
	public class GroundFloorScene extends Scene {
		
		private static var SCRIPT:Array = [
			{PERCENT:0, CHARACTER:CHARACTER_CLEANER, POSITION:[350, 390], ID:0  },
			{PERCENT:0, CHARACTER:CHARACTER_CLEANER, POSITION:[550, 390], ID:1  },
			{PERCENT:0, CHARACTER:CHARACTER_CLEANER, POSITION:[600, 390], ID:2  },
		];
		
		public function GroundFloorScene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR0_BG));
			_boss = _character_group.members[0];
			_cleaner1 = _character_group.members[1];
			_cleaner2 = _character_group.members[2];
			_g.add_particle(new CableParticle(_cleaner1));
			_g.add_particle(new CableParticle(_cleaner2));
			return this;
		}
		
		private var _boss:SceneCharacter;
		private var _cleaner1:SceneCharacter;
		private var _cleaner2:SceneCharacter;
		private var _mode:Number = 0;
		private var _boss_text:ScrollingTextBubble = null;
		private var _ct:Number = 0;
		
		public override function update():void {
			if (_mode == 0) {
				cons_text_bubble("Alright boys, we've got a job to do here.");
				_mode = 1;
			} else if (_mode == 1) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					cons_text_bubble("Clean this building. 80% or so is good enough.");
					_mode = 2;
				}
			} else if (_mode == 2) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					cons_text_bubble("And watch out for any suspicious elements. Got it?");
					_mode = 3;
				}
			} else if (_mode == 3) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					_mode = 4;
					_ct = 200;
					_text_group.remove(_boss_text);
					_boss_text.end();
					_boss_text = null;
				}
			} else if (_mode == 4) {
				_cleaner1.play(Player.ANIM_SALUTEFRONT);
				_cleaner2.play(Player.ANIM_SALUTEFRONT);
				_ct--;
				if (_ct <= 0) _mode = 5;
				
			} else if (_mode == 5) {
				_cleaner1.play(ANIM_WALK);
				_cleaner2.play(ANIM_WALK);
				_cleaner1.y--;
				_cleaner2.y--;
				if (_cleaner1.y < -200) {
					cons_text_bubble("What are you waiting for?");
					_mode = 6;
				}
				
			} else if (_mode == 6) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					cons_text_bubble("Arrow keys to move and space to jump. Move it!");
					_mode = 6;
				}
			}
		}
		
		private function cons_text_bubble(str:String):void {
			if (_boss_text != null) {
				_text_group.remove(_boss_text);
				_boss_text.end();
				_boss_text = null;
			}
			_boss_text = new ScrollingTextBubble(str);
			_text_group.add(_boss_text);
			_boss_text.set_pos(_boss.x+7, _boss.y);
		}
		
		public override function show_hp_bar():Boolean { return false; }
		public override function can_continue():Boolean { return true; }
		public override function get_player_x_min():Number { return 1000; }
		public override function get_player_x_max():Number { return 0; }
		public override function get_player_y_max():Number { return 390; }
		
	}

}