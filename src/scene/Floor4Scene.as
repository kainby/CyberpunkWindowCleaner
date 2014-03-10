package scene {
	import core.BGObj;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	import enemies.*;
	public class Floor4Scene extends Scene {
		
		public override function get_bg1():Number { return 100; }
		public override function get_bg2():Number { return 260; }
		public override function get_player_y_min():Number { return 105; }
		
		private static var SCRIPT:Array = [
			
			{PERCENT:0.0, CHARACTER:CHARACTER_ROMEO, POSITION:[760, 460] },
			{PERCENT:0.0, CHARACTER:CHARACTER_THUG_RED, POSITION:[300, 460] },
			
			{PERCENT:0.02, CHARACTER:CHARACTER_ROMEO, POSITION:[380, 460] },
			{PERCENT:0.04, CHARACTER:CHARACTER_THUG_RED, TEXT:"I do defy thy conjurations, And apprehend thee for a felon here." },
			{PERCENT:0.04, CHARACTER:CHARACTER_THUG_RED, POSITION:[320, 460] },
			{PERCENT:0.08, CHARACTER:CHARACTER_ROMEO, TEXT:"Wilt thou provoke me? then have at thee, boy!" },
			
			{PERCENT:0.1, CHARACTER:CHARACTER_ROMEO, POSITION:[360, 460] },
			{PERCENT:0.1, CHARACTER:CHARACTER_THUG_RED, POSITION:[340, 460] },
			
			{PERCENT:0.16, CHARACTER:CHARACTER_THUG_RED, TEXT:"O, I am slain!" },
			{PERCENT:0.16, CHARACTER:CHARACTER_THUG_RED, POSITION:[240, 460] },
			{PERCENT:0.18, CHARACTER:CHARACTER_ROMEO, POSITION:[240, 460] },
			{PERCENT:0.18, CHARACTER:CHARACTER_ROMEO, REMOVE:1 },
			
			{PERCENT:0.22, CHARACTER:CHARACTER_ROMEO, POSITION:[280, 95] },
			{PERCENT:0.22, CHARACTER:CHARACTER_ROMEO, POSITION:[460, 95] },
			{PERCENT:0.24, CHARACTER:CHARACTER_ROMEO, POSITION:[780, 95] },
			
			{PERCENT:0.24, CHARACTER:CHARACTER_THUG_RED, ID:1, POSITION:[250, 95] },
			{PERCENT:0.26, CHARACTER:CHARACTER_THUG_RED, ID:1, POSITION:[540, 95] },
			
			{PERCENT:0.24, CHARACTER:CHARACTER_THUG_RED, ID:2, POSITION:[300, 95] },
			{PERCENT:0.26, CHARACTER:CHARACTER_THUG_RED, ID:2, POSITION:[590, 95] },
			
			{PERCENT:0.24, CHARACTER:CHARACTER_THUG_RED, ID:3, POSITION:[350, 95] },
			{PERCENT:0.26, CHARACTER:CHARACTER_THUG_RED, ID:3, POSITION:[640, 95] },
			
			{PERCENT:0.36, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"What a pestilent knave is this same!" },
			{PERCENT:0.4, CHARACTER:CHARACTER_THUG_RED, ID:2, TEXT:"Jack! Come, we'll in here; tarry for the mourners." },
			{PERCENT:0.44, CHARACTER:CHARACTER_THUG_RED, ID:3, TEXT:"Thou, wretched boy, that didst consort him here, Shalt with him hence." },
			{PERCENT:0.44, CHARACTER:CHARACTER_ROMEO, TEXT:"Art thou so bare and full of wretchedness, And fear'st to die?" },
			
			{PERCENT:0.46, CHARACTER:CHARACTER_ROMEO, TEXT:"Thou detestable maw, thou womb of death," },
			{PERCENT:0.466, CHARACTER:CHARACTER_ROMEO, TEXT:"Thus I enforce thy rotten jaws to open," },
			{PERCENT:0.47, CHARACTER:CHARACTER_ROMEO, TEXT:"and cram thee with more food!" },
			{PERCENT:0.6, CHARACTER:CHARACTER_ROMEO, POSITION:[790, 700], SPEED:2 },
			//fall here
			
			{PERCENT:0.58, CHARACTER:CHARACTER_JULIET, POSITION:[280, 95] },
			{PERCENT:0.58, CHARACTER:CHARACTER_JULIET, POSITION:[370, 95] },
			{PERCENT:0.62, CHARACTER:CHARACTER_JULIET, POSITION:[780, 95] },
			{PERCENT:0.62, CHARACTER:CHARACTER_JULIET, TEXT:"Beguiled, divorced, wronged, spited, slain! Most detestable death, by thee beguil'd." },
			{PERCENT:0.66, CHARACTER:CHARACTER_JULIET, TEXT:"Yea, noise? then I'll be brief. O happy dagger!" },
			{PERCENT:0.72, CHARACTER:CHARACTER_JULIET, TEXT:"This is thy sheath; there rust, and let me die." },
			{PERCENT:0.8, CHARACTER:CHARACTER_JULIET, POSITION:[790, 700], SPEED:2 },
			
		];
		
		public function Floor4Scene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR4_MAINBLDG_BACK));
			_internals_group.add(new BGObj(Resource.IMPORT_FLOOR4_MAINBLDG_INTERNAL));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR4_MAINBLDG_WINDOW));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR4_SIDEBLDG));
			
			for (var i:int = 0; i < 50; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(Util.float_random(200, 750), Util.float_random(150, 450)));
			}

			create_heli_enemy(1, 72, 30, _g);
			create_heli_enemy(2, 840, 160, _g);
			return this;
		}
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number, g:GameEngine):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no,g);
			enemy.set_position(x, y);
			_g._enemies.add(enemy);
		}
		
		public function create_jetpack_enemy(x:Number, team_no:Number, g:GameEngine):void {
			var enemy:JetPackEnemy = new JetPackEnemy(team_no, x, g);
			_g._enemies.add(enemy);
		}
		
		private var _last_cleaned_pct:Number = -1;
		public override function update():void {
			super.update();
			
			if (passed_mark(0.0)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.02)) this.create_jetpack_enemy(Util.float_random(840, 870), 2, _g);
			if (passed_mark(0.1)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.15)) this.create_jetpack_enemy(Util.float_random(840, 870), 2, _g);
			if (passed_mark(0.25)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.35)) this.create_jetpack_enemy(Util.float_random(840, 870), 2, _g);
			if (passed_mark(0.4)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.5)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.55)) this.create_jetpack_enemy(Util.float_random(840, 870), 2, _g);
			if (passed_mark(0.7)) this.create_jetpack_enemy(Util.float_random(110, 150), 1, _g);
			if (passed_mark(0.75)) this.create_jetpack_enemy(Util.float_random(840, 870), 2, _g);
			
			_last_cleaned_pct = _g.get_cleaned_pct();
		}
		private function passed_mark(pct:Number):Boolean {
			return _last_cleaned_pct < pct && _g.get_cleaned_pct() >= pct;
		}
		
		public function create_heli_enemy(team_no:Number, x:Number, y:Number, g:GameEngine) {
			var enemy:HelicopterEnemy = new HelicopterEnemy(team_no, x, y);
			_g._enemies.add(enemy);
		}
		
		public override function show_hp_bar():Boolean {
			return true;
		}
		
		public override function can_continue():Boolean {
			return false;
		}
		
	}

}