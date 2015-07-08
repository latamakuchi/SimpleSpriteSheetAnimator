package  
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import flash.text.TextField;

	/**
	 * ...
	 * @author Lorena Weder
	 */
	
	public class SpriteSheet extends MovieClip
	{
		var sourceSprite:Bitmap;
		var displaySprite:Bitmap;
		
		var frameActual:Number = 1;
		var currentFila:Number = 0;
		var currentCol:Number = 0;
		var filas:Number;
		var cols:Number;
		var anchoFrame:Number;
		var altoFrame:Number;
		var diferenciaCuadros:Number;
		
		var myText:TextField = new TextField();
		
		public function SpriteSheet(imagen:BitmapData, posX:Number, posY:Number, cuadros:Number, width:Number = 128, height:Number = 128)
		{
			sourceSprite = new Bitmap(imagen);
			this.x = posX - (width*0.5);
			this.y = posY - (height*0.5);
			altoFrame = height;
			anchoFrame = width;
			
			// Calculo filas y cols en base a los tamaños de las cosas
			
			filas = imagen.height / altoFrame;
			cols = imagen.width / anchoFrame;
			diferenciaCuadros = (filas * cols) - cuadros;
			
			// Creo y agrego el sprite donde se van a mostrar los pixeles de cada imagen/frame de la sprite sheet
			
			displaySprite = new Bitmap(new BitmapData(anchoFrame, altoFrame));
			addChild(displaySprite);

			this.addEventListener(Event.ENTER_FRAME, updateAnim);
			
			addChild(myText);
		}
		
		private function updateAnim(e:Event) {
			
			//Para debbugear! Para borrar: todo esto + los includes arriba de todo!
			myText.text = "FILA: " + currentFila + "\n COL: " + currentCol;
			myText.textColor = 0x00ff00;
			
			// Calculo el punto de origen del frame dentro de la spritesheet
			
			var posX:Number = (currentCol*anchoFrame);
			var posY:Number = (currentFila*altoFrame);
			
			displaySprite.bitmapData.copyPixels(sourceSprite.bitmapData, new Rectangle(posX, posY,anchoFrame, altoFrame), new Point(0, 0));
							
			//Voy por fila. Mantengo fila 0 hasta que llega al ultimo frame de la fila (o sea, la columna es la última)
			
			/**
			 * Ahora evaluo: 
				 * si estoy en la última columna y no hay diferencia de cuadros, o 
				 * habiendo diferencia de cuadros, al estar en la última fila, que la columna actual no supere al nro de
				 * columna en la que empiezan los cuadros vacios
			*/
			 
			if ( ( (currentCol + 1 < cols) && diferenciaCuadros == 0 ) || ( currentFila + 1 == filas && (currentCol + 1 + diferenciaCuadros < cols) )  ) {
				
				currentCol++;
			
			}else {
				
				// Ya es la última, reseteo las columnas para saltar a la próxima fila
				
				currentCol = 0;
				currentFila++;
				
				if (currentFila == filas) {
					currentFila = 0;
				}
			}
				
			
		}
		
	}

}