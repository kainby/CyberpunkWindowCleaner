package {
	import core.*;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	
	public class GameEngine extends FlxState {
		
		public var _bgobjs:FlxGroup = new FlxGroup();
		public var _mainbldg_objs:FlxGroup = new FlxGroup();
		public var _player:Player = new Player();
		public var _stains:FlxGroup = new FlxGroup();
		
		// public var _particles:FlxGroup = new FlxGroup();
		public var _particles:Vector.<Particle> = new Vector.<Particle>();
		public var _bar_frame:FlxSprite;
		
		public override function create():void {
			super.create();
			
			this.add(_bgobjs.add(new BGObj(Resource.IMPORT_SKY)));
			this.add(_bgobjs.add(new BGObj(Resource.IMPORT_CITY_BG)));
			this.add(_bgobjs.add(new BGObj(Resource.IMPORT_CITY_FG)));
		
			this.add(_mainbldg_objs.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_BACK)));
			this.add(_mainbldg_objs.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_INTERNAL)));
			this.add(_mainbldg_objs.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_GLASSCOVER)));
			this.add(_mainbldg_objs.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_WINDOW)));
			
			
			for (var i:int = 0; i < 50; i++) {
				_stains.add((new BasicStain(this)).set_position(Util.float_random(0,600),Util.float_random(0,500)));
			}
			this.add(_stains);
			
			this.add(_player);
			
			// cleanness bar
			_bar_frame = new FlxSprite(375, 0);
			_bar_frame.loadGraphic(Resource.IMPORT_BAR_FRAME);
			this.add(_bar_frame);
			
			trace("begin");
		}
		
		public function add_particle(p:Particle):Particle {
			this._particles.push(p);
			this.add(p);
			return p;
		}
		
		private var _is_moving:Boolean = false;
		
		public override function update():void {
			super.update();
			

			_is_moving = false;
			
			if (Util.is_key(Util.MOVE_LEFT) && _player.x() > 0) {
				_player.x( -1);
				_is_moving = true;
				
			} else if (Util.is_key(Util.MOVE_RIGHT) && _player.x() < 631) {
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
			
			if (_is_moving) {
				FlxG.overlap(_stains, _player._body, function(stain:BasicStain, body:FlxSprite):void {
					stain.clean_step();
					
					if (!stain.cleaned) {
						add_particle(new DustCleanedParticle(
							new FlxPoint(_player.x(), _player.y()), 
							new FlxPoint(Util.float_random(-3, 3), Util.float_random(0, 3)),
							new FlxPoint(500, 0))
						);
					}
				});
			}
			
			dust_particle_effect();
			
		}
		
		public function dust_particle_effect():void {
			/*
			for (var i_particle:int = _particles.length-1; i_particle >= 0; i_particle--) {
				var itr_particle:Particle = _particles.members[i_particle];
				itr_particle.particle_update(this);
				if (itr_particle.should_remove()) {
					itr_particle.do_remove();
					itr_particle.kill();
				}
			}
			*/
			
			for (var i_particle:int = _particles.length-1; i_particle >= 0; i_particle--) {
				var itr_particle:Particle = _particles[i_particle];
				itr_particle.particle_update(this);
				if (itr_particle.should_remove()) {
					itr_particle.do_remove();
					_particles.splice(i_particle, 1);
					this.remove(itr_particle);
				}
			}
				
		}
		
	}
	
}