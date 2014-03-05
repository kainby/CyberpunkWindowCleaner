package {
	import core.*;
	import flash.geom.Rectangle;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import misc.ScrollingTextBubble;
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
		
		public var _particles:FlxGroup = new FlxGroup();
		
		public var _bar_frame:FlxSprite;
		
		public var _cur_scene:Scene;
		
		public override function create():void {
			trace("game_init");
			super.create();
			
			this.add(_bgobjs);
			this.add(_sceneobjs);
			this.add(_stains);
			this.add(_player);
			this.add(_particles);
			
			_bgobjs.add(new BGObj(Resource.IMPORT_SKY));
			_bgobjs.add(new BGObj(Resource.IMPORT_CITY_BG));
			
			_cur_scene = (new TestScene(this)).init();
			
			for (var i:int = 0; i < 50; i++) {
				_stains.add((new BasicStain(this)).set_position(Util.float_random(180, 800), Util.float_random(50, 450)));
			}
			
			_bar_frame = new FlxSprite(375, 0);
			_bar_frame.loadGraphic(Resource.IMPORT_BAR_FRAME);
			this.add(_bar_frame);
			
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
							new FlxPoint(500, 0))
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
			
		}
		
	}
	
}