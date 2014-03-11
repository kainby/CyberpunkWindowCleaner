package  
{
	import core.Player;
	import flash.events.TextEvent;
	import misc.ScrollingTextBubble;
	import org.flixel.FlxBasic;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite
	import scene.Scene;
	public class GameEndMenu extends FlxState {
		
		private var _cleaner1:Player = new Player(), _cleaner2:Player = new Player(), _cleaner3:Player = new Player();
		private var _boss:FlxSprite = new FlxSprite();
		private var _fadeout:FlxSprite = new FlxSprite(), _lastpicture:FlxSprite = new FlxSprite(0, 0, Resource.IMPORT_LASTPICTURE);
		
		public function GameEndMenu() {
			Util.play_bgm(Resource.BGM_MAIN);
			this.add(new FlxSprite(0, 0, Resource.IMPORT_BG_0));
			this.add(new FlxSprite(0, -100, Resource.IMPORT_BG_1));
			this.add(new FlxSprite(0, -160, Resource.IMPORT_BG_2));
			this.add(new FlxSprite(0, 0, Resource.IMPORT_FLOOR0_BG));
			
			_boss.loadGraphic(Resource.IMPORT_CLEANER_GUY, true, true, 35, 69);
			_boss.addAnimation(Scene.ANIM_STAND, [4], 0);
			_boss.play(Scene.ANIM_STAND);
			_boss.set_position(350, 390);
			this.add(_boss);
			
			_cleaner1.set_pos(500, -100);
			_cleaner2.set_pos(550, -200);
			_cleaner3.set_pos(600, -300);
			
			this.add(_cleaner1);
			this.add(_cleaner2);
			this.add(_cleaner3);
			
			this.add(_lastpicture);
			this.add(_fadeout);
			_lastpicture.visible = false;
			_fadeout.makeGraphic(Util.WID, Util.HEI, 0xFF000000);
			_fadeout.alpha = 0;
			
		}
		
		private var _mode:Number = 0;
		private var _boss_text:ScrollingTextBubble;
		private var _c1_text:ScrollingTextBubble, _c2_text:ScrollingTextBubble, _c3_text:ScrollingTextBubble;
		public override function update():void {
			for each(var o:FlxBasic in this.members) if (o is ScrollingTextBubble) (o as ScrollingTextBubble).update();
			
			if (_mode == 0) {
				if (_cleaner1.y() < 390) {
					_cleaner1.y(5);
				} else {
					_cleaner1.continue_animation(Player.ANIM_STANDFRONT);
				}
				if (_cleaner2.y() < 390) {
					_cleaner2.y(5);
				} else {
					_cleaner2.continue_animation(Player.ANIM_STANDFRONT);
				}
				if (_cleaner3.y() < 390) {
					_cleaner3.y(5);
				}
				if (_cleaner3.y() >= 390 && _cleaner2.y() >= 390 && _cleaner3.y() >= 390) {
					_cleaner3.continue_animation(Player.ANIM_STANDFRONT);
					_mode = 1;
					cons_boss_text("Nice work! Anything unusual up there today?");
				}
				
			} else if (_mode == 1) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					_mode = 2;
					this.remove(_boss_text);
					_boss_text.end();
					_boss_text = null;
					_c2_text = cons_cleaner_text("Nope.", _cleaner2);
					_c1_text = cons_cleaner_text("Well actually...", _cleaner1);
					_c3_text = cons_cleaner_text("Nope.", _cleaner3);
				}
				
			} else if (_mode == 2) {
				_c1_text.scroll_tick();
				_c2_text.scroll_tick();
				_c3_text.scroll_tick();
				if (_c1_text.is_complete()) {
					_c1_text.end();
					_c2_text.end();
					_c3_text.end();
					this.remove(_c1_text);
					this.remove(_c2_text);
					this.remove(_c3_text);
					cons_boss_text("Great! Drinks on me tonight.");
					_mode = 3;
				}
				
			} else if (_mode == 3) {
				_boss_text.scroll_tick();
				if (_boss_text.is_complete()) {
					_boss_text.end();
					this.remove(_boss_text);
					_boss_text = null;
					_mode = 4;
				}
				
			} else if (_mode == 4) {
				_fadeout.alpha += 0.01;
				if (_fadeout.alpha >= 1) {
					_lastpicture.visible = true;
					_mode = 5;
				}
				
			} else if (_mode == 5) {
				if (_fadeout.alpha > 0) _fadeout.alpha -= 0.01;
			}
		}
		
		private function cons_cleaner_text(str:String, c:Player):ScrollingTextBubble {
			var rtv:ScrollingTextBubble = new ScrollingTextBubble(str);
			this.add(rtv);
			rtv.set_pos(c.x() + 7, c.y());
			return rtv;
		}
		
		private function cons_boss_text(str:String):void {
			if (_boss_text != null) {
				this.remove(_boss_text);
				_boss_text.end();
				_boss_text = null;
			}
			_boss_text = new ScrollingTextBubble(str);
			this.add(_boss_text);
			_boss_text.set_pos(_boss.x+7, _boss.y);
		}
		
	}

}