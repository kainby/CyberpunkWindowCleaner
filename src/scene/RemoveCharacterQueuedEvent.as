package scene {

	public class RemoveCharacterQueuedEvent extends QueuedEvent {
		
		public var _removed:Boolean = false;
		public function RemoveCharacterQueuedEvent(name:String, character:SceneCharacter, pct:Number) {
			super(name, character, pct);
		}
		
		public override function done():Boolean {
			return _removed;
		}
		
		public override function get_category_name():String {
			return "MOVE";
		}
		
	}

}