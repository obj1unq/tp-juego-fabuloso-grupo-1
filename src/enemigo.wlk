import wollok.game.*
import tanque.*
import orientaciones.*
import bala.*

object tanqueEnemigo{
	const property tipo = "enemigo"
	var property vida = 100
	var property position = game.at(6,6)
	var property orientacion = norte
	var property bala = balaEnemigo
	var property nivel = 1
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	
	method sumarVida(cantidad){
		vida = vida + cantidad
	}
	method image(){
		return   "Enemigos/tanqueEnemigo-" + self.nivel() + "-" + orientacion.imagen()
		//TODO: self + ""-" +
	}
	
	method disparar(){
		if (not game.hasVisual(self.bala()) ) {
			self.bala().position(self.position())
			self.bala().orientacion(self.orientacion())
			game.addVisual(self.bala())
			self.bala().salirDisparada()
			game.onTick(500, self.bala().nombreTick(), { self.bala().salirDisparada() })
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
		game.removeVisual(self)
	}
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).isEmpty() and self.orientacion().puedeMover(hacia)
	}
	
	method ataque(enemigo){
		self.dispararSiPuede(enemigo)
		self.perseguir(enemigo)
	}
	
	method estoyAlineadoCon(enemigo){
		 return self.estoyAlinadoEnX(enemigo) or self.estoyAlinadoEnY(enemigo)
	}
	
	method estoyAlinadoEnX(enemigo){
		return   enemigo.position().y() == self.position().y() and
				(   enemigo.position().x() < self.position().x() and self.orientacion() == (oeste) 
				 or enemigo.position().x() > self.position().x() and self.orientacion() == (este))
	}
	
	method estoyAlinadoEnY(enemigo){
		return   enemigo.position().x() == self.position().x() and
				(   enemigo.position().y() < self.position().y() and self.orientacion() == (sur) 
				 or enemigo.position().y() > self.position().y() and self.orientacion() == (norte))
	}
	
	method dispararSiPuede(enemigo){
		if (self.estoyAlineadoCon(enemigo)) {
			self.disparar()
		}
	}
	
	method perseguir(enemigo){
		if (enemigo.position().y() > self.position().y()) {
			self.orientacion(norte)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().y() < self.position().y()) {
			self.orientacion(sur)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().x() > self.position().x()) {
			self.orientacion(este)
			self.orientacion().mover(self)
		}
		else {
			self.orientacion(oeste)
			self.orientacion().mover(self)
		}
	}
	method esAtravezable(){
		return false
	}
	
	
}