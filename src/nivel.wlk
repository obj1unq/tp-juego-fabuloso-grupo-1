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
		managerParedes.limpiarMapa(self.paredesDeNivelActual())
		self.borrarBalas()
		self.nivel(nivelNuevo)
		self.inicializarParedes(nivelNuevo)
		self.reubicarJugador()
	}
	
	method mapaFinal(unMapa){
		game.clear()
		self.inicializarParedes(unMapa)
	}		

    method crearJugador1(){
    	return 	self.jugador(new Tanque(orientacion=este,
    							position=game.at(base.position().x() -2,base.position().y())))
    }
	method inicializarParedes(unNivel){
		managerParedes.construirParedesDe(unNivel.mapa())
	}
//
//    method filaDeParedes(unaCoordenadaY,unaFila){
//    	((0..unaFila.size()-1)).forEach({unaCoordenaEnX=>self.dibujarUnaParedEn_(unaCoordenaEnX, unaCoordenadaY, unaFila.get(unaCoordenaEnX))})
//    }
//    
//    method dibujarUnaParedEn_(x,y,tipoPared){
//    	tipoPared.dibujarPared(x,y)
//    }
//
//    method dibujarParedesPorLista(lista){
//		lista.forEach({parDecoordenadas=> self.dibujarParDeCoordenada(parDecoordenadas)})
//	}
//	method dibujarParDeCoordenada(parDeCoordenadas){
//		self.dibujarUnaParedEn_(parDeCoordenadas.get(1),parDeCoordenadas.get(0),b) //
//	}

//    **********************
//***********************
    
//	method limpiarMapa(){
//		self.paredesDeNivelActual().forEach({unaPared=> game.removeVisual(unaPared)}) //quita Visuales de Paredes
//		self.paredesDeNivelActual().clear() //borra lista de paredes
//	}
	
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
	method iniciarEnemigos(){
		tanqueEnemigoManager.maxTanques(self.nivel().maxTanques())
		game.onTick(tanqueEnemigoManager.tankOnTickSpeed(), "tankManagerAtaque", {tanqueEnemigoManager.atacar()})
		game.onTick(8000, "tankManager", {tanqueEnemigoManager.start()})
	}
	
}
/********* objetos de la matriz del nivel
 *  o = sin pared
 *  x = con pared
 * 	b= pared de base
 */
//class FactoryPared {
//	method dibujarPared(x,y){
//		self.configurarPared(self.paredNueva(x,y))
//	}
//	
//	method paredNueva(x,y){
//		return new Pared(position = game.at(x,y))
//	}
//	method configurarPared(unaPared){
//		game.addVisual(unaPared)
////		nivelManager.paredesDeNivelActual().add(unaPared)
//		game.whenCollideDo(unaPared,{unElemento => unaPared.aplicarEfectoDeObjeto(unElemento)})
//	}
//}
//
//object o inherits FactoryPared{
//	override method dibujarPared(x,y){}
//}
//
//object x inherits FactoryPared{
//	override method configurarPared(unaPared){
//		super(unaPared)
//		nivelManager.paredesDeNivelActual().add(unaPared)
//	}
//}
//
//object b inherits FactoryPared {
//	override method configurarPared(unaPared){
//		super(unaPared)
//		base.paredesDeBase().add(unaPared)
//	}
//}

class Nivel{
	
	method mapa()           // abstracto
	
	method maxTanques()   // abstracto
	
	method siguienteNivel() //abstracto

	method ubicarPlayer(jugador){
		game.addVisual(jugador)
	}
}

object nivel1 inherits Nivel {
	var property enemigosParaPasar = 1

    const property nombreNivel = "nivel1"
  	override method maxTanques(){return 1}
	
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
   
    const property enemigosParaPasar = 1
	override method maxTanques(){return 1}
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
    const property nombreNivel = "nivel3"
 	override method maxTanques(){return 2 }
	
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
				[o,o,o,o,o,o,o,o,o,o, o,o,o,x,x,x,x,x,x,o],
				[o,x,x,x,x,x,o,o,o,o, o,o,o,o,o,o,o,o,o,o],
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
	
	
	
	override method siguienteNivel(){
		 nivelManager.mapaFinal(win)
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


object gameOver {    	
	method mapa(){
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

object win {    	
	method mapa(){
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
}
