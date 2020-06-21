import wollok.game.*
import tanque.*
import orientaciones.*
import bala.*
import base.*
import randomizer.*
import efectos.*
import nivel.*

/* manager de tanques enemigos */
object tanqueEnemigoManagwer{
	const property tanques = []
	const property tankOnTickSpeed = 500
	var target = base    // la base o el tanque
	var targetAux = base // la base o el tanque 
	var orientacion = norte
	var property maxTanques = 0
	var imagen = "Enemigos/tanqueEnemigo-"
	
	method target(atacar){
		target = base
		targetAux = atacar
	}
	method target(){
		if ( target.equals(base) ) {
			target = targetAux
		} else {
			target = base
		}
		return target
	} 
	
	method orientacion(){
		orientacion = orientacion.siguienteOrientacion()
		return orientacion
	}
	
	method crearTanque(){
		const tank = new TanqueEnemigo()
		
		tank.position(randomizer.emptyPosition())
		tank.orientacion(self.orientacion())
		tank.imagen(imagen)
		tank.target(self.target())
		self.tanques().add(tank)
		game.addVisual(tank)
		game.say(tank, "Moriras !!")
	}
	
	method start(){
		if (self.tanques().size() < self.maxTanques()) {
			self.crearTanque()
		}
		self.tanques().removeAllSuchThat( {tank => not game.hasVisual(tank)} )
	}
	
	method destruirTodos(){
			tanques.forEach({tanque => tanque.destruir()})
	}
	
	method atacar(){
		tanques.forEach({ tanque => tanque.ataque() })
	}
	    
}

class TanqueEnemigo inherits TanqueBase{
	var property balasPropias = #{}
	var imagen = ""
	var puntaje = 20
	
	override method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			self.orientacion(self.orientacion().siguienteOrientacion())
			self.orientacion().mover(self)
		}
	}
	
	method imagen(path){
		imagen = path
	}
	override method image(){
		return   imagen + self.nivel() + "-" + orientacion.imagen()
	}
	
	override method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		self.destruirSiEstoySinVida()
	}
	
	override method destruir(){
		const animacionDestruir= new AnimacionExplocionTanque()
		super()
		animacionDestruir.animar(self.position())
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
		return   target.position().y() == self.position().y() and
				(   target.position().x() < self.position().x() and self.orientacion() == (oeste) 
				 or target.position().x() > self.position().x() and self.orientacion() == (este))
	}
	
	method estoyAlinadoEnY(){
		return   target.position().x() == self.position().x() and
				(   target.position().y() < self.position().y() and self.orientacion() == (sur) 
				 or target.position().y() > self.position().y() and self.orientacion() == (norte))
	}
	
	method puedeDisparar(){
		return self.estoyAlineadoCon() and self.tiroLimpio()
	}
	method tiroLimpio(){
		return    self.tiroLimpioEnX() and (self.orientacion() == este or self.orientacion() == oeste)   
		       or self.tiroLimpioEnY() and (self.orientacion() == norte or self.orientacion() == sur)
	}
	
	method tiroLimpioEnX(){
		return not tanqueEnemigoManagwer.tanques().any({tank => tank != self and tank.position().x().between(target.position().x().min(self.position().x()), target.position().x().max(self.position().x()))})
	}
	
	method tiroLimpioEnY(){
		return not tanqueEnemigoManagwer.tanques().any({tank => tank != self and tank.position().y().between(target.position().y().min(self.position().y()), target.position().y().max(self.position().y()))})
	}
	
	method perseguir(){
		if (target.position().y() > self.position().y()) {
			self.orientacion(norte)
			self.orientacion().mover(self)
		} 
		else if (target.position().y() < self.position().y()) {
			self.orientacion(sur)
			self.orientacion().mover(self)
		} 
		else if (target.position().x() > self.position().x()) {
			self.orientacion(este)
			self.orientacion().mover(self)
		}
		else if (target.position().x() < self.position().x()) {
			self.orientacion(oeste)
			self.orientacion().mover(self)
		}
	}

	method tomarPowerUps(powerUp){
		powerUp.aplicar(self)
	}	
}