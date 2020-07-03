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
		self.nivel().inicializarMapa()
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
		(0..(nivel.fila()-1)).forEach( {i => 
            (0..(nivel.col()-1)).forEach({ j =>	
            	nivel.mapa().asList().get(i).get(j).dibujarPared(j, (nivel.fila()-1)-i)
            })
        })
	}
	
	method mapaGameOver(){
		self.nivel(new GameOver())
		self.nivel().inicializarMapa()
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
	
	method siguienteNivel() //abstracto
	
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
	
	method inicializarMapa(){
		nivelManager.visualesDeMenuSuperior()
		base.dibujarParedes()
		nivelManager.inicializarParedes()
        self.ubicarBase(nivelManager.base())
        self.ubicarPlayer(nivelManager.jugador())  
        nivelManager.iniciarEnemigos()
        game.addVisual(barraDeVida)
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
	const property enemigosParaPasar = 1
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
		super()
		return new Nivel2() 
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "A Jugar!")
	}
	
}
class Nivel2 inherits Nivel {
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
		super()
		return new Nivel3()
	}
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Pasaste de Nivel!! Sigamoos Jugando!")
	}
}

class Nivel3 inherits Nivel {
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
		return new Win()
	}
			
	override method ubicarPlayer(jugador){
		super(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


class GameOver inherits Nivel{    	
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
	
	override method inicializarMapa(){
		game.clear()
		nivelManager.inicializarParedes()
	}

}

class Win inherits Nivel{    	
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
	
	override method inicializarMapa(){
		game.clear()
		nivelManager.inicializarParedes()
	}

}
