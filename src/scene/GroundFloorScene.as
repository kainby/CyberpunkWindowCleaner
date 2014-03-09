package scene {
	import core.BGObj;
	public class GroundFloorScene extends Scene {
		
		private static var SCRIPT:Array = [];
		
		public function GroundFloorScene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR0_BG));
			
			return this;
		}
		
		public override function show_hp_bar():Boolean {
			return false;
		}
		
		public override function can_continue():Boolean {
			return true;
		}
		
	}

}