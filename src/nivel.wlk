import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import paredes.*

object nivelManager{
	var property nivel = null
	var property jugador = null
	var property base = null
	var property enemigosMuertos = 0
	
	method sumarEnemigoMuerto(){
		enemigosMuertos++
		if (enemigosMuertos == self.nivel().enemigosParaPasar()){
			enemigosMuertos = 0
			self.pasarDeNivel()
		}
	}
	
	method incializarMapa() {
		self.inicializarParedes()
        self.nivel().ubicarBase(self.base())
        self.nivel().ubicarPlayer(self.jugador())
        game.say(jugador, "A jugar !!")  
        self.iniciarEnemigos()  
    }
    
	method inicializarParedes(){
		(0..nivel.col()-1).forEach( {i => 
            (0..nivel.fila()-1).forEach({ j =>	
            	if (nivel.mapa().asList().get(j).get(i) == 1) {
            		self.dibujarPaded(i, j)          	}    
            })
        })
	}
	
	method mapaGameOver(){
		self.nivel(gameOver)
		game.clear()
		self.inicializarParedes()
	}
	method dibujarPaded(x,y){
		game.addVisual(new Pared(position=game.at(x, y) ))
	}
	
	method limpiarMapa(){
		game.allVisuals().forEach({unElemento=> game.removeVisual(unElemento)})
		
	}
	
	method pasarDeNivel(){// quitar ontick primero
//	game.clear()
		self.limpiarMapa() // quita todos Visuales del Mapa
		self.nivel(self.nivel().siguienteNivel())
		self.incializarMapa()
	}
	
	method iniciarEnemigos(){
		tanqueEnemigoManagwer.maxTanques(self.nivel().maxTanques())
		tanqueEnemigoManagwer.target(self.jugador())
		game.onTick(tanqueEnemigoManagwer.tankOnTickSpeed(), "tankManagerAtaque", {tanqueEnemigoManagwer.atacar()})
		game.onTick(8000, "tankManager", {tanqueEnemigoManagwer.start()})
	}
	
	method finalizarNivel(){
		game.removeTickEvent("tankManagerAtaque")
		game.removeTickEvent("tankManager")
		game.removeTickEvent("managerPowerUp")
		game.clear()
		game.ground("Fondos/Fondo-1.png")
		self.nivel().ubicarPlayer(self.jugador())
		game.say(self.jugador(), "GAME OVER")
	}
}

object nivel2{
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [0,0,0,0,0,0,1,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila2  = [0,0,0,1,0,0,1,0,0,0, 0,0,0,0,0,0,1,0,0,0]
	const fila3  = [0,0,0,0,0,0,1,1,1,0, 0,0,0,1,0,0,0,0,0,0]
	const fila4  = [0,0,0,1,0,0,0,0,0,0, 0,0,0,1,0,0,1,0,0,0]
	const fila5  = [0,0,0,0,0,0,0,0,0,1, 1,1,0,1,0,0,1,0,0,0]
	const fila6  = [0,0,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,1,0,0,0]
	const fila7  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila8  = [0,0,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila9  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1,0,0]
	const fila10 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,1,0,0]
	const fila11 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1,0,0]
	const fila12 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,1,0,0]
	const fila13 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,1,0,0]
	const fila14 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila15 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila16 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,1,1,1,1,0]
	const fila17 = [0,0,0,0,1,0,0,0,0,0, 0,0,0,0,0,0,0,1,0,0]
	const fila18 = [0,0,0,0,1,0,0,0,0,0, 0,1,0,0,0,0,0,1,0,0]
	const fila19 = [0,0,1,0,0,0,0,0,1,1, 1,1,0,0,0,0,0,1,0,0]
	const fila20 = [0,0,1,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
		          
    const maxTanques = 2
    const property enemigosParaPasar = 5
	
	method mapa(){
		return mapa
	}
	method fila(){
		return game.height() // 20 
	}
	method col(){
		return game.width() //20 //
	}
	method maxTanques(){
		return maxTanques
	}
	method siguienteNivel(){
		return nivel3 // aca va nivel2 cuando exista
	}
	
	method ubicarBase(base){
		game.addVisual(base)
		base.dibujarParedes()
		
	}
		
	method ubicarPlayer(jugador){
//		game.addVisualCharacter(jugador)
		game.addVisual(jugador)
		game.say(jugador, "Pasaste de Nivel!! Sigamoos Jugando!")
	}
}


object nivel1{ // UNQ en el mapa :P
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila2  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila3  = [0,1,0,0,0,1,0,1,0,0, 0,1,0,0,1,1,1,0,0,0]
	const fila4  = [0,1,0,0,0,1,0,1,1,0, 0,1,0,1,0,0,0,0,0,0]
	const fila5  = [0,1,0,0,0,1,0,1,1,0, 0,1,0,1,0,0,0,1,0,0]
	const fila6  = [0,1,0,0,0,1,0,1,1,1, 0,1,0,1,0,0,0,1,0,0]
	const fila7  = [0,1,0,0,0,1,0,1,0,1, 1,1,0,1,0,0,0,1,0,0]
	const fila8  = [0,1,0,0,0,1,0,1,0,0, 1,1,0,1,0,1,0,1,0,0]
	const fila9  = [0,1,0,0,0,1,0,1,0,0, 0,0,0,1,0,1,0,1,0,0]
	const fila10 = [0,0,1,1,1,0,0,1,0,0, 0,0,0,0,1,1,1,0,0,0]
	const fila11 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,1,0,0,0,0]
	const fila12 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,0,0,0]
	const fila13 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila14 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila15 = [0,0,1,1,1,1,1,1,1,0, 0,1,1,1,1,1,1,1,1,0]
	const fila16 = [0,0,0,0,1,1,1,0,0,0, 0,0,0,1,1,1,1,0,0,0]
	const fila17 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila18 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila19 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila20 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
	const property enemigosParaPasar = 3
    const maxTanques = 3
  
	
	method mapa(){
		return mapa
	}
	method fila(){
		return game.height() // 20 
	}
	method col(){
		return game.width() //20 //
	}
	method maxTanques(){
		return maxTanques
	}
	method siguienteNivel(){
		return nivel2 
	}
	method ubicarBase(base){
		game.addVisual(base)
		base.dibujarParedes()
	}
		
	method ubicarPlayer(jugador){
		game.addVisual(jugador)
	}
	
}

object nivel3{   // hacer clase nivel
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * Paredes nulas
	 * ********************************/ 
//	const fila1  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila2  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila3  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila4  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila5  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila6  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila7  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila8  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila9  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila10 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila11 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila12 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila13 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila14 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila15 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila16 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila17 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila18 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila19 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//	const fila20 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
//######################################################################

	const fila1  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila2  = [0,1,1,1,1,1,1,1,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila3  = [0,0,0,0,0,0,0,0,0,0, 0,1,1,1,1,1,1,1,1,0]
	const fila4  = [0,1,1,1,1,1,1,1,1,0, 0,0,0,0,0,0,0,0,0,0]
	const fila5  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila6  = [0,0,0,0,0,0,0,0,0,0, 0,1,1,1,1,1,1,1,1,0]
	const fila7  = [0,1,1,1,1,1,1,1,1,0, 0,0,0,0,0,0,0,0,0,0]
	const fila8  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila9  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila10 = [0,0,0,0,0,0,0,0,0,0, 0,1,1,1,1,1,1,1,1,0]
	const fila11 = [0,1,1,1,1,1,1,1,1,0, 0,0,0,0,0,0,0,0,0,0]
	const fila12 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila13 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila14 = [0,1,1,1,1,1,1,1,1,0, 0,0,0,0,0,0,0,0,0,0]
	const fila15 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila16 = [0,0,0,0,0,0,0,0,0,0, 0,1,1,1,1,1,1,1,1,0]
	const fila17 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila18 = [0,1,1,1,1,1,1,1,1,0, 0,0,0,0,0,0,0,0,0,0]
	const fila19 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila20 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const mapa = [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
	const property enemigosParaPasar = 2
    const maxTanques = 3
  
	
	method mapa(){
		return mapa
	}
	method fila(){
		return game.height() // 20 
	}
	method col(){
		return game.width() //20 //
	}
	method maxTanques(){
		return maxTanques
	}
	method siguienteNivel(){
		return nivel4 
	}
	method ubicarBase(base){
		game.addVisual(base)
		base.dibujarParedes()
	}
		
	method ubicarPlayer(jugador){
		game.addVisual(jugador)
		game.say(jugador, "Ultimo Nivel!! Sigamos adelante!")
	}
}


object gameOver{
	/**********************************
	 * 20 x 20 
	 * O = no hay pared
	 * 1 = hay pared
	 * ********************************/
	const fila1  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila2  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila3  = [0,1,1,0,0,0,1,1,0,0, 1,0,0,0,1,0,1,1,1,1]
	const fila4  = [1,0,0,1,0,1,0,0,1,0, 1,1,0,1,1,0,1,0,0,0]
	const fila5  = [1,0,0,0,0,1,1,1,1,0, 1,0,1,0,1,0,1,1,1,0]
	const fila6  = [1,0,1,1,0,1,0,0,1,0, 1,0,0,0,1,0,1,0,0,0]
	const fila7  = [1,0,0,1,0,1,0,0,1,0, 1,0,0,0,1,0,1,0,0,0]
	const fila8  = [0,1,1,0,0,1,0,0,1,0, 1,0,0,0,1,0,1,1,1,1]
	const fila9  = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila10 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila11 = [0,1,1,0,0,1,0,0,0,1, 0,1,1,1,1,0,1,1,1,1]
	const fila12 = [1,0,0,1,0,1,0,0,0,1, 0,1,0,0,0,0,1,0,0,1]
	const fila13 = [1,0,0,1,0,1,0,0,0,1, 0,1,1,1,0,0,1,1,1,0]
	const fila14 = [1,0,0,1,0,0,1,0,1,0, 0,1,0,0,0,0,1,0,0,1]
	const fila15 = [1,0,0,1,0,0,1,0,1,0, 0,1,0,0,0,0,1,0,0,1]
	const fila16 = [0,1,1,0,0,0,0,1,0,0, 0,1,1,1,1,0,1,0,0,1]
	const fila17 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila18 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila19 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const fila20 = [0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0]
	const mapa =  [fila20,fila19,fila18,fila17,fila16,fila15,fila14,fila13,fila12,fila11,
		          fila10,fila9,fila8,fila7,fila6,fila5,fila4,fila3,fila2,fila1]
    const maxTanques = 5
  
	
	method mapa(){
		return mapa
	}
	method fila(){
		return 20 //game.height()
	}
	method col(){
		return 20 //game.width()
	}
}


