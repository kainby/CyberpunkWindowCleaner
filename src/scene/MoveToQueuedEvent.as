package scene {
	import flash.geom.Vector3D;
	import org.flixel.FlxSprite;
	import org.flixel.FlxObject;

	public class MoveToQueuedEvent extends QueuedEvent {
		
		public var _target:Array = [0, 0];
		public var _speed:Number = 1;
		public var _dp:Vector3D = new Vector3D(0, 0, 0);
		public var _dv:Vector3D = new Vector3D(0, 0, 0);
		
		public function MoveToQueuedEvent(name:String, character:SceneCharacter, pct:Number, position:Array, speed:Number = 1) {
			super(name, character, pct);
			_target[0] = position[0];
			_target[1] = position[1];
			_speed = speed;
			
			update_dp();
		}
		
		private function update_dp():void {
			_dp.x = _target[0] - _character.x;
			_dp.y = _target[1] - _character.y;
			_dp.z = 0;
		}
		
		public override function update():void {
			update_dp();
			if (_dp.length <= _speed) {
				_character.x = _target[0];
				_character.y = _target[1];
				
			} else {
				_dp.normalize();
				_dp.scaleBy(_speed);
				_character.x += _dp.x;
				_character.y += _dp.y;
			}
			_character._is_moving = true;
			if (_dp.x < 0) {
				_character.facing = FlxObject.RIGHT;
			} else {
				_character.facing = FlxObject.LEFT;
			}
		}
		
		public override function done():Boolean {
			update_dp();
			return _dp.length == 0;
		}
		
	}

}