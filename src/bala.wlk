import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*


object balaComun {
	var property danio = 20
	var property position = null
	var property orientacion = norte 
	const property nombreTick = "bala" 
	
	method image(){
		return "Disparos/normal-" + orientacion.imagen()
	}
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	method aumentarDanio(cantidad){
		danio = danio + cantidad
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
	
	method ocasionarDanio(){
		game.removeTickEvent(self.nombreTick())
		game.uniqueCollider(self).recibirImpactoDe(self)		
	}
	
	method recibirImpactoDe(objeto){
		if (game.hasVisual(objeto)) {
			game.removeVisual(objeto)
		}
		if (game.hasVisual(self)) {
			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
		}
	}
	method esAtravezable(){
		return true
	}
}


object balaEnemigo {
	var property danio = 20
	var property position = null
	var property orientacion = norte
	const property nombreTick = "balaEnemigo" 
	
	method image(){
		return "Disparos/normal-" + orientacion.imagen()
	}
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	method aumentarDanio(cantidad){
		danio = danio + cantidad
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
	
	method ocasionarDanio(){
		game.removeTickEvent(self.nombreTick())
		game.uniqueCollider(self).recibirImpactoDe(self)		
	}
	
	method recibirImpactoDe(objeto){
		if (game.hasVisual(objeto)) {
			game.removeVisual(objeto)
		}
		if (game.hasVisual(self)) {
			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
		}
	}
	method esAtravezable(){
		return true
	}
}
