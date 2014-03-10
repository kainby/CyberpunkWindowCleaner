package scene {
	import core.BGObj;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	import enemies.*;
	public class Floor2Scene extends Scene {
		
		private static var SCRIPT:Array = [
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[560, 375], ID:2  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[610, 375], ID:3  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[640, 375], ID:4  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[600, 375], ID:2  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[630, 375], ID:3  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[660, 375], ID:4  },
			
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[310, 180], ID:5  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[360, 180], ID:6  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[440, 180], ID:7  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[325, 180], ID:5  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[350, 180], ID:6  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[430, 180], ID:7  },
			
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[460, 375], ID:1  },
			{PERCENT:0, CHARACTER:CHARACTER_JULIET, POSITION:[310, 375] },
			
			{PERCENT:0, CHARACTER:CHARACTER_ROMEO, POSITION:[610, 180] },
			{PERCENT:0, CHARACTER:CHARACTER_ROMEO, MILLTO:[620, 180]},
			
			{PERCENT:0.02, CHARACTER:CHARACTER_THUG_RED, POSITION:[380, 375], ID:1  },
			{PERCENT:0.02, CHARACTER:CHARACTER_JULIET, TEXT:"What's he that follows there, that would not dance? Go ask his name: if he be married."},
			{PERCENT:0.1, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"His name is Romeo, and a Montague;" },
			{PERCENT:0.14, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"The only son of your great enemy." },
			{PERCENT:0.22, CHARACTER:CHARACTER_JULIET, TEXT:"My only love sprung from my only hate!" },
			{PERCENT:0.26, CHARACTER:CHARACTER_JULIET, TEXT:"Prodigious birth of love it is to me," },
			{PERCENT:0.3, CHARACTER:CHARACTER_JULIET, TEXT:"That I must love a loathed enemy." },
			{PERCENT:0.34, CHARACTER:CHARACTER_THUG_RED, ID:2, TEXT:"What's this, what's this?" },
			
			{PERCENT:0.4, CHARACTER:CHARACTER_ROMEO, TEXT:"Can I go forward when my heart is here?" },
			{PERCENT:0.44, CHARACTER:CHARACTER_ROMEO, TEXT:"Turn back, dull earth, and find thy centre out." },
			{PERCENT:0.48, CHARACTER:CHARACTER_THUG_BLUE, ID:7, TEXT:"He is wise; And, on my lie, hath stol'n him home to bed." },
			{PERCENT:0.52, CHARACTER:CHARACTER_THUG_BLUE, ID:5, TEXT:"And the demesnes that there adjacent lie," },
			{PERCENT:0.56, CHARACTER:CHARACTER_THUG_BLUE, ID:5, TEXT:"That in thy likeness thou appear to us!" },
			
			{PERCENT:0.6, CHARACTER:CHARACTER_THUG_BLUE, ID:6, TEXT:"Blind is his love and best befits the dark." },
			{PERCENT:0.64, CHARACTER:CHARACTER_THUG_BLUE, ID:6, TEXT:"To be consorted with the humorous night:" },
			
			{PERCENT:0.68, CHARACTER:CHARACTER_THUG_BLUE, ID:7, TEXT:"And if he hear thee, thou wilt anger him." },
			{PERCENT:0.72, CHARACTER:CHARACTER_THUG_BLUE, ID:5, TEXT:"Is fair and honest, and in his mistress's name." },
			{PERCENT:0.76, CHARACTER:CHARACTER_THUG_BLUE, ID:5, TEXT:"I conjure only but to raise up him." },
			
			{PERCENT:0.8, CHARACTER:CHARACTER_ROMEO, TEXT:"He jests at scars that never felt a wound." }
		];
		
		public function Floor2Scene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR2_MAINBLDG_BACK));
			_internals_group.add(new BGObj(Resource.IMPORT_FLOOR2_MAINBLDG_INTERNAL));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR2_MAINBLDG_WINDOW));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR1_SIDEBLDG));
			
			for (var i:int = 0; i < 50; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(Util.float_random(180, 800), Util.float_random(50, 450)));
			}
			

			create_sniper_enemy(72, 94, 1,_g);
			create_sniper_enemy(72, 234, 1,_g);
			create_sniper_enemy(72, 382, 1,_g);
			create_sniper_enemy(915, 382, 2,_g);
			create_sniper_enemy(915, 234, 2,_g);
			create_sniper_enemy(915, 92, 2,_g);
			
			return this;
		}
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number, g:GameEngine):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no,g);
			enemy.set_position(x-10, y-25);
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