package core {
	
	import core.*;
	import enemies.BaseEnemy;
	import enemies.SniperEnemy;
	import flash.geom.Rectangle;
	import gameobj.BasicBullet;
	import gameobj.BasicStain;
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import misc.ScrollingTextBubble;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	import particle.*;
	import scene.GroundFloorScene;
	import scene.Scene;
	import scene.TestScene;
	
	public class GameUI extends FlxGroup {
		
		public var _cleaning_bar:FlxSprite = new FlxSprite();
		public var _hp_bar:FlxSprite = new FlxSprite();
		public var _bar_frame:FlxSprite = new FlxSprite();
		public var _score:FlxText;
		
		public var _continue:FlxSprite = new FlxSprite();
		
		public var _g:GameEngine;
		
		public function GameUI(g:GameEngine) {
			super();
			
			_g = g;
			
			_continue.loadGraphic(Resource.IMPORT_CONTINUE);
			_continue.x = Util.WID / 2 - _continue.width / 2;
			_continue.visible = false;
			this.add(_continue);
			
			_score = new FlxText(0, 0, 100, "0%", true);
			_score.setFormat("gamefont", 35);
			
			_bar_frame.loadGraphic(Resource.IMPORT_BAR_FRAME);
			_bar_frame.set_position(0, 0);
			_cleaning_bar.scale.x = 0.001;
			_cleaning_bar.set_position(_bar_frame.x + 126, 3);
			_cleaning_bar.loadGraphic(Resource.IMPORT_HPBAR);
			_cleaning_bar.color = 0x4DBFE6;
			_hp_bar.set_position(_bar_frame.x + 114, 28);
			_hp_bar.loadGraphic(Resource.IMPORT_HPBAR);
			_hp_bar.color = 0xDFDF20;
			
			_score.set_position(_bar_frame.x + 280, 2);
			_score.text = "0%";
			
			this.add(_cleaning_bar);
			this.add(_hp_bar);
			this.add(_bar_frame);
			this.add(_score);
		}
		
		private var _continue_flash_ct:uint = 0;
		public function ui_update():void {
			_bar_frame.visible = _g._cur_scene.show_hp_bar();
			_cleaning_bar.visible = _g._cur_scene.show_hp_bar();
			_hp_bar.visible = _g._cur_scene.show_hp_bar();
			_score.visible = _g._cur_scene.show_hp_bar();
			
			hp_update();
			cleaning_update();
			
			if (_g._cur_scene.can_continue()) {
				_continue_flash_ct++;
				if (_continue_flash_ct % 15 == 0) _continue.visible = !_continue.visible;
				
			} else {
				_continue.visible = false;
			}
		}
		
		public function hp_update():void {
			if (_g._hp > 100) {
				_g._hp = 100;
			}
			if (_g._hp < 0) {
				_g._hp = 0;
			}
			
			var pct:Number = _g._hp / 100;
			_hp_bar.scale.x = pct;
			_hp_bar.set_position(_bar_frame.x + 114 - (1 - pct) * 70, 28);
		}
		
		public function cleaning_update():void {
			var pct:Number = _g.get_cleaned_pct();
			_score.text = int(pct * 100) + "%";
			_cleaning_bar.scale.x = pct;
			_cleaning_bar.set_position(_bar_frame.x + 126 - (1 - pct) * 70, 3);
		}
		
	}

}