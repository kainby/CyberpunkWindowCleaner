package {
	import core.BGObj;
	import flash.geom.Rectangle;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flixel.*;
	
	public class GameEngine extends FlxState {
		
		protected var _bgobjs:FlxGroup = new FlxGroup();
		protected var _mainbldg_objs:FlxGroup = new FlxGroup();
		
		public override function create():void {
			super.create();
			
			this.add(Util.flx_group_add(_bgobjs,new BGObj(Resource.IMPORT_SKY)));
			this.add(Util.flx_group_add(_bgobjs, new BGObj(Resource.IMPORT_CITY_BG)));
			this.add(Util.flx_group_add(_bgobjs,new BGObj(Resource.IMPORT_CITY_FG)));
		}
		
		public override function update():void {
			super.update();
		}

		
	}
	
}