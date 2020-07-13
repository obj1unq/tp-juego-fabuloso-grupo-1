import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import efectos.*
import nivel.*

class Pared inherits ObjetosQueCambiaSegunDanio{
	
	override method  pathImagen(){
		return "Paredes/pared-"
	}
	
	method nombreDeImagenSegunDanio(){
	if (self.porcetajeDanioRecibido() > 50 && self.porcetajeDanioRecibido() <= 100) 
											 { return 100}  // danio entre 50 y 100%
	 if (self.porcetajeDanioRecibido()  > 10 &&  self.porcetajeDanioRecibido() <= 50)
			   								{ return 50}  // danio entre 10 y 50%
			   else { return 10} }// danio entre 0 y 10%
	
	 method porcetajeDanioRecibido(){
		return ( self.vida() * 100 / (self.danioRecibido() + self.vida() )  )
	}
	
	override method imagenNormal(){
		return self.nivel().toString() + "-" + self.nombreDeImagenSegunDanio() + ".png"
	}
//	override method aplicarEfectoDeObjeto(unObjeto){
//		super(unObjeto)	
//	}
}

object managerParedes{
	
	method construirParedesDe(unMapa){
		((unMapa.size()-1)..0).forEach({unaCoordenadaEnY=>self.filaDeParedes(unaCoordenadaEnY,unMapa.reverse().get(unaCoordenadaEnY))})
	}

    method filaDeParedes(unaCoordenadaY,unaFila){
    	((0..unaFila.size()-1)).forEach({unaCoordenaEnX=>self.dibujarUnaParedEn_(unaCoordenaEnX, unaCoordenadaY, unaFila.get(unaCoordenaEnX))})
    }
    
    method dibujarUnaParedEn_(x,y,tipoPared){
    	tipoPared.dibujarPared(x,y)
    }

    method dibujarParedesPorLista(lista){
		lista.forEach({parDecoordenadas=> self.dibujarParDeCoordenada(parDecoordenadas)})
	}
	method dibujarParDeCoordenada(parDeCoordenadas){
		self.dibujarUnaParedEn_(parDeCoordenadas.get(1),parDeCoordenadas.get(0),b) //
	}
	//********************************************************
	//********************************************************
	//*******************************************************
	method inicializarParedes(unNivel){
		((unNivel.mapa().size()-1)..0).forEach({unaCoordenadaEnY=>self.filaDeParedes(unaCoordenadaEnY,unNivel.mapa().reverse().get(unaCoordenadaEnY))})
	}

//    method filaDeParedes(unaCoordenadaY,unaFila){
//    	((0..unaFila.size()-1)).forEach({unaCoordenaEnX=>self.dibujarUnaParedEn_(unaCoordenaEnX, unaCoordenadaY, unaFila.get(unaCoordenaEnX))})
//    }
    
//    method dibujarUnaParedEn_(x,y,tipoPared){
//    	tipoPared.dibujarPared(x,y)
//    }

//    method dibujarParedesPorLista(lista){
//		lista.forEach({parDecoordenadas=> self.dibujarParDeCoordenada(parDecoordenadas)})
//	}
//	method dibujarParDeCoordenada(parDeCoordenadas){
//		self.dibujarUnaParedEn_(parDeCoordenadas.get(1),parDeCoordenadas.get(0),b) //
//	}
	method limpiarMapa(unMapa){
		nivelManager.paredesDeNivelActual().forEach({unaPared=> game.removeVisual(unaPared)}) //quita Visuales de Paredes
		nivelManager.paredesDeNivelActual().clear() //borra lista de paredes
	}
}



class FactoryPared {
	method dibujarPared(x,y){
		self.configurarPared(self.paredNueva(x,y))
	}
	
	method paredNueva(x,y){
		return new Pared(position = game.at(x,y))
	}
	method configurarPared(unaPared){
		game.addVisual(unaPared)
//		nivelManager.paredesDeNivelActual().add(unaPared)
		game.whenCollideDo(unaPared,{unElemento => unaPared.aplicarEfectoDeObjeto(unElemento)})
	}
}

/********* objetos de la matriz del nivel
 *  o = sin pared
 *  x = con pared
 * 	b= pared de base
 */
object o inherits FactoryPared{
	override method dibujarPared(x,y){}
}

object x inherits FactoryPared{
	override method configurarPared(unaPared){
		super(unaPared)
		nivelManager.paredesDeNivelActual().add(unaPared)
	}
}

object b inherits FactoryPared {
	override method configurarPared(unaPared){
		super(unaPared)
		base.paredesDeBase().add(unaPared)
	}
}
