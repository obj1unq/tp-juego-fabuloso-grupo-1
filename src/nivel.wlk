import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import paredes.*
import efectos.*

object nivelManager{
	var property nivel = null
	var property jugador = null
//	var property base = null
	var property enemigosMuertos = 0
	var  property puntaje = 0000
	var puntajeComoTexto=""
	
	method puntaje() {
		return puntaje
	}
	method puntajeComoTexto (){
		puntajeComoTexto = puntaje.toString()
		return self.textoDe5Cifras()
	}
	method textoDe5Cifras(){
		if (puntajeComoTexto.length() < 5){
			puntajeComoTexto= "0" + puntajeComoTexto
			return self.textoDe5Cifras()
		}else {
			return puntajeComoTexto
		}
	}
	method sumarPuntos(unNumero){
		puntaje= puntaje + unNumero
	}
	
	method nombreDelNivel(){
		return self.nivel().nombreNivel()
	}
	method sumarEnemigoMuerto(){
		enemigosMuertos++
		if (enemigosMuertos == self.nivel().enemigosParaPasar()){
			enemigosMuertos = 0
			self.pasarDeNivel()
		}
	}
	
	method inicializarNivel(unNivel){
		self.inicializarParedes(unNivel)
		self.nivel(unNivel)
		base.ubicarBase()
		self.iniciarEnemigos()		
		}		

    method crearJugador1(){
    	return 	self.jugador(new Tanque(orientacion=este,
    							position=game.at(base.position().x() -2,base.position().y())))
    }
    
	method inicializarParedes(unNivel){		(0..(unNivel.fila()-1)).forEach({i => 
            (0..(unNivel.col()-1)).forEach({ j =>	
            	unNivel.mapa().asList().get(i).get(j).dibujarPared(j, (unNivel.fila()-1)-i)})
       		 })
        }
//  	method dibujarParedes(unNivel){
//  		var inicioX= game.origin().x()
//  		var inicioY= game.origin().Y()
//  		unNivel.mapa().forEach({unaFila=>self.dibujarFilaDeParedes(unaFila)})	
//  	}
//    
//    method  dibujarFilaDeParedes(unaFila){
//    	unaFila.forEach({unaPared=>self.dibujarUnaPared(unaPared)})
//    } 
//*********************************

//	method inicializarParedes(unMapa){
//		(0..unMapa.size()-1).forEach({unaCoordenadaEnY=>self.filaDeParedes(unaCoordenadaEnY,unMapa.get(unaCoordenadaEnY))})
//	}
//
//    method filaDeParedes(unaCoordenadaY,unaFila){
//    	(0..(unaFila.size()-1)).forEach({unaCoordenaEnX=>self.dibujarUnaParedEn_(unaCoordenaEnX, unaCoordenadaY, unaFila.get(unaCoordenaEnX))})
//    }
//    
//    method dibujarUnaParedEn_(x,y,pared){
//    	pared.dibujarPared(x,y)
//    }  
    
//    **********************
//***********************
    
	method limpiarMapa(){
		game.allVisuals().forEach({unElemento=> game.removeVisual(unElemento)})
	}
	
	method pasarDeNivel(){
		self.limpiarMapa()
		self.nivel(self.nivel().siguienteNivel())
//		self.incializarMapa()
	}
	
	method iniciarEnemigos(){
		tanqueEnemigoManager.maxTanques(self.nivel().maxTanques())
		game.onTick(tanqueEnemigoManager.tankOnTickSpeed(), "tankManagerAtaque", {tanqueEnemigoManager.atacar()})
		game.onTick(8000, "tankManager", {tanqueEnemigoManager.start()})
	}
	
}
/********* objetos de la matriz del nivel
 *  o = sin pared
 *  x = con pared
 */
object o{
	method dibujarPared(x,y){}
}

object x{
	method dibujarPared(x,y){
		self.configurarPared(self.paredNueva(x,y))
	}
	
	method paredNueva(x,y){
		return new Pared(position = game.at(x,y))
	}
	method configurarPared(unaPared){
		game.addVisual(unaPared)
		game.whenCollideDo(unaPared,{unElemento => unaPared.recibirImpactoDe(unElemento)})
	}

}

class Nivel{
	method mapa()           // abstracto
	method maxTanques()     // abstracto
	
	method siguienteNivel() //abstracto
	
	method fila(){
		return game.height() 
	}
	method col(){
		return game.width()
	}
	method ubicarPlayer(jugador){
		game.addVisual(jugador)
	}
}


/********************************************** */

object nivel1 inherits Nivel { // UNQ en el mapa :P
	const property enemigosParaPasar = 2
    const maxTanques = 1
    const property nombreNivel = "nivel1"
  
	
	override method mapa(){
		return  [[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
	 			 [o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,x,x,x,o,o, o,o,o,o,o,o,x,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, x,x,x,o,o,o,o,o,o,o],
				 [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]]
	}
	
	override method maxTanques(){
		return maxTanques
	}
	
	override method siguienteNivel(){
		 nivelManager.inicializarNivel(nivel2)
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "A Jugar!")
	}
	
}
object nivel2 inherits Nivel {
	const property nombreNivel = "nivel2"
    const maxTanques = 1
    const property enemigosParaPasar = 1
	
	override method mapa(){
		return  [[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,x,o,o,o,o,o,o, o,o,o,x,o,o,x,o,o,o],
				[o,o,o,o,o,o,o,o,o,x, x,x,o,x,o,o,x,o,o,o],
				[o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,x,x,x,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,x,x,x,x,o],
				[o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o],
				[o,o,o,o,x,o,o,o,o,o, o,x,o,o,o,o,o,x,o,o],
				[o,o,x,o,o,o,o,o,x,x, x,x,o,o,o,o,o,x,o,o],
				[o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]]
	}
	override method maxTanques(){
		return maxTanques
	}
	override method siguienteNivel(){
		nivelManager.inicializarNivel(nivel3)
	}
	
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Pasaste de Nivel!! Sigamoos Jugando!")
	}
}

object nivel3 inherits Nivel {
	const property enemigosParaPasar = 1
    const maxTanques = 1
    const property nombreNivel = "nivel3"
  
	
	override method mapa(){
		return [[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o],
				[o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o],
				[o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]]
	}
	
	override method maxTanques(){
		return maxTanques
	}
	
	override method siguienteNivel(){
		nivelManager.inicializarNivel(win)
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


object gameOver inherits Nivel{    	
	override method mapa(){
		return [[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,x,x,o,o,o,x,x,o,o, x,o,o,o,x,o,x,x,x,x],
				[x,o,o,x,o,x,o,o,x,o, x,x,o,x,x,o,x,o,o,o],
				[x,o,o,o,o,x,x,x,x,o, x,o,x,o,x,o,x,x,x,o],
				[x,o,x,x,o,x,o,o,x,o, x,o,o,o,x,o,x,o,o,o],
				[x,o,o,x,o,x,o,o,x,o, x,o,o,o,x,o,x,o,o,o],
				[o,x,x,o,o,x,o,o,x,o, x,o,o,o,x,o,x,x,x,x],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,x,x,o,o,x,o,o,o,x, o,x,x,x,x,o,x,x,x,x],
				[x,o,o,x,o,x,o,o,o,x, o,x,o,o,o,o,x,o,o,x],
				[x,o,o,x,o,x,o,o,o,x, o,x,x,x,o,o,x,x,x,o],
				[x,o,o,x,o,o,x,o,x,o, o,x,o,o,o,o,x,o,o,x],
				[x,o,o,x,o,o,x,o,x,o, o,x,o,o,o,o,x,o,o,x],
				[o,x,x,o,o,o,o,x,o,o, o,x,x,x,x,o,x,o,o,x],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]]
	}
	override method maxTanques(){return 0}
	override method siguienteNivel(){return null}
	
//	override method inicializarMapa(){
//		game.clear()
//		nivelManager.inicializarParedes()
//	}

}

object win inherits Nivel{    	
	override method mapa(){
		return [[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,x,o,o,o,x,o,o,x, x,o,o,x,o,o,x,o,o,o],
				[o,o,x,o,o,o,x,o,x,o, o,x,o,x,o,o,x,o,o,o],
				[o,o,o,x,o,x,o,o,x,o, o,x,o,x,o,o,x,o,o,o],
				[o,o,o,o,x,o,o,o,x,o, o,x,o,x,o,o,x,o,o,o],
				[o,o,o,o,x,o,o,o,x,o, o,x,o,x,o,o,x,o,o,o],
				[o,o,o,o,x,o,o,o,o,x, x,o,o,o,x,x,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,x,o,o,o,o,o,o,x, o,x,o,x,x,o,o,o,x,o],
				[o,o,x,o,o,o,o,o,o,x, o,x,o,x,o,x,o,o,x,o],
				[o,o,o,x,o,x,x,o,x,o, o,x,o,x,o,x,o,o,x,o],
				[o,o,o,x,o,x,x,o,x,o, o,x,o,x,o,o,x,o,x,o],
				[o,o,o,o,x,o,o,x,o,o, o,x,o,x,o,o,x,o,x,o],
				[o,o,o,o,x,o,o,x,o,o, o,x,o,x,o,o,o,x,x,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
				[o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]]
	}
	
	override method maxTanques(){return 0}
	override method siguienteNivel(){return null}
	
//	override method inicializarMapa(){
//		game.clear()
//		nivelManager.inicializarParedes()
//	}

}
