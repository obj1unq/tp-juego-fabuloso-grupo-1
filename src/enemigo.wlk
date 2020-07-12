import wollok.game.*
import tanque.*
import orientaciones.*
import bala.*
import base.*
import randomizer.*
import efectos.*
import nivel.*

/* manager de tanques enemigos */
object tanqueEnemigoManager{
	const property tanques = []
	const property tankOnTickSpeed = 1000
	var orientacion = norte
	var property maxTanques = 0
	
	method target(){
		return [self.jugador(),self.jugador(),self.jugador(),base,self.jugador(),self.jugador(),self.jugador(),base,self.jugador()].anyOne()
	} 
	method jugador() {
		return nivelManager.jugador()
	} 
	
	method orientacion(){
		orientacion = orientacion.siguienteOrientacion()
		return orientacion
	}
	
	method tanqueEnemigoNuevo(){
		return new TanqueEnemigo(position = randomizer.emptyPosition(), 
								 objetivo= self.target())
	}

	method crearTanque(){
		self.configurarTanque(self.tanqueEnemigoNuevo())
	}
	
	method configurarTanque(unTanque){
		game.addVisual(unTanque)
		unTanque.configurarColisiones()
		self.tanques().add(unTanque)
		game.say(unTanque, "Moriras !!")
	}
	
	method start(){
		if (self.tanques().size() < self.maxTanques()) {
			self.crearTanque()
		}
	}
	
	method destruirTodos(){
			self.tanques().forEach({tanque => tanque.destruir()})
//			tanque.clear()
	}
	
	method atacar(){
		self.tanques().forEach({unTanque => unTanque.ataque()})
	}
	    
}

class TanqueEnemigo inherits TanqueBase{
//	var imagen = ""
	const puntaje = 20
	const objetivo
	
	override method pathImagen(){
		return "Enemigos/tanqueEnemigo-"
	}
	override method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			self.orientacion(self.orientacion().siguienteOrientacion())
			self.orientacion().mover(self)
		}
	}
	
	override method destruir(){
		super()
		tanqueEnemigoManager.tanques().remove(self)
		nivelManager.sumarPuntos(puntaje)
		nivelManager.sumarEnemigoMuerto()
	}
	
	method ataque(){
		if (self.puedeDisparar()) {
			self.disparar()
		}  else {
			self.perseguir()
		}
	}
	
	method estoyAlineadoCon(){
		 return self.estoyAlinadoEnX() or self.estoyAlinadoEnY()
	}
	
	method estoyAlinadoEnX(){
		return   objetivo.position().y() == self.position().y() and
				(   objetivo.position().x() < self.position().x() and self.orientacion() == (oeste) 
				 or objetivo.position().x() > self.position().x() and self.orientacion() == (este))
	}
	
	method estoyAlinadoEnY(){
		return   objetivo.position().x() == self.position().x() and
				(   objetivo.position().y() < self.position().y() and self.orientacion() == (sur) 
				 or objetivo.position().y() > self.position().y() and self.orientacion() == (norte))
	}
	
	method puedeDisparar(){
		return self.estoyAlineadoCon() and self.tiroLimpio()
	}
	method tiroLimpio(){
		return    self.tiroLimpioEnX() and (self.orientacion() == este or self.orientacion() == oeste)   
		       or self.tiroLimpioEnY() and (self.orientacion() == norte or self.orientacion() == sur)
	}
	
	method tiroLimpioEnX(){
		return not tanqueEnemigoManager.tanques().any({tank => tank != self and tank.position().x().between(objetivo.position().x().min(self.position().x()), objetivo.position().x().max(self.position().x()))})
	}
	
	method tiroLimpioEnY(){
		return not tanqueEnemigoManager.tanques().any({tank => tank != self and tank.position().y().between(objetivo.position().y().min(self.position().y()), objetivo.position().y().max(self.position().y()))})
	}
	
	method perseguir(){
		if (objetivo.position().y() > self.position().y()) {
			self.orientacion(norte)
			self.orientacion().mover(self)
		} 
		else if (objetivo.position().y() < self.position().y()) {
			self.orientacion(sur)
			self.orientacion().mover(self)
		} 
		else if (objetivo.position().x() > self.position().x()) {
			self.orientacion(este)
			self.orientacion().mover(self)
		}
		else if (objetivo.position().x() < self.position().x()) {
			self.orientacion(oeste)
			self.orientacion().mover(self)
		}
	}	
}