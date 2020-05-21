import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*

class Tanque{
	var property vida = 100
	var property position = null
	var property orientacion = null
	var property bala = null
	var property nivel = 1
	var property target = null
	var property nombreTick = ""
	var imagen = ""
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else if (self.nombreTick() != ""){
			self.orientacion(self.orientacion().siguienteOrientacion())
			self.orientacion().mover(self)
		}
	}
	
	method sumarVida(cantidad){
		vida = vida + cantidad
	}
	method imagen(path){
		imagen = path
	}
	method image(){
		return   imagen + self.nivel() + "-" + orientacion.imagen()
		//TODO: self + ""-" +
	}
	
	method disparar(){
		if (not game.hasVisual(self.bala()) ) {
			self.bala().position(self.position())
			self.bala().orientacion(self.orientacion())
			game.addVisual(self.bala())
			self.bala().salirDisparada()
			game.onTick(100, self.bala().nombreTick(), { self.bala().salirDisparada() })
			game.whenCollideDo(self.bala(), { elemento => self.bala().ocasionarDanio() })
		}
	}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
		if (self.nombreTick() != ""){
			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
		} else {
			nivelManager.finalizarNivel()
		}
	}
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()}) and self.orientacion().puedeMover(hacia)
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
	method esAtravezable(){
		return false
	}
	method tomarPowerUps(powerUp){
		powerUp.aplicar(self)
	}	
}