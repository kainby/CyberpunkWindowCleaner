package {
	import core.*;
	import enemies.BaseEnemy;
	import enemies.SniperEnemy;
	import flash.geom.Rectangle;
	import gameobj.BasicBullet;
	import gameobj.BasicStain;
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import misc.ScrollingTextBubble;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	import particle.*;
	import scene.Scene;
	import scene.TestScene;
	
	public class GameEngine extends FlxState {
		
		public var _bgobjs:FlxGroup = new FlxGroup();
		public var _sceneobjs:FlxGroup = new FlxGroup();
		
		public var _player:Player = new Player();
		public var _stains:FlxGroup = new FlxGroup();
		public var _cleaning_bar:FlxSprite = new FlxSprite();
		public var _hp_bar:FlxSprite = new FlxSprite();
		
		public var _particles:FlxGroup = new FlxGroup();
		public var _bullets:FlxGroup = new FlxGroup();
		public var _bloods:FlxGroup = new FlxGroup();
		public var _enemies:FlxGroup = new FlxGroup();
		
		public var _bar_frame:FlxSprite = new FlxSprite();
		public var _hp:Number;
		public var _score:FlxText;
		
		public var _cur_scene:Scene;
		
		public override function create():void {
			trace("game_init");
			super.create();
			
			_hp = 100;
			_score = new FlxText(0, 0, 100, "0%", true);
			_score.setFormat("gamefont", 35);
			
			this.add(_bgobjs);
			this.add(_sceneobjs);
			this.add(_stains);
			this.add(_player);
			this.add(_enemies);
			this.add(_bullets);
			this.add(_bloods);
			this.add(_cleaning_bar);
			this.add(_hp_bar);
			this.add(_bar_frame);
			this.add(_score);
			this.add(_particles);
			
			_bgobjs.add(new BGObj(Resource.IMPORT_SKY));
			_bgobjs.add(new BGObj(Resource.IMPORT_CITY_BG));
			
			_cur_scene = (new TestScene(this)).init();
			
			for (var i:int = 0; i < 50; i++) {
				_stains.add((new BasicStain(this)).set_position(Util.float_random(180, 800), Util.float_random(50, 450)));
			}
			
			// initialize hp bar
			_bar_frame.loadGraphic(Resource.IMPORT_BAR_FRAME);
			_bar_frame.set_position((1000 - _bar_frame.width) / 2, 0);
			_cleaning_bar.scale.x = 0.001;
			_cleaning_bar.set_position(_bar_frame.x + 126, 3);
			_cleaning_bar.loadGraphic(Resource.IMPORT_HPBAR);
			_cleaning_bar.color = 0x4DBFE6;
			_hp_bar.set_position(_bar_frame.x + 114, 28);
			_hp_bar.loadGraphic(Resource.IMPORT_HPBAR);
			_hp_bar.color = 0xDFDF20;
			
			// initialize score
			// _score.setFormat("Liquid Cyrstal", 18, 0x959FBF);
			_score.set_position(_bar_frame.x + 280, 2);
			_score.text = "0%";
			
			// initilize enemies
			create_sniper_enemy(0, 100, 1);
			create_sniper_enemy(0, 200, 1);
			create_sniper_enemy(0, 300, 1);
			create_sniper_enemy(934, 150, 2);
			create_sniper_enemy(934, 250, 2);
			create_sniper_enemy(934, 350, 2);
			
			//this.add(new FlxScrollingText());
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
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no);
			enemy.set_position(x, y);
			_enemies.add(enemy);
		}
		
		public function object_hit(x:Number, y:Number) {
			var blood:FlxSprite = new FlxSprite(x, y);
			blood.loadGraphic(Resource.IMPORT_BLOOD, true, false, 18, 18);
			blood.addAnimation("blood_splash", [1, 2, 3], 12, false);
			blood.play("blood_splash");
			_bloods.add(blood);
		}
		
		// update the hp bar
		public function hp_update():void {
			if (_hp > 100) {
				_hp = 100;
			}
			if (_hp < 0) {
				_hp = 0;
			}
			
			var pct:Number = _hp / 100;
			_hp_bar.scale.x = pct;
			_hp_bar.set_position(_bar_frame.x + 114 - (1 - pct) * 70, 28);
		}
		
		// update the percentage of cleaning
		public function cleaning_update():void {
			var pct:Number = get_cleaned_pct();
			_score.text = int(pct * 100) + "%";
			_cleaning_bar.scale.x = pct;
			_cleaning_bar.set_position(_bar_frame.x + 126 - (1 - pct) * 70, 3);
		}
		
		public function die():void {
			trace("Poor cleaner just died!");
		}
		
		public var _is_moving:Boolean = false;
		
		public override function update():void {
			super.update();
			
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
				
				cleaning_update();
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
				
				if (itr_enemy._shoot) {
					var dx:Number = (itr_enemy._team_no == 1) ? 60 : -6;
					var bullet:RoundBullet = new RoundBullet(itr_enemy.x + dx, itr_enemy.y + 12, itr_enemy._angle);
					_bullets.add(bullet);
				}
				
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
					object_hit(bullet.x, bullet.y);
					
					_hp -= bullet._damage;
					hp_update();
					if (_hp <= 0) {
						die();
					}
					
					bullet.do_remove();
					_bullets.remove(bullet, true);
				});
				
				FlxG.overlap(_bullets, _enemies, function(bullet:BasicBullet, enemy:BaseEnemy):void {
					if (!enemy._hiding) {
						enemy._hp -= bullet._damage;
						object_hit(bullet.x, bullet.y);
						bullet.do_remove();
						_bullets.remove(bullet, true);
					}
				});
			}
			
			// remove any blood animation that is finished
			if (_bloods.length > 0) {
				for (var i_blood:int = _bloods.length - 1; i_blood >= 0; i_blood-- ) {
					var itr_blood:FlxSprite = _bloods.members[i_blood];
					if (itr_blood.finished) {
						_bloods.remove(itr_blood, true);
					}
				}
			}
		} // end of update function
		
	}
	
}