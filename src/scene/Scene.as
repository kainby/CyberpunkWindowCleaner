package scene {
	import flash.utils.Dictionary;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Scene {
		public static var CHARACTER:String = "CHARACTER"; //NOTE: make sure (name == value)
		public static var PERCENT:String = "PERCENT";
		public static var POSITION:String = "POSITION";
		public static var SPEED:String = "SPEED";
		
		public static var CHARACTER_ROMEO:String = "ROMEO";
		public static var CHARACTER_JULIET:String = "JULIET";
		
		public static var ANIM_STAND:String = "ANIM_STAND";
		public static var ANIM_WALK:String = "ANIM_WALK";
		
		protected var _cur_script:Array = [];
		protected var _g:GameEngine;
		
		protected var _characters:Dictionary = new Dictionary();
		protected var _queued_events:Vector.<QueuedEvent> = new Vector.<QueuedEvent>();
		
		protected var _bg_group:FlxGroup = new FlxGroup();
		protected var _character_group:FlxGroup = new FlxGroup();
		protected var _window_group:FlxGroup = new FlxGroup();
		
		public function Scene(g:GameEngine) {
			_g = g;
		}
		
		public function init():Scene {
			_g._sceneobjs.add(_bg_group);
			_g._sceneobjs.add(_character_group);
			_g._sceneobjs.add(_window_group);
			return this;
		}
		
		protected function load_script(script:Array):void {
			for (var i:int = 0; i < script.length; i++) {
				var itr:Object = script[i];
				if (itr[PERCENT] <= 0) {
					eval_event(itr);
				} else {
					_cur_script.push(itr);
				}
			}
		}
		
		public function eval_event(evt:Object):void {
			trace("event at", evt[PERCENT], _g.get_cleaned_pct());
			
			if (_characters[evt[CHARACTER]] == null) {
				var spr:FlxSprite = get_sprite_for_character_name(evt[CHARACTER]);
				_characters[evt[CHARACTER]] = spr;
				_character_group.add(spr);
				spr.set_position(evt[POSITION][0], evt[POSITION][1]);
			}
			
			if (evt[POSITION] != null) {
				_queued_events.push(new MoveToQueuedEvent(
					evt[CHARACTER],
					_characters[evt[CHARACTER]],
					evt[PERCENT],
					evt[POSITION],
					evt[SPEED]==null?1:evt[SPEED]
				));
			}
			
		}
		
		public function update():void {
			for (var i:int = _cur_script.length - 1; i >= 0; i--) {
				var itr_scrpt:Object = _cur_script[i];
				if (itr_scrpt[PERCENT] <= _g.get_cleaned_pct()) {
					_cur_script.splice(i, 1);
					eval_event(itr_scrpt);
				}
			}
			
			var name_to_evt:Dictionary = new Dictionary();
			for (i = _queued_events.length -1; i >= 0; i--) {
				var itr_evt:QueuedEvent = _queued_events[i];
				if (name_to_evt[itr_evt._name] == null || name_to_evt[itr_evt._name]._pct > itr_evt._pct) {
					name_to_evt[itr_evt._name] = itr_evt;
				}
			}
			
			for each(var itr:QueuedEvent in name_to_evt) {
			  	itr.update();
				if (itr.done()) {
					_queued_events.splice(_queued_events.indexOf(itr), 1);
				}
			}
		}
		
		private function get_sprite_for_character_name(name:String):FlxSprite {
			var rtv:FlxSprite = new FlxSprite();
			if (name == CHARACTER_ROMEO) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_ROMEO,true,true,12,25);
				rtv.addAnimation(ANIM_WALK, [0, 1], 20);
				rtv.addAnimation(ANIM_STAND, [0], 0);
				rtv.play(ANIM_STAND);
				rtv.offset.x = 6;
				rtv.offset.y = 25;
				
			} else if (name == CHARACTER_JULIET) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_JULIET,true,true,13,35);
				rtv.addAnimation(ANIM_WALK, [0, 1], 20);
				rtv.addAnimation(ANIM_STAND, [0], 0);
				rtv.play(ANIM_STAND);
				rtv.offset.x = 13/2.0;
				rtv.offset.y = 35;
				
			}
			return rtv;
		}
		
	}
}