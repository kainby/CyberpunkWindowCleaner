package scene {
	import core.BGObj;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	import enemies.*;
	public class Floor3Scene extends Scene {
		
		private static var SCRIPT:Array = [
			{PERCENT:0.02, CHARACTER:CHARACTER_JULIET, POSITION:[300, 360] },
			{PERCENT:0.02, CHARACTER:CHARACTER_JULIET, POSITION:[230, 360] },
			{PERCENT:0.02,CHARACTER:CHARACTER_ROMEO,POSITION:[700, 360]},
			{PERCENT:0.02, CHARACTER:CHARACTER_ROMEO, POSITION:[770, 360] },
			
			{PERCENT:0.06, CHARACTER:CHARACTER_ROMEO, POSITION:[650, 360] },
			{PERCENT:0.06, CHARACTER:CHARACTER_ROMEO, TEXT:"But, soft! what light through yonder window breaks?" },
			{PERCENT:0.12, CHARACTER:CHARACTER_ROMEO, POSITION:[550, 360] },
			{PERCENT:0.12, CHARACTER:CHARACTER_ROMEO, TEXT:"It is the east, and Juliet is the sun." },
			{PERCENT:0.16, CHARACTER:CHARACTER_ROMEO, POSITION:[380, 360] },
			{PERCENT:0.16, CHARACTER:CHARACTER_ROMEO, TEXT:"Arise, fair sun, and kill the envious moon." },
			
			{PERCENT:0.18, CHARACTER:CHARACTER_JULIET, TEXT:"Ay me!" },
			
			{PERCENT:0.2, CHARACTER:CHARACTER_ROMEO, TEXT:"O, speak again, bright angel! for thou art as glorious to this night as a winged messenger of heaven." },
			{PERCENT:0.24, CHARACTER:CHARACTER_JULIET, TEXT:"O Romeo, Romeo! wherefore art thou Romeo?" },
			{PERCENT:0.26, CHARACTER:CHARACTER_JULIET, TEXT:"Deny thy father and refuse thy name;" },
			{PERCENT:0.28, CHARACTER:CHARACTER_JULIET, TEXT:"Or, if thou wilt not, be but sworn my love." },
			{PERCENT:0.3, CHARACTER:CHARACTER_JULIET, TEXT:"And I'll no longer be a Capulet." },
			
			{PERCENT:0.36, CHARACTER:CHARACTER_ROMEO, TEXT:"I take thee at thy word:" },
			{PERCENT:0.38, CHARACTER:CHARACTER_ROMEO, POSITION:[270, 360] },
			{PERCENT:0.39, CHARACTER:CHARACTER_ROMEO, TEXT:"Call me but love, and I'll be new baptized;" },
			{PERCENT:0.42, CHARACTER:CHARACTER_ROMEO, TEXT:"Henceforth I never will be Romeo." },
			
			{PERCENT:0.52, CHARACTER:CHARACTER_JULIET, TEXT:"How camest thou hither, tell me, and wherefore?" },
			{PERCENT:0.52, CHARACTER:CHARACTER_JULIET, POSITION:[240, 360] },
			{PERCENT:0.54, CHARACTER:CHARACTER_JULIET, TEXT:"If they do see thee, they will murder thee." },
			
			{PERCENT:0.56, CHARACTER:CHARACTER_THUG_RED, POSITION:[700, 360] },
			{PERCENT:0.56, CHARACTER:CHARACTER_THUG_RED, POSITION:[550, 360] },
			{PERCENT:0.56, CHARACTER:CHARACTER_THUG_RED, TEXT:"This, by his voice, should be a Montague." },
			{PERCENT:0.6, CHARACTER:CHARACTER_THUG_RED, TEXT:"To strike him dead I hold it not a sin." },
			
			{PERCENT:0.64, CHARACTER:CHARACTER_THUG_RED, ID:1, POSITION:[700, 360] },
			{PERCENT:0.64, CHARACTER:CHARACTER_THUG_RED, ID:1, POSITION:[600, 360] },
			{PERCENT:0.64, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"Tis he, that villan Romeo." },
			
			{PERCENT:0.68, CHARACTER:CHARACTER_THUG_RED, ID:2, POSITION:[700, 360] },
			{PERCENT:0.68, CHARACTER:CHARACTER_THUG_RED, ID:2, POSITION:[650, 360]},
			{PERCENT:0.68, CHARACTER:CHARACTER_THUG_RED, ID:2, TEXT:"It fits, when such a villan is a guest." },
			{PERCENT:0.68, CHARACTER:CHARACTER_THUG_RED, ID:2, TEXT:"I'll not endure him." },
			
			{PERCENT:0.72, CHARACTER:CHARACTER_ROMEO, TEXT:"O, I am fortune's fool!" },
			{PERCENT:0.72, CHARACTER:CHARACTER_ROMEO, POSITION:[280, 360] },
			{PERCENT:0.74, CHARACTER:CHARACTER_JULIET, TEXT:"Romeo, away, be gone!" },
			{PERCENT:0.78, CHARACTER:CHARACTER_JULIET, TEXT:"If thou art taken: hence, be gone, away!" },
			
			{PERCENT:0.8, CHARACTER:CHARACTER_THUG_RED, POSITION:[230, 360] },
			{PERCENT:0.8, CHARACTER:CHARACTER_THUG_RED, ID:1, POSITION:[280, 360] },
			{PERCENT:0.8, CHARACTER:CHARACTER_THUG_RED, ID:2, POSITION:[330, 360] },
			{PERCENT:0.8, CHARACTER:CHARACTER_ROMEO, POSITION:[300, 360] },
			{PERCENT:0.8, CHARACTER:CHARACTER_ROMEO, REMOVE:1 }
		];
		
		public function Floor3Scene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR3_MAINBLDG_BACK));
			_internals_group.add(new BGObj(Resource.IMPORT_FLOOR3_MAINBLDG_INTERNAL));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR3_MAINBLDG_WINDOW));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR1_SIDEBLDG));
			
			for (var i:int = 0; i < 20; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(
					Util.float_random(200, 800), 
					Util.float_random(15, 180)
				));
			}
			for (var i:int = 0; i < 20; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(
					Util.float_random(200, 800), 
					Util.float_random(335, 450)
				));
			}
			for (var i:int = 0; i < 10; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(
					Util.float_random(350, 650), 
					Util.float_random(180, 230)
				));
			}
			

			create_sniper_enemy(72, 94, 1,_g);
			create_sniper_enemy(72, 234, 1,_g);
			create_sniper_enemy(72, 382, 1,_g);
			create_sniper_enemy(915, 382, 2,_g);
			create_sniper_enemy(915, 234, 2,_g);
			create_sniper_enemy(915, 92, 2, _g);
			
			//create_jetpack_enemy(863, 2, _g);
			//create_jetpack_enemy(137, 1, _g);
			
			return this;
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
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number, g:GameEngine):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no,g);
			enemy.set_position(x-10, y-25);
			_g._enemies.add(enemy);
		}
		
		public function create_jetpack_enemy(x:Number, team_no:Number, g:GameEngine):void {
			var enemy:JetPackEnemy = new JetPackEnemy(team_no, x, g);
			_g._enemies.add(enemy);
		}
		
		public override function show_hp_bar():Boolean {
			return true;
		}
		
		public override function can_continue():Boolean {
			return _g.get_cleaned_pct() >= 0.8;
		}
		
	}

}