package core {
	
	import core.*;
	import enemies.BaseEnemy;
	import enemies.SniperEnemy;
	import flash.display.Sprite;
	import flash.geom.Point;
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
		
		public var _hp_ui:FlxGroup = new FlxGroup();
		public static var HPICON_FULL:String = "HPICON_FULL"; 
		public static var HPICON_EMPTY:String = "HPICON_EMPTY";
		
		public var _bar_frame:FlxSprite = new FlxSprite();
		public var _score:FlxText;
		public var _tag:FlxSprite;
		public var _continue:FlxSprite = new FlxSprite();
		
		public var _fadeout:FlxSprite = new FlxSprite();
		
		public var _g:GameEngine;
		
		public var _ui_btn:FlxSprite = new FlxSprite(Util.WID * 0.9, Util.HEI * 0.01, Resource.IMPORT_INGAME_UI_BTN);
		private var _playlogo:FlxSprite = new PlayLogo();
		
		public function GameUI(g:GameEngine) {
			super();
			
			_g = g;
			
			_continue.loadGraphic(Resource.IMPORT_CONTINUE);
			_continue.x = Util.WID / 2 - _continue.width / 2;
			_continue.visible = false;
			this.add(_continue);
			
			_tag = new FlxSprite(0, 0, Resource.IMPORT_UI_CLEAN_TAG);
			_tag.offset.x = _tag.width / 2;
			_tag.offset.y = -CLEANING_BAR.height * 0.8;
			_tag.scale.x = 1.3;
			
			_score = new FlxText(0, 0, 100, "0%", true);
			_score.setFormat("gamefont", 27);
			_score.color = 0x000000;
			_score.offset.x = _tag.width / 2 + 1.5;
			_score.offset.y = -CLEANING_BAR.height * 0.8 - 3;
			_score.text = "0%";
			
			_bar_frame.loadGraphic(Resource.IMPORT_UI_CLEAN_BACK);
			_bar_frame.set_position(Util.WID / 2 - _bar_frame.width / 2, 0);
			
			_cleaning_bar.loadGraphic(Resource.IMPORT_UI_CLEAN_BAR);
			_cleaning_bar.set_position(Util.WID / 2 - _cleaning_bar.width / 2, 0);
			clean_bar_pct(0);
			
			for (var i:int = 0; i < Player.MAX_HP; i++) {
				_hp_ui.add(cons_hpbar_icon(i * 28, Util.HEI - 30));
			}
			
			this.add(_hp_ui);
			this.add(_bar_frame);
			this.add(_cleaning_bar);
			this.add(_tag);
			this.add(_score);
			
			add(_playlogo);
			
			this.add(_ui_btn);
			
			_fadeout.makeGraphic(Util.WID, Util.HEI, 0xFF000000);
			_fadeout.visible = false;
			_fadeout.alpha = 0;
			this.add(_fadeout);
		}
		
		private function cons_hpbar_icon(x:Number,y:Number):FlxSprite {
			var rtv:FlxSprite = new FlxSprite();
			rtv.loadGraphic(Resource.IMPORT_UI_HEART, true, false, 29, 28);
			rtv.addAnimation(HPICON_FULL, [0]);
			rtv.addAnimation(HPICON_EMPTY, [1]);
			rtv.play(HPICON_FULL);
			return rtv.set_position(x,y);
		}
		
		private static var CLEANING_BAR:FlxSprite = new FlxSprite(0, 0, Resource.IMPORT_UI_CLEAN_BAR);
		private var _last_pct:Number = -1;
		private function clean_bar_pct(pct:Number):void {
			if (pct > 0.8) pct = 0.8;
			pct = pct / 0.8;
			
			if (pct != _last_pct) {
				_cleaning_bar.framePixels.copyPixels(
					CLEANING_BAR.framePixels,
					new Rectangle(0, 0, CLEANING_BAR.width, CLEANING_BAR.height),
					new Point(0, 0)
				);
				_cleaning_bar.framePixels.copyPixels(
					_bar_frame.framePixels, 
					new Rectangle(_bar_frame.width * pct, 0, _bar_frame.width - _bar_frame.width * pct, _bar_frame.height), 
					new Point(_bar_frame.width * pct, 0)
				);
				_last_pct = pct;
			}
			_tag.x = _cleaning_bar.x + CLEANING_BAR.width * pct;
			_score.x = _tag.x;
		}
		
		public var _show_ui_btn_count:Number = 0;
		
		private var _continue_flash_ct:uint = 0;
		public function ui_update():void {
			if (_g._cur_scene.can_continue()) {
				_bar_frame.visible = false;
				_cleaning_bar.visible = false;
				_score.visible = false;
				_tag.visible = false;
			} else {
				_bar_frame.visible = _g._cur_scene.show_hp_bar();
				_cleaning_bar.visible = _g._cur_scene.show_hp_bar();
				_score.visible = _g._cur_scene.show_hp_bar();
				_tag.visible = _g._cur_scene.show_hp_bar();
			}
			
			if (_show_ui_btn_count > 0) {
				_show_ui_btn_count--;
				_ui_btn.alpha = 1;
				
			} else {
				if (_ui_btn.alpha > 0.75) {
					_ui_btn.alpha -= 0.01;
				}
			}
			
			if (FlxG.keys.justPressed("M")) {
				Util.mute_toggle();
				_show_ui_btn_count = 100;
			} else if (FlxG.keys.justPressed("P")) {
				Util.more_games(false);
				_show_ui_btn_count = 100;
			}
			
			var pct:Number = _g.get_cleaned_pct();
			_score.text = int(pct * 100) + "%";
			clean_bar_pct(pct);
			
			for (var i:int = 0; i < Player.MAX_HP; i++) {
				var itr:FlxSprite = _hp_ui.members[i];
				itr.play(i + 1 <= _g._hp?HPICON_FULL:HPICON_EMPTY);
				_hp_ui.members[i].offset.y *= 0.8;
			}
			
			if (_g._cur_scene.can_continue()) {
				_continue_flash_ct++;
				if (_continue_flash_ct % 30 == 0) _continue.visible = !_continue.visible;
				if (_continue_flash_ct % 60 == 0 && !(_g._cur_scene is GroundFloorScene)) FlxG.play(Resource.IMPORT_SOUND_CONTINUE, 0.8);
				
			} else {
				_continue.visible = false;
			}
		}
		
		public function reset_hp_offset():void {
			for (var i:int = 0; i < Player.MAX_HP; i++) {
				var itr:FlxSprite = _hp_ui.members[i];
				itr.play(i + 1 <= _g._hp?HPICON_FULL:HPICON_EMPTY);
				_hp_ui.members[i].offset.y = 0;
			}
		}
		
	}

}