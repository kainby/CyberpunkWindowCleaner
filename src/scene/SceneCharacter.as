package scene 
{
	import org.flixel.FlxSprite;

	public class SceneCharacter extends FlxSprite {
		
		public var _is_moving:Boolean = false;
		
		public function SceneCharacter(x:Number=0,y:Number=0) {
			super(x, y);
		}
		
		public var _cur_anim:String = "NONE";
		public override function play(anim:String, force:Boolean = false):void {
			if (anim != _cur_anim) {
				_cur_anim = anim;
				super.play(anim, force);
			}
		}
		
		
		
	}

}