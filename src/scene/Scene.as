package scene {
	import core.Player;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Scene {
		public static var CHARACTER:String = "CHARACTER"; //NOTE: make sure (name == value)
		public static var PERCENT:String = "PERCENT";
		public static var POSITION:String = "POSITION";
		public static var MILLTO:String = "MILLTO";
		public static var TEXT:String = "TEXT";
		public static var SPEED:String = "SPEED";
		public static var ID:String = "ID";
		
		public static var CHARACTER_ROMEO:String = "CHARACTER_ROMEO";
		public static var CHARACTER_JULIET:String = "CHARACTER_JULIET";
		public static var CHARACTER_THUG_RED:String = "CHARACTER_THUG_RED";
		public static var CHARACTER_THUG_BLUE:String = "CHARACTER_THUG_BLUE";
		public static var CHARACTER_CLEANER:String = "CHARACTER_CLEANER";
		
		public static var ANIM_STAND:String = "ANIM_STAND";
		public static var ANIM_WALK:String = "ANIM_WALK";
		
		protected var _cur_script:Array = [];
		protected var _g:GameEngine;
		
		protected var _characters:Dictionary = new Dictionary();
		protected var _queued_events:Vector.<QueuedEvent> = new Vector.<QueuedEvent>();
		
		protected var _bg_group:FlxGroup = new FlxGroup();
		protected var _character_group:FlxGroup = new FlxGroup();
		protected var _text_group:FlxGroup = new FlxGroup();
		protected var _internals_group:FlxGroup = new FlxGroup();
		protected var _window_group:FlxGroup = new FlxGroup();
		
		public function Scene(g:GameEngine) {
			_g = g;
		}
		
		public function can_continue():Boolean { return false; }
		public function get_player_x_min():Number { return 180; }
		public function get_player_x_max():Number { return 800; }
		public function get_player_y_min():Number { return 0; }
		public function get_player_y_max():Number { return 450; }
		
		public function set_bg_y(y:Number):void {
			var groups:Array = [_bg_group, _character_group, _text_group, _internals_group, _window_group];
			for each(var group:FlxGroup in groups) {
			}
		}
		
		public function add_offset_to_groups(y:Number) {
			FlxGroup.add_offset_to_all(_bg_group, 0, y);
			FlxGroup.add_offset_to_all(_character_group, 0, y);
			FlxGroup.add_offset_to_all(_text_group, 0, y);
			FlxGroup.add_offset_to_all(_internals_group, 0, y);
			FlxGroup.add_offset_to_all(_window_group, 0, y);
		}
		
		public function remove_groups_from_parent(parent:FlxGroup):void {
			parent.remove(_bg_group);
			parent.remove(_character_group);
			parent.remove(_text_group);
			parent.remove(_internals_group);
			parent.remove(_window_group);
		}
		
		
		public function init():Scene {
			_g._sceneobjs.add(_bg_group);
			_g._sceneobjs.add(_character_group);
			_g._sceneobjs.add(_internals_group);
			_g._sceneobjs.add(_window_group);
			_g._sceneobjs.add(_text_group);
			return this;
		}
		
		public function show_hp_bar():Boolean {
			return true;
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
			
			var unique_name:String = evt[CHARACTER] + (evt[ID] == null ? "_0" : "_" + evt[ID]);
			
			if (_characters[unique_name] == null) {
				var spr:FlxSprite = get_sprite_for_character_name(evt[CHARACTER]);
				_characters[unique_name] = spr;
				_character_group.add(spr);
				spr.set_position(evt[POSITION][0], evt[POSITION][1]);
			}
			
			if (evt[MILLTO] != null) {
				_queued_events.push(new MillAroundQueuedEvent(
					unique_name,
					_characters[unique_name],
					evt[PERCENT],
					evt[MILLTO]
				));
			}
			
			if (evt[POSITION] != null) {
				_queued_events.push(new MoveToQueuedEvent(
					unique_name,
					_characters[unique_name],
					evt[PERCENT],
					evt[POSITION],
					evt[SPEED]==null?1:evt[SPEED]
				));
			}
			
			if (evt[TEXT] != null) {
				_queued_events.push(new TextQueuedEvent(
					unique_name,
					_characters[unique_name],
					evt[PERCENT],
					evt[TEXT],
					_text_group
				));
			}
			
		}
		
		public function update():void {
			for (var i:int = 0; i < _cur_script.length; i++) {
				var itr_scrpt:Object = _cur_script[i];
				if (itr_scrpt[PERCENT] <= _g.get_cleaned_pct()) {
					_cur_script.splice(i, 1);
					eval_event(itr_scrpt);
					i--;
				}
			}
			
			var name_to_evt:Dictionary = new Dictionary();
			for (i = 0; i < _queued_events.length; i++) {
				var itr_evt:QueuedEvent = _queued_events[i];
				var use_name:String = itr_evt._name + getQualifiedClassName(itr_evt);
				if (name_to_evt[use_name] == null || name_to_evt[use_name]._pct > itr_evt._pct) {
					name_to_evt[use_name] = itr_evt;
					
				}
			}
			
			for each (var sc:SceneCharacter in _characters) {
				sc._is_moving = false;
			}
			
			for each(var itr:QueuedEvent in name_to_evt) {
			  	itr.update();
				if (itr.done()) {
					itr.do_remove();
					_queued_events.splice(_queued_events.indexOf(itr), 1);
				}
			}
			
			for each(var sc:SceneCharacter in _characters) {
				if (sc._is_moving) {
					sc.play(ANIM_WALK);
				} else {
					sc.play(ANIM_STAND);
				}
			}
			
		}
		
		private function get_sprite_for_character_name(name:String):SceneCharacter {
			var rtv:SceneCharacter = new SceneCharacter();
			if (name == CHARACTER_ROMEO) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_ROMEO,true,true,27,60);
				rtv.addAnimation(ANIM_WALK, [1, 2, 3, 4], 5);
				rtv.addAnimation(ANIM_STAND, [0], 0);
				rtv.play(ANIM_WALK);
				rtv.offset.x = 27.0/2;
				rtv.offset.y = 60;
				
			} else if (name == CHARACTER_JULIET) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_JULIET,true,true,31,58);
				rtv.addAnimation(ANIM_WALK, [0, 1, 2, 3], 5);
				rtv.addAnimation(ANIM_STAND, [4], 0);
				rtv.play(ANIM_WALK);
				rtv.offset.x = 31/2.0;
				rtv.offset.y = 58;
				
			} else if (name == CHARACTER_THUG_RED) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_THUG_RED, true, true, 57, 69);
				rtv.addAnimation(ANIM_WALK, [0, 1, 2, 3], 5);
				rtv.addAnimation(ANIM_STAND, [4], 0);
				rtv.play(ANIM_WALK);
				rtv.offset.x = 57.0 / 2;
				rtv.offset.y = 69;
				
			} else if (name == CHARACTER_THUG_BLUE) {
				rtv.loadGraphic(Resource.IMPORT_CHARACTER_THUG_BLUE, true, true, 57, 69);
				rtv.addAnimation(ANIM_WALK, [0, 1, 2, 3], 5);
				rtv.addAnimation(ANIM_STAND, [4], 0);
				rtv.play(ANIM_WALK);
				rtv.offset.x = 57.0 / 2;
				rtv.offset.y = 69;
				
			} else if (name == CHARACTER_CLEANER) {
				rtv.loadGraphic(Resource.IMPORT_CLEANER_GUY, true, true, 35, 69);
				rtv.addAnimation(ANIM_STAND, [4], 0);
				rtv.addAnimation(ANIM_WALK, [2, 1, 0, 1], 10);
				rtv.addAnimation(Player.ANIM_SALUTEFRONT, [4, 3], 2);
				rtv.play(ANIM_STAND);
			}
			
			if (name != CHARACTER_CLEANER) {
				var scale:Number = 0.8;
				rtv.set_scale(scale);
				rtv.offset.x *= scale;
				rtv.offset.y *= scale;
			}
			return rtv;
		}
		
	}
}