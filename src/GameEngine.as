package {
	import core.*;
	import enemies.BaseEnemy;
	import enemies.SniperEnemy;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
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
	import scene.GroundFloorScene;
	import scene.Scene;
	import scene.TestScene;
	
	public class GameEngine extends FlxState {
		
		public var _bgobjs:FlxGroup = new FlxGroup();
		public var _sceneobjs:FlxGroup = new FlxGroup();
		
		public var _player:Player = new Player();
		public var _stains:FlxGroup = new FlxGroup();
		
		public var _particles:FlxGroup = new FlxGroup();
		public var _bullets:FlxGroup = new FlxGroup();
		public var _enemies:FlxGroup = new FlxGroup();
		
		public var _health_packs:FlxGroup = new FlxGroup();
		public var _aid_timer:Timer;
		
		public var _cur_scene:Scene;
		
		public var _hp:Number = 100;
		public var _ui:GameUI;
		
		public override function create():void {
			trace("game_init");
			super.create();
			
			//_cur_scene = (new GroundFloorScene(this)).init();
			_cur_scene = (new TestScene(this)).init();
			_ui = new GameUI(this);
			
			this.add(_bgobjs);
			this.add(_sceneobjs);
			this.add(_stains);
			this.add(_player);
			this.add(_enemies);
			this.add(_bullets);
			this.add(_particles);
			this.add(_health_packs);
			this.add(_ui);
			
			_aid_timer = new Timer(20);
			_aid_timer.start();
			
			_bgobjs.add(new BGObj(Resource.IMPORT_SKY));
			_bgobjs.add(new BGObj(Resource.IMPORT_CITY_BG));
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
		
		public function die():void {
			trace("Poor cleaner just died!");
		}
		
		public var _is_moving:Boolean = false;
		
		public override function update():void {
			super.update();
			
			_ui.ui_update();
			_player.update_player(this);
			_is_moving = false;
			
			if (Util.is_key(Util.MOVE_LEFT) && _player.x() > 180) {
				_player.x( -1);
				_is_moving = true;
				
			} else if (Util.is_key(Util.MOVE_RIGHT) && _player.x() < 800) {
				_player.x(1);
				_is_moving = true;
				
			} 
			
			if (Util.is_key(Util.MOVE_UP) && _player.y() > 0) {
				_player.y( -1);
				_is_moving = true;
				
			} else if (Util.is_key(Util.MOVE_DOWN) && _player.y() < 458) {
				_player.y(1);
				_is_moving = true;
				
			}
			
			_stains.update();
			_cur_scene.update();
			
			if (_is_moving) {
				FlxG.overlap(_stains, _player._body, function(stain:BasicStain, body:FlxSprite):void {
					var prev_cleaned:Boolean = stain._cleaned;
					stain.clean_step();
					
					if (!prev_cleaned && stain._cleaned) {
						for (var i:uint = 0; i < 5; i++) {
							add_particle(new DustCleanedParticle(
								new FlxPoint(_player.x(), _player.y()), 
								new FlxPoint(Util.float_random(-3, 3), Util.float_random(0, 3)),
								new FlxPoint(500 + Util.int_random(-20, 20), 0))
							);
						}
						
					} else if (!stain._cleaned && Util.int_random(0,10) == 0) {
						add_particle(new FadeOutParticle(
							(new FlxPoint(_player.x() + Util.float_random( -20, 20), _player.y() + Util.float_random( -20, 20)))
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
			
			// update enemies
			for (var i_enemy:int = _enemies.length - 1; i_enemy >= 0; i_enemy-- ) {
				var itr_enemy:BaseEnemy = _enemies.members[i_enemy];
				itr_enemy.enemy_update(this);
				
				if (itr_enemy.should_remove()) {
					itr_enemy.kill();
				}
			}
			
			// update bullets
			if (_bullets.length > 0) {
				for (var i_bullet:int = _bullets.length - 1; i_bullet >= 0; i_bullet-- ) {
					var itr_bullet:BasicBullet = _bullets.members[i_bullet];
					itr_bullet.bullet_update(this);
					
					if (itr_bullet.should_remove()) {
						itr_bullet.do_remove();
						_bullets.remove(itr_bullet, true);
					}
				}
				
				FlxG.overlap(_bullets, _player._body, function(bullet:BasicBullet, body:FlxSprite):void {
					_particles.add(new BloodParticle(bullet.x, bullet.y));
					
					_hp -= bullet._damage;
					_ui.hp_update();
					if (_hp <= 0) {
						die();
					}
					
					bullet.do_remove();
					_bullets.remove(bullet, true);
				});
				
				FlxG.overlap(_bullets, _enemies, function(bullet:BasicBullet, enemy:BaseEnemy):void {
					if (!enemy._hiding) {
						enemy._hp -= bullet._damage;
						_particles.add(new BloodParticle(bullet.x, bullet.y));
						bullet.do_remove();
						_bullets.remove(bullet, true);
					}
				});
			}
			
			// spawning health pack aid
			if (_aid_timer.currentCount >= 1500) {
				// note: according to test, the spawn interval is recommended to be greater than 800
				_aid_timer.reset();
				_health_packs.add(new HealthPack(Util.int_random(180, 780)));
				_aid_timer.start();
			}
			
			// updating health packs
			if (_health_packs.length > 0) {
				var hp_pack:HealthPack = _health_packs.members[0];
				hp_pack.health_pack_update(this);
				FlxG.overlap(hp_pack, _player._body, function(pack:HealthPack, body:FlxSprite):void {
					_hp += hp_pack._aid;
					_ui.hp_update();
					hp_pack.taken();
					for (var i:int = 1; i <= 8; i++) {
						add_particle(new HpParticle(
						new FlxPoint(_player.x() + Util.float_random(-20, 20), _player.y() + Util.float_random(10, 50)),
						60));
					}
				});
				
				if (hp_pack.should_remove()) {
					hp_pack.do_remove();
					_health_packs.remove(hp_pack, true);
				}
			}
		}
		
	}
	
}