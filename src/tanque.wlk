import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*
import efectos.*

class TanqueBase{
	var vida = 100
	var property position = null
	var property orientacion = null
	var property nivel = 1
	var property target = null
	var property danioRecibido=0
	var adicionalesAImagen= ""
	const pathImagen= "Players/Tanque-"
	
	method move(nuevaPosicion) 
		{	if (self.puedeMover(nuevaPosicion)) 
			{	 self.position(nuevaPosicion)
			}
		}
		
	method sumarVida(cantidad)
		{	danioRecibido = (self.danioRecibido() - cantidad).max(0)
		}
	
	method vida()
		{	return vida - self.danioRecibido()
		}
	
	method disparar(){
		self.cambiarImagenRealizarDisparo()
		managerBala.generarBalaDisparadaPor(self)
	}
	
	method recibirImpactoDe(unaBala)
		{	danioRecibido = danioRecibido + unaBala.danio()
			self.cambiarAImagenRecibirDisparo()
			self.destruirSiEstoySinVida()
		}
		
	method destruirSiEstoySinVida()
		{	if (self.vida() <= 0)
			{	self.destruir()
			}
		}
	
	method destruir()
		{	game.removeVisual(self)
		}
	
	method puedeMover(hacia)
		{	return 	 game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
					 and self.orientacion().puedeMover(hacia)
		}
				 
	method esAtravezable()
		{	return false
		}
		
	// Cambio de imagenes Segun corresponda
	
	method cambiarAImagenRecibirDisparo(){
			self.adicionalesAImagen("danio")
			normalizadorDeImagenes.agregarAColar(self)
	}
	method cambiarImagenRealizarDisparo(){
		self.adicionalesAImagen("disparo")
			normalizadorDeImagenes.agregarAColar(self)
	}
	
	method normalizarImagen(){
		self.adicionalesAImagen("")
	}
	
	method imagenNormal(){
		return self.nivel().toString() + "-" + orientacion.imagen().toString()
	}
	method adicionalesAImagen(){
		return adicionalesAImagen
	}
	method adicionalesAImagen(efecto){
		adicionalesAImagen= efecto.toString()
	}
	method imagenCompleta(){
		return pathImagen + self.adicionalesAImagen() + self.imagenNormal()
	}
	method image()	{
			return   self.imagenCompleta()
	}
			
}

class Tanque inherits TanqueBase{
	const pathImagen= "Players/Tanque-"
	override method destruir (){
		super()
		nivelManager.mapaGameOver()
	}
	method subirNivel() {
		if (nivel < 4 ){
			nivel= self.nivel() + 1
			vida = vida + 100 
			self.danioRecibido(0)
		}
	}
	
	method tomarPowerUps(powerUp){
			powerUp.aplicar(self)
		}
}