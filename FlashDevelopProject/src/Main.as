package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Lorena Weder
	 */
	public class Main extends Sprite 
	{
		var imageLoader:Loader;
		const CARPETA = "images/";
		var fileName:String;
		var anchoFrame:Number;
		var altoFrame:Number;
		var cuadros:Number;
		var fps:Number;
		var imagen:Bitmap;
		var imagenBitmapData:BitmapData;
		
		var myText:TextField = new TextField();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Leo los flashvars
			var listaFlashVars:Object = LoaderInfo(this.root.loaderInfo).parameters;
			fileName = String(listaFlashVars["fileName"]);
			anchoFrame = Number(listaFlashVars["anchoFrame"]);
			altoFrame = Number(listaFlashVars["altoFrame"]);
			cuadros = Number(listaFlashVars["cuadros"]);
			fps = Number(listaFlashVars["fps"]);
			
			// Cargo la imagen que se va a usar
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imagenCargadaHandler);
			var fileRequest:URLRequest = new URLRequest(CARPETA + fileName);
			imageLoader.load(fileRequest);
			
			// Seteao los frames por segundo
			stage.frameRate = fps;
			
		}
		
		//Handler de la carga de la imagen
		private function imagenCargadaHandler(e:Event) {
			
			// Uso bitmap data para clonar hasta el infinito y más allá sin cargar la imagen esa cantidad de veces!
			imagen = Bitmap(e.target.content);
			imagenBitmapData = imagen.bitmapData;
			
			/**
			  Agrego evento onClick
			  Usé MOUSE_DOWN para que realmente se ponga en la posición donde hice click 
			  (si no se pone donde hago el release)
			  
			*/
			
			addChild(myText);
			myText.textColor = 0x00ff00;
			myText.text = "childs: " + stage.numChildren;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler);
			imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imagenCargadaHandler);
			
		}
		
		private function onClickHandler(e:MouseEvent):void {
			
			var MiSpriteSheet:SpriteSheet = new SpriteSheet(imagenBitmapData, e.stageX, e.stageY, cuadros, anchoFrame, altoFrame);
			stage.addChild(MiSpriteSheet);
	
			myText.text = "childs: " + stage.numChildren;
			
		}
		
	}
	
}