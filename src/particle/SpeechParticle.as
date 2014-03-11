package particle {
	import misc.ScrollingTextBubble;
	import org.flixel.FlxSprite;
	public class SpeechParticle extends Particle {
		
		public var _follow:FlxSprite;
		public var _bubble:ScrollingTextBubble;
		public var _g:GameEngine;
		
		public var _offsetx:Number = 0, _offsety:Number = 0;
		
		public function SpeechParticle(follow:FlxSprite, text:String, g:GameEngine, offsetx:Number = 0, offsety:Number = 0) {
			_follow = follow;
			_g = g;
			_offsetx = offsetx;
			_offsety = offsety;
			_bubble = new ScrollingTextBubble(text);
			_bubble.set_pos(follow.x + _offsetx, follow.y+_offsety);
			g._sceneobjs.add(_bubble);
			this.visible = false;
			
		}
		
		public override function particle_update(game:GameEngine):void {
			_bubble.update();
			_bubble.scroll_tick();
			_bubble.set_pos(_follow.x + _offsetx, _follow.y+_offsety);
		}
		
		public override function should_remove():Boolean {
			return _bubble.is_complete();
		}
		
		public override function do_remove():void {
			_g._sceneobjs.remove(_bubble);
			_bubble.end();
		}
		
	}

}