package {
	import core.*;
	import enemies.BaseEnemy;
	import enemies.SniperEnemy;
	import flash.geom.Rectangle;
	import org.flixel.system.input.Keyboard;
	import flash.utils.*;
	import gameobj.BasicBullet;
	import gameobj.BasicStain;
	import gameobj.HealthPack;
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import misc.ScrollingTextBubble;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	import particle.*;
	import scene.Floor1Scene;
	import scene.Floor2Scene;
	import scene.Floor3Scene;
	import scene.Floor4Scene;
	import scene.GroundFloorScene;
	import scene.Scene;
	import scene.TestScene;
	
	public class GameEngine extends FlxState {
		
		public static var ALWAYS_CONTINUE:Boolean = false;
		
		public var _is_moving:Boolean = false;
		public var _is_falling:Boolean = false;
		private static var MOVE_SPEED:Number = 1;
		private static var JUMP_SPEED:Number = 5;
		
		public var _bgobjs:FlxGroup = new FlxGroup();
		
		public var _sceneobjs:FlxGroup = new FlxGroup();
		public var _behind:FlxGroup = new FlxGroup();
		public var _enemies:FlxGroup = new FlxGroup();
		public var _player:Player = new Player();
		public var _stains:FlxGroup = new FlxGroup();
		public var _particles:FlxGroup = new FlxGroup();
		public var _enemies_front:FlxGroup = new FlxGroup();
		public var _bullets:FlxGroup = new FlxGroup();
		public var _powerups:FlxGroup = new FlxGroup();
		public var _enemy_speech:FlxGroup = new FlxGroup();
		
		public var _death_fadeout:Boolean = false, _death_fadein = false, _end_out = false;
		
		public var _cur_scene:Scene;
		public var _transition_from_scene:Scene = null;
		private var _scene_list:Vector.<Scene>;
		
		public var _hp:Number = Player.MAX_HP;
		public var _ui:GameUI;
		
		public override function create():void {
			super.create();
			
			Util.zoom_camera();
			
			_scene_list = Vector.<Scene>([
				//new Floor4Scene(this),
				new GroundFloorScene(this), 
				new Floor1Scene(this),
				new Floor2Scene(this),
				new Floor3Scene(this),
				new Floor4Scene(this)
			]);
			
			next_scene();
			_ui = new GameUI(this);
			
			this.add(_bgobjs);
			this.add(_behind);
			this.add(_enemies);
			this.add(_sceneobjs);
			this.add(_stains);
			this.add(_player);
			this.add(_enemies_front);
			this.add(_enemy_speech);
			this.add(_bullets);
			this.add(_particles);
			this.add(_powerups);
			this.add(_ui);
			
			_bgobjs.add(new BGObj(Resource.IMPORT_BG_0));
			_bgobjs.add(new BGObj(Resource.IMPORT_BG_1));
			_bgobjs.add(new BGObj(Resource.IMPORT_BG_2));
			
			_death_fadein = true;
			_ui._fadeout.alpha = 1;
			_ui._fadeout.visible = true;
			_ui.ui_update();
			_player.continue_animation(Player.ANIM_STANDFRONT);
			
			_bgobjs.members[1].y = _cur_scene.get_bg1();
			_bgobjs.members[2].y = _cur_scene.get_bg2();
		}
		
		private var _transition_ct:Number = 0;
		private function next_scene():void {
			if (_scene_list.length == 0) return;
			var next:Scene = _scene_list.shift();
			if (_cur_scene == null) {
				_cur_scene = next;
				_cur_scene.init();
				
			} else {
				_stains.clear();
				_enemies.clear();
				_bullets.clear();
				_particles.clear();
				_powerups.clear();
				_behind.clear();
				_enemies_front.clear();
				_enemy_speech.clear();
				
				_transition_from_scene = _cur_scene;
				_cur_scene = next;
				_cur_scene.init();
				_cur_scene.add_offset_to_groups( -500);
				_transition_ct = 500;
				_stains.visible = false;
			}
		}
		
		private function reset_current_scene():void {
			_stains.clear();
			_enemies.clear();
			_bullets.clear();
			_particles.clear();
			_powerups.clear();
			_behind.clear();
			_enemies_front.clear();
			_enemy_speech.clear();
			_sceneobjs.clear();
			
			var cur_scene_class:Class = Class(getDefinitionByName(getQualifiedClassName(_cur_scene))); //lel
			_cur_scene = new cur_scene_class(this);
			_cur_scene.init();
			_hp = Player.MAX_HP;
			_player.set_pos(Util.WID / 2, 390);
			_ui.ui_update();
			_ui.reset_hp_offset();
		}
		
		public function end_out():void {
			if (!_end_out) {
				_end_out = true;
				_ui._fadeout.alpha = 0;
				_ui._fadeout.visible = true;
			}
		}
		
		private var _esc_out:Boolean = false;
		public override function update():void {
			super.update();
			
			if (_esc_out) {
				_ui._fadeout.visible = true;
				_ui._fadeout.alpha += 0.01;
				if (_ui._fadeout.alpha >= 1) {
					FlxG.switchState(new MainMenu());
				}
				return;
				
			} else if (_end_out) {
				_ui._fadeout.alpha += 0.005;
				if (_ui._fadeout.alpha >= 1) {
					FlxG.switchState(new GameEndMenu());
				}
			} else if (_transition_from_scene != null) {
				_cur_scene.add_offset_to_groups(5);
				_transition_from_scene.add_offset_to_groups(5);
				_transition_ct -= 5;
				_player.y(5);
				
				_bgobjs.members[1].y = (_transition_ct / 500) * (_transition_from_scene.get_bg1() - _cur_scene.get_bg1()) + _cur_scene.get_bg1();
				_bgobjs.members[2].y = (_transition_ct / 500) * (_transition_from_scene.get_bg2() - _cur_scene.get_bg2()) + _cur_scene.get_bg2();
				
				if (_transition_ct <= 0) {
					_transition_from_scene.remove_groups_from_parent(_bgobjs);
					_transition_from_scene = null;
					_stains.visible = true;
					_player.y( -20);
				}
				return;
			} else if (_death_fadeout) {
				_player.continue_animation(Player.ANIM_HURT);
				_player._cable.visible = false;
				_player.y(5);
				_ui._fadeout.visible = true;
				if (_ui._fadeout.alpha < 1) {
					_ui._fadeout.alpha += 0.01;
				} else {
					_death_fadeout = false;
					_death_fadein = true;
					reset_current_scene();
					_player.continue_animation(Player.ANIM_STAND);
				}
				return;
				
			} else if (_death_fadein) {
				_player._cable.visible = true;
				if (_ui._fadeout.alpha > 0) {
					_ui._fadeout.alpha -= 0.01;
				} else {
					_ui._fadeout.alpha = 0;
					_death_fadein = false;
				}
				return;
			} else {
				_player._cable.visible = true;
				_ui._fadeout.visible = false;
			}
			_bgobjs.members[1].y = _cur_scene.get_bg1();
			_bgobjs.members[2].y = _cur_scene.get_bg2();
			
			if (FlxG.keys.justPressed("ESCAPE")) {
				if (_ui._show_ui_btn_count > 0) {
					_esc_out = true;
					_ui._fadeout.alpha = 0;
				} else {
					_ui._show_ui_btn_count = 100;
				}
			}
			
			_ui.ui_update();
			_player.update_player(this);
			
			update_control();
			_stains.update();
			_cur_scene.update();
			
			if (_is_moving) {
				FlxG.overlap(_stains, _player._wiper_hit_box, function(stain:BasicStain, body:FlxSprite):void {
					var prev_cleaned:Boolean = stain._cleaned;
					stain.clean_step();
					
					if (!prev_cleaned && stain._cleaned) {
						for (var i:uint = 0; i < 5; i++) {
							add_particle(new DustCleanedParticle(
								new FlxPoint(_player._wiper_hit_box.x,_player._wiper_hit_box.y), 
								new FlxPoint(Util.float_random(-3, 3), Util.float_random(0, 3)),
								new FlxPoint(500 + Util.int_random(-20, 20), 0))
							);
						}
						FlxG.play(Resource.IMPORT_SOUND_PICKUP_FULL);
						
					} else if (!stain._cleaned && Util.int_random(0,10) == 0) {
						add_particle(new FadeOutParticle(
							(new FlxPoint(_player._wiper_hit_box.x + Util.float_random( -20, 20), _player._wiper_hit_box.y + Util.float_random( -20, 20)))
							).set_vr(Util.float_random( -6, 6)).set_scale(Util.float_random(1,2)) as FadeOutParticle
						);
					}
				});
			}
			
			for (var i_particle:int = _particles.length-1; i_particle >= 0; i_particle--) {
				var itr_particle:Particle = _particles.members[i_particle];
				itr_particle.particle_update(this);
				if (itr_particle.should_remove()) {
					itr_particle.do_remove();
					_particles.remove(itr_particle,true);
				}
			}
			
			update_enemy_group(_enemies);
			update_enemy_group(_enemies_front);
			
			if (_bullets.length > 0) {
				for (var i_bullet:int = _bullets.length - 1; i_bullet >= 0; i_bullet-- ) {
					var itr_bullet:BasicBullet = _bullets.members[i_bullet];
					itr_bullet.bullet_update(this);
					
					if (itr_bullet.should_remove()) {
						itr_bullet.do_remove();
						_bullets.remove(itr_bullet, true);
					}
				}
				
				FlxG.overlap(_bullets, _player._body_hit_box, function(bullet:BasicBullet, body:FlxSprite):void {
					if (_end_out) return;
					if (_player._hurt_ct <= 0) {
						if (_hp <= 0 || _hp - 1 >= _ui._hp_ui.members.length) {
							trace("HP ERROR");
							return;
						}
						_particles.add(new BloodParticle(bullet.x, bullet.y));
						FlxG.play(Resource.IMPORT_SOUND_HIT);
						
						_ui._hp_ui.members[_hp-1].offset.y = 15;
						_hp--;
						_player._hurt_ct = 50;
						if (_hp <= 0) {
							FlxG.play(Resource.IMPORT_SOUND_GAME_OVER, 1.25);
							_death_fadeout = true;
							return;
						}
					}
					bullet.do_remove();
					_bullets.remove(bullet, true);
				});
				
			}
			
			if (Util.int_random(0,1500) == 0 && _hp != Player.MAX_HP) {
				_powerups.add(new HealthPack(Util.int_random(180, 780)));
			}
			if (_powerups.length > 0) {
				for (var i:uint = 0; i < _powerups.length; i++) {
					var p:HealthPack = _powerups.members[i];
					p.powerup_update(this);
					if (p.should_remove()) {
						p.do_remove();
						_powerups.remove(p, true);
						i--;
					}
				}
				FlxG.overlap(_powerups, _player._body_hit_box, function(p:HealthPack, body:FlxSprite):void {
					if (!p.taken()) {
						_hp = Math.min(_hp+1,Player.MAX_HP);
						p.taken();
						for (var i:int = 1; i <= 8; i++) {
							add_particle(new HpParticle(
								new FlxPoint(_player.x() + Util.float_random(-20, 20), _player.y() + Util.float_random(10, 50)),
							60));
						}
					}
				});
			}
		}
		
		private function update_control():void {
			_is_moving = false;
			_is_falling = false;
			if ( (_cur_scene.can_continue() || ALWAYS_CONTINUE) && _player.y() <= 0) {
				next_scene();
				_player._body.play(Scene.ANIM_STAND);
			}
			
			if (Util.is_key(Util.MOVE_LEFT) && _player.x() > _cur_scene.get_player_x_min()) {
				_player.x( -MOVE_SPEED);
				_is_moving = true;
				
			} else if (Util.is_key(Util.MOVE_RIGHT) && _player.x() < _cur_scene.get_player_x_max()) {
				_player.x(MOVE_SPEED);
				_is_moving = true;
				
			} 
			
			if (Util.is_key(Util.MOVE_JUMP) && _player.y() < _cur_scene.get_player_y_max()) {
				_player.y(JUMP_SPEED);
				_is_falling = true;
				
			} else if (Util.is_key(Util.MOVE_UP) && _player.y() > _cur_scene.get_player_y_min()) {
				_player.y( -MOVE_SPEED);
				_is_moving = true;
				
			} else if (Util.is_key(Util.MOVE_DOWN) && _player.y() < _cur_scene.get_player_y_max()) {
				_player.y(MOVE_SPEED);
				_is_moving = true;
				
			}
		}
		
		private function update_enemy_group(e:FlxGroup):void {
			for (var i_enemy:int = e.length - 1; i_enemy >= 0; i_enemy-- ) {
				var itr_enemy:BaseEnemy = e.members[i_enemy];
				itr_enemy.enemy_update(this);
				
				if (itr_enemy.should_remove()) {
					itr_enemy.do_remove();
					e.remove(itr_enemy, true);
				}
			}
		}
		
		public function add_particle(p:Particle):Particle { _particles.add(p); return p; }
		public function get_cleaned_pct():Number { 
			if (_stains.length == 0) return 0;
			var ct:Number = 0;
			for (var i:int = 0; i < _stains.length; i++) {
				var itr:BasicStain = _stains.members[i];
				if (itr._cleaned) ct++;
			}
			return ct/_stains.length;
		}
	}
}