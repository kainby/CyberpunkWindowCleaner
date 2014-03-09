package  {
	import flash.display.Bitmap;
    import flash.utils.ByteArray;
	import flash.media.Sound;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	public class Resource {
		
		
		[Embed(source = '../resc/mozart_nbp.ttf', embedAsCFF="false", fontName='gamefont', fontFamily="gamefont", mimeType='application/x-font')]
		private var IMPORT_GAME_FONT_TTF:Class;
		
		[Embed(source = "../resc/mozart_nbp.png")] public static var IMPORT_GAME_FONT:Class;
		private static var GAME_BITMAP_FONT:FlxBitmapFont = null;
		public static function get_bitmap_font():FlxBitmapFont {
			if (GAME_BITMAP_FONT == null) {
			GAME_BITMAP_FONT = new FlxBitmapFont(Resource.IMPORT_GAME_FONT, 5, 7, " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", 21, 1);
			GAME_BITMAP_FONT.customSpacingX = 1;
			GAME_BITMAP_FONT.autoUpperCase = false;
			}
			return GAME_BITMAP_FONT;
		}
		
		[Embed( source = "../resc/sky.png" )] public static var IMPORT_SKY:Class;
		[Embed( source = "../resc/city_bg.png" )] public static var IMPORT_CITY_BG:Class;
		[Embed( source = "../resc/cable.png" )] public static var IMPORT_CLEANER_GUY_CABLE:Class;
		
		[Embed( source = "../resc/continue_ui.png" )] public static var IMPORT_CONTINUE:Class;
		[Embed( source = "../resc/speechbubble.png" )] public static var IMPORT_SPEECH_BUBBLE:Class;
		
		[Embed( source = "../resc/25x40.png" )] public static var IMPORT_25x40:Class;
		[Embed( source = "../resc/12x8.png" )] public static var IMPORT_12x8:Class;
// accessories
		[Embed( source = "../resc/accessories/bar_frame.png" )] public static var IMPORT_BAR_FRAME:Class;
		[Embed( source = "../resc/accessories/hpbar.png" )] public static var IMPORT_HPBAR:Class;
		[Embed( source = "../resc/accessories/bullet_round.png" )] public static var IMPORT_BULLET_ROUND:Class;
		[Embed( source = "../resc/accessories/laser_sight.png" )] public static var IMPORT_LASER_SIGHT:Class;
		[Embed( source = "../resc/accessories/blood.png" )] public static var IMPORT_BLOOD:Class;
		[Embed( source = "../resc/accessories/energy_drink.png" )] public static var IMPORT_ENERGY_DRINK:Class;
		
//stains
		[Embed( source = "../resc/stain/stain1.png" )] public static var IMPORT_STAIN_1:Class;
		[Embed( source = "../resc/stain/stain2.png" )] public static var IMPORT_STAIN_2:Class;
		[Embed( source = "../resc/stain/stain3.png" )] public static var IMPORT_STAIN_3:Class;
		
//sparks
		[Embed( source = "../resc/spark/dust_spark.png" )] public static var IMPORT_DUST_SPARK:Class;
		[Embed( source = "../resc/spark/hp_spark.png" )] public static var IMPORT_HP_SPARK:Class;
		
//character
		[Embed( source = "../resc/character/cleaner_guy.png" )] public static var IMPORT_CLEANER_GUY:Class;
		[Embed( source = "../resc/character/romeo.png" )] public static var IMPORT_CHARACTER_ROMEO:Class;
		[Embed( source = "../resc/character/juliet.png" )] public static var IMPORT_CHARACTER_JULIET:Class;
		[Embed( source = "../resc/character/thug_red.png" )] public static var IMPORT_CHARACTER_THUG_RED:Class;
		[Embed( source = "../resc/character/thug_blue.png" )] public static var IMPORT_CHARACTER_THUG_BLUE:Class;
		
		// enemies
		[Embed( source = "../resc/character/enemy_red.png" )] public static var IMPORT_ENEMY_RED:Class;
		[Embed( source = "../resc/character/enemy_blue.png" )] public static var IMPORT_ENEMY_BLUE:Class;
		
//floor0
		[Embed( source = "../resc/floor0/bg.png" )] public static var IMPORT_FLOOR0_BG:Class;

//floor1
		[Embed( source = "../resc/floor1/mainbldg_back.png" )] public static var IMPORT_FLOOR1_MAINBLDG_BACK:Class;
		[Embed( source = "../resc/floor1/mainbldg_internal.png" )] public static var IMPORT_FLOOR1_MAINBLDG_INTERNAL:Class;
		[Embed( source = "../resc/floor1/mainbldg_window.png" )] public static var IMPORT_FLOOR1_MAINBLDG_WINDOW:Class;
		[Embed( source = "../resc/floor1/sidebldg.png" )] public static var IMPORT_FLOOR1_SIDEBLDG:Class;
		
//floor2
		[Embed( source = "../resc/floor2/mainbldg_back.png" )] public static var IMPORT_FLOOR2_MAINBLDG_BACK:Class;
		[Embed( source = "../resc/floor2/mainbldg_internal.png" )] public static var IMPORT_FLOOR2_MAINBLDG_INTERNAL:Class;
		[Embed( source = "../resc/floor2/mainbldg_window.png" )] public static var IMPORT_FLOOR2_MAINBLDG_WINDOW:Class;
		
//floor3
		[Embed( source = "../resc/floor3/mainbldg_back.png" )] public static var IMPORT_FLOOR3_MAINBLDG_BACK:Class;
		[Embed( source = "../resc/floor3/mainbldg_internal.png" )] public static var IMPORT_FLOOR3_MAINBLDG_INTERNAL:Class;
		[Embed( source = "../resc/floor3/mainbldg_window.png" )] public static var IMPORT_FLOOR3_MAINBLDG_WINDOW:Class;
		
//floor4
		[Embed( source = "../resc/floor4/mainbldg_back.png" )] public static var IMPORT_FLOOR4_MAINBLDG_BACK:Class;
		[Embed( source = "../resc/floor4/mainbldg_internal.png" )] public static var IMPORT_FLOOR4_MAINBLDG_INTERNAL:Class;
		[Embed( source = "../resc/floor4/mainbldg_window.png" )] public static var IMPORT_FLOOR4_MAINBLDG_WINDOW:Class;
		[Embed( source = "../resc/floor4/sidebldg.png" )] public static var IMPORT_FLOOR4_SIDEBLDG:Class;
	}
}