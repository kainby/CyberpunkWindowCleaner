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
			
			{PERCENT:0,CHARACTER:CHARACTER_ROMEO,POSITION:[267, 317]},
			{PERCENT:0, CHARACTER:CHARACTER_JULIET, POSITION:[350, 317] },
			
			{PERCENT:0, CHARACTER:CHARACTER_JULIET, TEXT:"Hey kiddo wanna have a good time"},
			{PERCENT:0, CHARACTER:CHARACTER_JULIET, TEXT:"Of course you do now get over here"},
			
			{PERCENT:0.02,CHARACTER:CHARACTER_ROMEO,POSITION:[335, 317]},
			{PERCENT:0.02, CHARACTER:CHARACTER_JULIET, POSITION:[450, 317] },
			
			{PERCENT:0.06,CHARACTER:CHARACTER_ROMEO,POSITION:[460, 317]},
			{PERCENT:0.06, CHARACTER:CHARACTER_JULIET, POSITION:[600, 317], SPEED: 2 },
			
			{PERCENT:0.06, CHARACTER:CHARACTER_ROMEO, TEXT:"OH GOD WHAT IS THIS"},
			
			{PERCENT:0.15,CHARACTER:CHARACTER_ROMEO,POSITION:[200, 317]},
			{PERCENT:0.15, CHARACTER:CHARACTER_JULIET, POSITION:[300, 317], SPEED: 2 },
			
			{PERCENT:0.15, CHARACTER:CHARACTER_JULIET, TEXT:"CUM A LIL CLOSER BABYCAKES"},
			{PERCENT:0.15, CHARACTER:CHARACTER_ROMEO, TEXT:"nope.avi"},
			
			{PERCENT:0.25,CHARACTER:CHARACTER_ROMEO,POSITION:[600, 317]},
			{PERCENT:0.25, CHARACTER:CHARACTER_JULIET, POSITION:[620, 317], SPEED: 2 },
			
			{PERCENT:0.25, CHARACTER:CHARACTER_JULIET, TEXT:"2 fast 2 furious" },
			{PERCENT:0.25, CHARACTER:CHARACTER_ROMEO, TEXT:"FUGGEN LEL COMEDY GOLD"},
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
			
			for (var i:int = 0; i < 50; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(Util.float_random(180, 800), Util.float_random(50, 450)));
			}
			

			create_sniper_enemy(0, 100, 1,_g);
			create_sniper_enemy(0, 200, 1,_g);
			create_sniper_enemy(0, 300, 1,_g);
			create_sniper_enemy(934, 150, 2,_g);
			create_sniper_enemy(934, 250, 2,_g);
			create_sniper_enemy(934, 350, 2,_g);
			
			return this;
		}
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number, g:GameEngine):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no,g);
			enemy.set_position(x, y);
			_g._enemies.add(enemy);
		}
		
		public override function show_hp_bar():Boolean {
			return true;
		}
		
		public override function can_continue():Boolean {
			return true;
		}
		
	}

}