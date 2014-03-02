package  {
	import flash.display.Sprite;
	import org.flixel.FlxGroup;
	import flash.geom.Rectangle;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Util {

		public static var WID:Number = 1000;
		public static var HEI:Number = 500;
		
		public static function add_mouse_over(o:DisplayObject) {
                o.addEventListener(MouseEvent.ROLL_OVER, function():void {
                        flash.ui.Mouse.cursor = flash.ui.MouseCursor.BUTTON;
                });
                o.addEventListener(MouseEvent.ROLL_OUT, function():void {
                        flash.ui.Mouse.cursor = flash.ui.MouseCursor.AUTO;
                });
        }
		
		public static function flx_group_add(g:FlxGroup, o:FlxObject):FlxObject {
			g.add(o); return o;
		}
		

		static var tf:TextField = new TextField();
		
		//[Embed(source='../resc/Vanilla.ttf', embedAsCFF="false", fontName='Game', fontFamily="Game", mimeType='application/x-font')]
		//public static var IMPORT_FONT:Class;
		
		public static function render_text(tar:Graphics, text:String, x:Number, y:Number, fontsize:Number = 12, color:uint = 0xFFFFFF):void {
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.textColor = color;
			tf.embedFonts = true;
			tf.defaultTextFormat = new TextFormat("Game",fontsize);
			tf.text = text;
			
			var text_bitmap:BitmapData = new BitmapData(tf.width, tf.height, true, 0x00000000);
			text_bitmap.draw(tf);
			
			var typeTextTranslationX:Number =  x;
			var typeTextTranslationY:Number = y;
			var matrix:Matrix = new Matrix();
			matrix.translate(typeTextTranslationX, typeTextTranslationY);
			
			tar.lineStyle();
			tar.beginBitmapFill(text_bitmap, matrix, true, true);
			tar.drawRect(typeTextTranslationX, typeTextTranslationY, tf.width, tf.height);
			tar.endFill();
		}
		
		public static function get_bounds(game_obj:FlxGroup):Rectangle {
			var o:Object;
			for each (var s:FlxSprite in game_obj.members) {
				if (!o) {
					o = new Object;
					o.min_x = s.x;
					o.min_y = s.y;
					o.max_x = s.x + s.width;
					o.max_y = s.y + s.height;
				} else {
					o.min_x = Math.min(s.x,o.min_x);
					o.min_y = Math.min(s.y,o.min_y);
					o.max_x = Math.max(s.x + s.width,o.max_x);
					o.max_y = Math.max(s.y + s.height,o.max_y);
				}
			}
			return new Rectangle(o.min_x, o.min_y, o.max_x - o.min_x, o.max_y - o.min_y);
		}
		
		public static function round_dec(numIn:Number, decimalPlaces:int):Number {
			var nExp:int = Math.pow(10,decimalPlaces) ;
			var nRetVal:Number = Math.round(numIn * nExp) / nExp
			return nRetVal;
		}
		
		public static function sig_n(chk:Number,val:Number=1):Number {
			if (chk < 0) {
				return -val;
			} else if (chk > 0) {
				return val;
			} else {
				return val;
			}
		}
		
		public static function d2r(d:Number):Number {
			return d * (Math.PI / 180);
		}
		
		public static function r2d(r:Number):Number {
			return r * (180 / Math.PI);
		}
		
		public static function p2m(p:Number):Number {
			return p / pixel_meter_ratio;
		}
		
		public static function m2p(m:Number):Number {
			return m * pixel_meter_ratio;
		}
		
		private static var pixel_meter_ratio:Number = 30;
		
	}

}