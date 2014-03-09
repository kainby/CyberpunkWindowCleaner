package scene {
	import core.BGObj;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	import enemies.*;
	public class Floor1Scene extends Scene {
		
		private static var SCRIPT:Array = [
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[360, 325], ID:1  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[405, 325], ID:2  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[470, 325], ID:3  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, POSITION:[435, 325], ID:4  },
			
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[510, 325], ID:5  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[550, 325], ID:6  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[580, 325], ID:7  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, POSITION:[630, 325], ID:8  },
			
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[415, 325], ID:2  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[425, 325], ID:3  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_RED, MILLTO:[455, 325], ID:4  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[525, 325], ID:5  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[565, 325], ID:6  },
			{PERCENT:0, CHARACTER:CHARACTER_THUG_BLUE, MILLTO:[645, 325], ID:7  },
			
			{PERCENT:0, CHARACTER:CHARACTER_ROMEO, POSITION:[670, 325] },
			{PERCENT:0, CHARACTER:CHARACTER_JULIET, POSITION:[320, 325] },
			
			{PERCENT:0.02, CHARACTER:CHARACTER_THUG_BLUE, ID:8, TEXT:"Good-morrow, cousin."},
			{PERCENT:0.08, CHARACTER:CHARACTER_ROMEO, TEXT:"Is the day so young? Sad hours seem so long." },
			{PERCENT:0.14, CHARACTER:CHARACTER_THUG_BLUE, ID:8, TEXT:"What sadness lengthens Romeo's hours?" },
			{PERCENT:0.2, CHARACTER:CHARACTER_ROMEO, TEXT:"Not having that which makes them short." },
			{PERCENT:0.26, CHARACTER:CHARACTER_THUG_BLUE, ID:8,  TEXT:"Of love?" },
			{PERCENT:0.32, CHARACTER:CHARACTER_ROMEO, TEXT:"Out of her favor, I am with love." },
			
			{PERCENT:0.16, CHARACTER:CHARACTER_JULIET, TEXT:"How now! Who calls?" },
			{PERCENT:0.2, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"Your mother."},
			{PERCENT:0.24, CHARACTER:CHARACTER_JULIET, TEXT:"What is her will?" },
			{PERCENT:0.28, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"To know, how is your disposition to be married?" },
			{PERCENT:0.32, CHARACTER:CHARACTER_JULIET, TEXT:"It is an honor I dream not of." },
			
			{PERCENT:0.4, CHARACTER:CHARACTER_ROMEO, POSITION:[485,325]},
			{PERCENT:0.4, CHARACTER:CHARACTER_ROMEO, TEXT:"What lady is that, which doth enrich the hand of yonder knight?" },
			{PERCENT:0.44, CHARACTER:CHARACTER_THUG_BLUE, ID:5, TEXT:"I know not, sir." },
			{PERCENT:0.48, CHARACTER:CHARACTER_ROMEO, TEXT:"O, doth she teach the torches to burn bright!" },
			{PERCENT:0.52, CHARACTER:CHARACTER_ROMEO, POSITION:[345, 325] },
			{PERCENT:0.56, CHARACTER:CHARACTER_ROMEO, TEXT:"I profane with this unworthiest hand, this holy shrine, this gentle fine." },
			{PERCENT:0.6, CHARACTER:CHARACTER_JULIET, TEXT:"Good pilgrim, you do wrong your hand too much." },
			{PERCENT:0.64, CHARACTER:CHARACTER_JULIET, TEXT:"A palm to palm is holy palmer's kiss." },
			
			{PERCENT:0.66, CHARACTER:CHARACTER_JULIET, TEXT:"You kiss by the book." },
			{PERCENT:0.7, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"Madam, your mother calls."},
			{PERCENT:0.72, CHARACTER:CHARACTER_ROMEO, TEXT:"What is her mother?" },
			{PERCENT:0.74, CHARACTER:CHARACTER_THUG_RED, ID:1, TEXT:"Her mother is the lady of the house." },
			{PERCENT:0.76, CHARACTER:CHARACTER_ROMEO, TEXT:"A capulet? My life is in my foe's debt." },
			{PERCENT:0.76, CHARACTER:CHARACTER_ROMEO, POSITION:[700, 325] }
		];
		
		public function Floor1Scene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_BACK));
			_internals_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_INTERNAL));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_WINDOW));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR1_SIDEBLDG));
			
			for (var i:int = 0; i < 50; i++) {
				_g._stains.add((new BasicStain(_g)).set_position(Util.float_random(180, 800), Util.float_random(50, 450)));
			}
			

			create_sniper_enemy(0, 100, 1,_g);
			create_sniper_enemy(0, 200, 1,_g);
			create_sniper_enemy(0, 300, 1,_g);
			create_sniper_enemy(934, 150, 2,_g);
			create_sniper_enemy(934, 250, 2,_g);
			create_sniper_enemy(934, 350, 2, _g);
			
			
			create_jetpack_enemy(72, 1, _g);
			create_jetpack_enemy(863, 2, _g);
			
			return this;
		}
		
		public function create_sniper_enemy(x:Number, y:Number, team_no:Number, g:GameEngine):void {
			var enemy:SniperEnemy = new SniperEnemy(team_no,g);
			enemy.set_position(x, y);
			_g._enemies.add(enemy);
		}
		
		public function create_jetpack_enemy(x:Number, team_no:Number, g:GameEngine):void {
			var enemy:JetPackEnemy = new JetPackEnemy(team_no, x);
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