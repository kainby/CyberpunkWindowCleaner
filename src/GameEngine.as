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
		
		public var _particles:FlxGroup = new FlxGroup();
		public var _bullets:FlxGroup = new FlxGroup();
		public var _enemies:FlxGroup = new FlxGroup();
		
		public var _bar_frame:FlxSprite = new FlxSprite();
		public var _score:FlxText;
		
		public var _cur_scene:Scene;
		
		public override function create():void {
			trace("game_init");
			super.create();
			
			
			_score = new FlxText(0, 0, 100, "0%", true);
			_score.setFormat("gamefont", 35);
			
			this.add(_bgobjs);
			this.add(_sceneobjs);
			this.add(_stains);
			this.add(_player);
			this.add(_enemies);
			this.add(_bullets);
			this.add(_cleaning_bar);
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
			
			this.add(new FlxScrollingText());
			
			test = new ScrollingTextBubble();
			this.add(test);
		}
		var test:ScrollingTextBubble;
		
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
		
		private var _is_moving:Boolean = false;
		
		public override function update():void {
			super.update();
			
			test.set_pos(_player.x(), _player.y());
			
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
					stain.clean_step();
					
					if (!stain._cleaned && Util.int_random(0,10) == 0) {
						add_particle(new DustCleanedParticle(
							new FlxPoint(_player.x(), _player.y()), 
							new FlxPoint(Util.float_random(-3, 3), Util.float_random(0, 3)),
							new FlxPoint(500 + Util.int_random(-20, 20), 0))
						);
					}
				});
				
				// update the percentage of cleaning
				var pct:Number = get_cleaned_pct();
				_score.text = int(pct * 100) + "%";
				_cleaning_bar.scale.x = pct;
				_cleaning_bar.set_position(_bar_frame.x + 126 - (1 - pct) * 70, 3);
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
					var dx:Number = (itr_enemy._team_no == 1) ? 60 : 0;
					var bullet:RoundBullet = new RoundBullet(itr_enemy.x + dx, itr_enemy.y, itr_enemy._angle);
					_bullets.add(bullet);
				}
				
				if (itr_enemy.should_remove()) {
					itr_enemy.do_remove();
					_enemies.remove(itr_enemy, true);
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
			}
		}
		
	}
	
}