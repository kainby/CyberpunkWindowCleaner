package scene {
	import flash.geom.Vector3D;
	import misc.FlxGroupSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxObject;
	
	public class MillAroundQueuedEvent extends QueuedEvent {
		
		private var _startpt:FlxPoint = new FlxPoint();
		private var _endpt:FlxPoint = new FlxPoint();
		
		private static var MODE_STARTPT:uint = 0;
		private static var MODE_ENDPT:uint = 1;
		private static var MODE_STARTPT_TO_ENDPT:uint = 2;
		private static var MODE_ENDPT_TO_STARTPT:uint = 3;
		
		private var _mode:Number = MODE_STARTPT;
		
		public function MillAroundQueuedEvent(name:String, character:SceneCharacter, pct:Number, to_pos:Array) {
			super(name, character, pct);
			_startpt.x = character.x;
			_startpt.y = character.y;
			_endpt.x = to_pos[0];
			_endpt.y = to_pos[1];
		}
		
		public override function update():void {
			var do_something:int = Util.int_random(0, 50);
			if (_mode == MODE_STARTPT) {
				_character._is_moving = false;
				if (do_something == 0) {
					_character.facing = FlxObject.LEFT;
				
				} else if (do_something == 1) {
					_character.facing = FlxObject.RIGHT;
				
				} else if (do_something == 2) {
					_mode = MODE_STARTPT_TO_ENDPT;
					
				}
				
			} else if (_mode == MODE_ENDPT) {
				_character._is_moving = false;
				if (do_something == 0) {
					_character.facing = FlxObject.LEFT;
				} else if (do_something == 1) {
					_character.facing = FlxObject.RIGHT;
				
				} else if (do_something == 2) {
					_mode = MODE_ENDPT_TO_STARTPT;
				}
				
			} else if (_mode == MODE_STARTPT_TO_ENDPT || _mode == MODE_ENDPT_TO_STARTPT) {
				_character._is_moving = true;
				var dp:Vector3D;
				if (_mode == MODE_ENDPT_TO_STARTPT) {
					dp = new Vector3D(_startpt.x - _character.x, _startpt.y - _character.y);
				} else {
					dp = new Vector3D(_endpt.x - _character.x, _endpt.y - _character.y);
				}
				if (dp.length <= 0.25) {
					if (_mode == MODE_ENDPT_TO_STARTPT) {
						_character.x = _startpt.x;
						_character.y = _startpt.y;
						_mode = MODE_STARTPT;
					} else {
						_character.x = _endpt.x;
						_character.y = _endpt.y;
						_mode = MODE_ENDPT;
					}
				} else {
					dp.normalize();
					dp.scaleBy(0.25);
					_character.x += dp.x;
					_character.y += dp.y;
					if (dp.x < 0) {
						_character.facing = FlxObject.RIGHT;
					} else {
						_character.facing = FlxObject.LEFT;
					}
				}
			}
		}
		
		public override function done():Boolean {
			return false;
		}
		
	}

}