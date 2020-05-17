import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*

object tanque{
	var property vida = 100
	var property position = game.at(5,5)
	var property orientacion = este
	var property bala = balaComun
	var modoAutomatico = false
	var property nivel = 2
	const property tipo = "player"
	
	method tomarPowerUps(upgrade){
		upgrade.aplicar()
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion) ) {
			self.position(nuevaPosicion)
		}
	}
	
	method hayPowerUpsEn(posicion){
		return game.getObjectsIn(posicion).contains({elemento=>elemento.tipo() == "powerUp"})
	}
	
	method image(){
		return "Players/Tanque-2-" + orientacion.imagen()
		//TODO SELF + NIVEL + ORIENTACION
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
		return (game.getObjectsIn(hacia).isEmpty() and self.orientacion().puedeMover(hacia))
	}
	
	method ataque(enemigo){
		self.dispararSiPuede(enemigo)
		self.perseguir(enemigo)
	}
	method autoAtaque(){
		if ( not modoAutomatico){
			modoAutomatico = true
			game.onTick(1000, "tanque", {self.ataque(tanqueEnemigo)})
		} else {
			modoAutomatico = false
			game.removeTickEvent("tanque")
		}
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
}





	




