import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import efectos.* 


class BalaComun {
	var property position = null
	var property orientacion = norte 
	var property nombreTick="bala"
	var property nivel = 1
	
	method danio(){
	 return self.nivel() * 15	
	}
	
	method image(){
		return "Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()							
	}
		
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			managerBala.borrarBala(self)
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
		
	method esAtravezable(){
		return true
	}
	
	method causaDanio(){
		return true
	}
	
	method aplicar(){}
	
	method aplicar(unTanque){
			managerBala.borrarBala(self)
			unTanque.recibirDanio(self)
	}
}


object managerBala{
	var property balasGeneradas=#{}
	var nombreDeTick=""
	
	method borrarTodasLasBalas(){
		self.balasGeneradas().forEach({unaBala=>game.removeVisual(unaBala)})
		self.balasGeneradas().clear()
	}
	method borrarBala(unaBala){
		if (game.hasVisual(unaBala)){
			game.removeVisual(unaBala) //arreglar aca
			self.balasGeneradas().remove(unaBala)
		}
	}
	
	method generaMovimientoSinoExiste(){
		if (nombreDeTick == ""){
		game.onTick(500, "moverBalas", {self.sihayBalasMover()})
		nombreDeTick = "moverBalas"
		}
	}
	method moverBalas(){
		balasGeneradas.forEach({unaBala=> unaBala.salirDisparada()})
	}
	
	method sihayBalasMover(){
		 if (not balasGeneradas.isEmpty())
		 {
		 	self.moverBalas()
		 }else{
		   game.removeTickEvent("moverBalas") 
		   nombreDeTick = ""	
	 	}
	}
	method generarMovimientoDe(unaBala){
	 	self.generaMovimientoSinoExiste()
	 	unaBala.salirDisparada()
	 	game.addVisual(unaBala)
	 	balasGeneradas.add(unaBala)
	}
}