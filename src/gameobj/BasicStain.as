package gameobj {
	import core.BGObj;
	import org.flixel.FlxG;
	
	public class BasicStain extends BGObj {
		
		private static var STAINS:Vector.<Class> = Vector.<Class>([Resource.IMPORT_STAIN_1, Resource.IMPORT_STAIN_2, Resource.IMPORT_STAIN_3]);
		private var _g:GameEngine;
		public var _cleaned:Boolean;
		public var _pct:Number = 1;
		
		public function BasicStain(g:GameEngine) {
			super(STAINS[Util.int_random(0, STAINS.length)]);
			_g = g;
			_cleaned = false;
			this.color = 0xCCCCCC;
		}
		
		public function clean_step():void {
			_pct -= 1/(width*3);
			this.alpha = 0.3 +  _pct * 0.7;
			
			if (this._pct <= 0) {
				this.visible = false;
				this.alpha = 0;
				this._cleaned = true;
			}
		}
		
	}

}