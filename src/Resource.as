package  {
	import flash.display.Bitmap;
    import flash.utils.ByteArray;
	import flash.media.Sound;
	public class Resource {
		
		[Embed( source = "../resc/car/car1.png" )]
		private static var IMPORT_CAR1:Class;
		public static var RESC_CAR1:Bitmap = new IMPORT_CAR1 as Bitmap;
		
	}
}