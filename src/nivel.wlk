import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import paredes.*
import efectos.*
import wollokTankConfig.*

object nivelManager{
	var property nivel = null
	var property jugador = null
	var property enemigosMuertos = 0
	var  property puntaje = 0000
	var puntajeComoTexto=""
	var property paredesDeNivelActual=[]
	
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
			self.nivel().siguienteNivel()
		}
	}
	
	method inicializarNivel(unNivel){
		self.inicializarParedes(unNivel)
		self.nivel(unNivel)
		base.ubicarBase()
		self.iniciarEnemigos()		
		}
	
	method pasarANivel(nivelNuevo){
		self.limpiarMapa()
		self.borrarBalas()
		self.nivel(nivelNuevo)
		self.inicializarParedes(nivelNuevo)
		self.reubicarJugador()
	}
	
	method mapaFinal(unMapa){
		self.limpiarMapa()
		self.borrarBalas()
		self.nivel(win)
		self.inicializarParedes(nivelNuevo)
	}		

    method crearJugador1(){
    	return 	self.jugador(new Tanque(orientacion=este,
    							position=game.at(base.position().x() -2,base.position().y())))
    }
    
//	method inicializarParedes(unNivel){		
//		(0..(unNivel.fila()-1)).forEach({i => 
//            (0..(unNivel.col()-1)).forEach({ j =>	
//            	unNivel.mapa().asList().get(i).get(j).dibujarPared(j, (unNivel.fila()-1)-i)})
//       		 })
//        }
//    method borrarParedesDe(unNivel){
//    	(0..(unNivel.fila()-1)).forEach({i => 
//            (0..(unNivel.col()-1)).forEach({ j =>	
//            	unNivel.mapa().asList().get(i).get(j).borrarPared(j, (unNivel.fila()-1)-i)})
//       		 })
//    }
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


	method inicializarParedes(unNivel){
		(0..unNivel.mapa().size()-1).forEach({unaCoordenadaEnY=>self.filaDeParedes(unaCoordenadaEnY,unNivel.mapa().get(unaCoordenadaEnY))})
	}

    method filaDeParedes(unaCoordenadaY,unaFila){
    	(0..(unaFila.size()-1)).forEach({unaCoordenaEnX=>self.dibujarUnaParedEn_(unaCoordenaEnX, unaCoordenadaY, unaFila.get(unaCoordenaEnX))})
    }
    
    method dibujarUnaParedEn_(x,y,pared){
    	pared.dibujarPared(y,x)
    }

//    **********************
//***********************
    
	method limpiarMapa(){
		self.paredesDeNivelActual().forEach({unaPared=> game.removeVisual(unaPared)}) //quita Visuales de Paredes
		self.paredesDeNivelActual().clear() //borra lista de paredes
	}
	
	method reubicarJugador(){//borra la visual la reUbico y la vuelvo a mostrar
		game.removeVisual(self.jugador())
		self.jugador().position(game.at(base.position().x() -2,base.position().y()))
		game.addVisual(self.jugador())
	}
	
	method borraTanquesEnemigos(){
		tanqueEnemigoManager.destruirTodos()
	}
	method borrarBalas(){
		managerBala.borrarTodasLasBalas()
	}
	
//	method pasarDeNivel(){
////	self.borrarParedesDe(self.nivel())
//		self.nivel(self.nivel().siguienteNivel())
//		self.inicializarNivel(self.nivel())
//		self.jugador().position(game.at(base.position().x() -2,base.position().y()))
//		wollokTankConfig.VisualesMenuSuperior()
//		self.jugador().configurarColisiones()
//	}
	
//		method inicializarJuego(){
//		self.configuracionVentanaGame()
//		nivelManager.inicializarNivel(nivel1)
//		nivelManager.crearJugador1()
//		
//		self.configurarControles()
//		self.VisualesMenuSuperior()
//		
//		game.addVisual(nivelManager.jugador())
//		managerPowerUp.inicializarPowersUps()
//
//		nivelManager.jugador().configurarColisiones()
//		game.onTick (1000, "imagenNormal",{normalizadorDeImagenes.normalizarImagen()})
//	}
	
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
	method borrarPared(x,y){}
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
		nivelManager.paredesDeNivelActual().add(unaPared)
		game.whenCollideDo(unaPared,{unElemento => unaPared.aplicarEfectoDeObjeto(unElemento)})
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

object nivel1 inherits Nivel {
	var property enemigosParaPasar = 5
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
		 nivelManager.pasarANivel(nivel2)
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
		 nivelManager.pasarANivel(nivel3)
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
		 nivelManager.mapaFinal(win)
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


object gameOver {    	
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

}

object win inherits {    	
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
	
//	override method maxTanques(){return 0}
//	override method siguienteNivel(){return null}
//	override method inicializarMapa(){
//		game.clear()
//		nivelManager.inicializarParedes()
//	}

}
