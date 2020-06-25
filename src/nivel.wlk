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
	var property base = null
	var property enemigosMuertos = 0
	var property gano = false
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
	
	method incializarMapa() {
		if (not self.gano()) {
			self.visualesDeMenuSuperior()
			base.dibujarParedes()
			self.inicializarParedes()
        	self.nivel().ubicarBase(self.base())
        	self.nivel().ubicarPlayer(self.jugador())  
        	self.iniciarEnemigos()
        	game.addVisual(barraDeVida)
        } else {
        	self.mapaWin()
        }  
    }
    
    method visualesDeMenuSuperior(){
    		game.addVisual(imagenDeNivel)
	    	game.addVisual(enemigosFaltantes)
		    game.addVisual(score)
		 	game.addVisual(decenasDeMil)
	 		game.addVisual(unidadesDeMil)
	 		game.addVisual(centenas)
	 		game.addVisual(decenas)
	 		game.addVisual(unidades)
    }
    
	method inicializarParedes(){
		(0..nivel.col()-1).forEach( {i => 
            (0..nivel.fila()-1).forEach({ j =>	
            	nivel.mapa().asList().get(j).get(i).dibujarPared(i, j)
            })
        })
	}
	
	method mapaGameOver(){
		self.nivel(gameOver)
		game.clear()
		self.inicializarParedes()
	}
	
	method mapaWin(){
		self.nivel(win)
		game.clear()
		self.inicializarParedes()
	}
		
	method limpiarMapa(){
		game.allVisuals().forEach({unElemento=> game.removeVisual(unElemento)})
		
	}
	
	method pasarDeNivel(){
		self.limpiarMapa()
		self.nivel(self.nivel().siguienteNivel())
		self.incializarMapa()
	}
	
	method iniciarEnemigos(){
		tanqueEnemigoManagwer.maxTanques(self.nivel().maxTanques())
		tanqueEnemigoManagwer.target(self.jugador())
		game.onTick(tanqueEnemigoManagwer.tankOnTickSpeed(), "tankManagerAtaque", {tanqueEnemigoManagwer.atacar()})
		game.onTick(8000, "tankManager", {tanqueEnemigoManagwer.start()})
	}
	
}

class Nivel{
	method mapa()           // abstracto
	method maxTanques()     // abstracto
	
	method siguienteNivel(){
		nivelManager.gano(false)
		return null
	}
	
	method fila(){
		return game.height() 
	}
	method col(){
		return game.width()
	}
	method ubicarBase(base){
		game.addVisual(base)
		base.dibujarParedes()
	}
	method ubicarPlayer(jugador){
		game.addVisual(jugador)
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
		game.addVisual(new Pared(position=game.at(x, y) ))
	}
}
/********************************************** */

class Nivel1 inherits Nivel { // UNQ en el mapa :P
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila2  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila3  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila4  = [o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila5  = [o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila6  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila7  = [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila8  = [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila9  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila10 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila11 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila12 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila13 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila14 = [o,o,o,o,o,x,x,x,o,o, o,o,o,o,o,o,x,o,o,o]
	const fila15 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o]
	const fila16 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o]
	const fila17 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o]
	const fila18 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila19 = [o,o,o,o,o,o,o,o,o,o, x,x,x,o,o,o,o,o,o,o]
	const fila20 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
	const property enemigosParaPasar = 1
    const maxTanques = 1
    const property nombreNivel = "nivel1"
  
	
	override method mapa(){
		return mapa
	}
	
	override method maxTanques(){
		return maxTanques
	}
	
	override method siguienteNivel(){
		super()
		return new Nivel2() 
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "A Jugar!")
	}
	
}
class Nivel2 inherits Nivel {
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila2  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila3  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila4  = [o,o,o,x,o,o,o,o,o,o, o,o,o,x,o,o,x,o,o,o]
	const fila5  = [o,o,o,o,o,o,o,o,o,x, x,x,o,x,o,o,x,o,o,o]
	const fila6  = [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,x,o,o,o]
	const fila7  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila8  = [o,o,o,x,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila9  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o]
	const fila10 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o]
	const fila11 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o]
	const fila12 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o]
	const fila13 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,x,x,x,o,o]
	const fila14 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila15 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila16 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,x,x,x,x,o]
	const fila17 = [o,o,o,o,x,o,o,o,o,o, o,o,o,o,o,o,o,x,o,o]
	const fila18 = [o,o,o,o,x,o,o,o,o,o, o,x,o,o,o,o,o,x,o,o]
	const fila19 = [o,o,x,o,o,o,o,o,x,x, x,x,o,o,o,o,o,x,o,o]
	const fila20 = [o,o,x,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
	const property nombreNivel = "nivel2"
    const maxTanques = 1
    const property enemigosParaPasar = 1
	
	override method mapa(){
		return mapa
	}
	override method maxTanques(){
		return maxTanques
	}
	override method siguienteNivel(){
		super()
		return new Nivel3()
	}
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Pasaste de Nivel!! Sigamoos Jugando!")
	}
}

class Nivel3 inherits Nivel {   // hacer clase nivel
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * Paredes nulas
	 * ********************************/ 
	const fila1  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila2  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila3  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila4  = [o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o]
	const fila5  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila6  = [o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o]
	const fila7  = [o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o]
	const fila8  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila9  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila10 = [o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o]
	const fila11 = [o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o]
	const fila12 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila13 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila14 = [o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o]
	const fila15 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila16 = [o,o,o,o,o,o,o,o,o,o, o,x,x,x,x,x,x,x,x,o]
	const fila17 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila18 = [o,x,x,x,x,x,x,x,x,o, o,o,o,o,o,o,o,o,o,o]
	const fila19 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila20 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
	const property enemigosParaPasar = 1
    const maxTanques = 1
    const property nombreNivel = "nivel3"
  
	
	override method mapa(){
		return mapa
	}
	
	override method maxTanques(){
		return maxTanques
	}
	
	override method siguienteNivel(){
		nivelManager.gano(true)
		return win
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


object gameOver{
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila2  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila3  = [o,x,x,o,o,o,x,x,o,o, x,o,o,o,x,o,x,x,x,x]
	const fila4  = [x,o,o,x,o,x,o,o,x,o, x,x,o,x,x,o,x,o,o,o]
	const fila5  = [x,o,o,o,o,x,x,x,x,o, x,o,x,o,x,o,x,x,x,o]
	const fila6  = [x,o,x,x,o,x,o,o,x,o, x,o,o,o,x,o,x,o,o,o]
	const fila7  = [x,o,o,x,o,x,o,o,x,o, x,o,o,o,x,o,x,o,o,o]
	const fila8  = [o,x,x,o,o,x,o,o,x,o, x,o,o,o,x,o,x,x,x,x]
	const fila9  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila10 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila11 = [o,x,x,o,o,x,o,o,o,x, o,x,x,x,x,o,x,x,x,x]
	const fila12 = [x,o,o,x,o,x,o,o,o,x, o,x,o,o,o,o,x,o,o,x]
	const fila13 = [x,o,o,x,o,x,o,o,o,x, o,x,x,x,o,o,x,x,x,o]
	const fila14 = [x,o,o,x,o,o,x,o,x,o, o,x,o,o,o,o,x,o,o,x]
	const fila15 = [x,o,o,x,o,o,x,o,x,o, o,x,o,o,o,o,x,o,o,x]
	const fila16 = [o,x,x,o,o,o,o,x,o,o, o,x,x,x,x,o,x,o,o,x]
	const fila17 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila18 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila19 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila20 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const mapa =  [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
    	
	method mapa(){
		return mapa
	}
	method fila(){
		return game.height() 
	}
	method col(){
		return game.width()
	}
}

object win{
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila2  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila3  = [o,o,x,o,o,o,x,o,o,x, x,o,o,x,o,o,x,o,o,o]
	const fila4  = [o,o,x,o,o,o,x,o,x,o, o,x,o,x,o,o,x,o,o,o]
	const fila5  = [o,o,o,x,o,x,o,o,x,o, o,x,o,x,o,o,x,o,o,o]
	const fila6  = [o,o,o,o,x,o,o,o,x,o, o,x,o,x,o,o,x,o,o,o]
	const fila7  = [o,o,o,o,x,o,o,o,x,o, o,x,o,x,o,o,x,o,o,o]
	const fila8  = [o,o,o,o,x,o,o,o,o,x, x,o,o,o,x,x,o,o,o,o]
	const fila9  = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o] 
	const fila10 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila11 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila12 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila13 = [o,o,x,o,o,o,o,o,o,x, o,x,o,x,x,o,o,o,x,o]
	const fila14 = [o,o,x,o,o,o,o,o,o,x, o,x,o,x,o,x,o,o,x,o]
	const fila15 = [o,o,o,x,o,x,x,o,x,o, o,x,o,x,o,x,o,o,x,o]
	const fila16 = [o,o,o,x,o,x,x,o,x,o, o,x,o,x,o,o,x,o,x,o]
	const fila17 = [o,o,o,o,x,o,o,x,o,o, o,x,o,x,o,o,x,o,x,o]
	const fila18 = [o,o,o,o,x,o,o,x,o,o, o,x,o,x,o,o,o,x,x,o]
	const fila19 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const fila20 = [o,o,o,o,o,o,o,o,o,o, o,o,o,o,o,o,o,o,o,o]
	const mapa =  [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
    	
	method mapa(){
		return mapa
	}
	method fila(){
		return game.height() 
	}
	method col(){
		return game.width()
	}

}
