package  {
	import flash.display.Bitmap;
    import flash.utils.ByteArray;
	import flash.media.Sound;
	public class Resource {
		
		[Embed( source = "../resc/sky.png" )] public static var IMPORT_SKY:Class;
		[Embed( source = "../resc/city_bg.png" )] public static var IMPORT_CITY_BG:Class;
		[Embed( source = "../resc/city_fg.png" )] public static var IMPORT_CITY_FG:Class;
		[Embed( source = "../resc/cleaner_guy.png" )] public static var IMPORT_CLEANER_GUY:Class;
		[Embed( source = "../resc/cable.png" )] public static var IMPORT_CLEANER_GUY_CABLE:Class;
		
// accessories
		[Embed( source = "../resc/accessories/bar_frame.png" )] public static var IMPORT_BAR_FRAME:Class;
		
//stains
		[Embed( source = "../resc/stain/stain1.png" )] public static var IMPORT_STAIN_1:Class;
		[Embed( source = "../resc/stain/stain2.png" )] public static var IMPORT_STAIN_2:Class;
		[Embed( source = "../resc/stain/stain3.png" )] public static var IMPORT_STAIN_3:Class;
		
//sparks
		[Embed( source = "../resc/spark/dust_spark.png" )] public static var IMPORT_DUST_SPARK:Class;
		
//floor1
		[Embed( source = "../resc/floor1/mainbldg_back.png" )] public static var IMPORT_FLOOR1_MAINBLDG_BACK:Class;
		[Embed( source = "../resc/floor1/mainbldg_glasscover.png" )] public static var IMPORT_FLOOR1_MAINBLDG_GLASSCOVER:Class;
		[Embed( source = "../resc/floor1/mainbldg_internal.png" )] public static var IMPORT_FLOOR1_MAINBLDG_INTERNAL:Class;
		[Embed( source = "../resc/floor1/mainbldg_window.png" )] public static var IMPORT_FLOOR1_MAINBLDG_WINDOW:Class;
		
	}
}