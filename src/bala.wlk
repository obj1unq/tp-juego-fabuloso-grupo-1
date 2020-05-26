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
	var property nivel= 1
	
	method subirNivel(){
		if (nivel < 4 )
		{  nivel= self.nivel() +1
			self.aumentarDanio(50)
		}
	}
	
	method image(){
		return "Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()
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
	method aplicar(){}
}


object balaEnemigo {
	var property danio = 20
	var property position = null
	var property orientacion = norte
	const property nombreTick = "balaEnemigo" 
	var property nivel= 1
	
	method subirNivel(){
	}
	
	method image(){
		return "Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()
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
	method aplicar(){}
}
