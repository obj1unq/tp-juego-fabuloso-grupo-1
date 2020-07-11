import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*
import efectos.*

class ObjetoConVisualesEnElJuego {

	var property position = null
	var property nivel = 1
	var property danioRecibido = 0
	var adicionalesAImagen= ""
	
	method vida(){ return 100 + ((self.nivel()-1) *100) }
	
	method pathImagen() //EJ: "Paredes/pared-"
	
	method reducirDanioRecibido(cantidad)
		{	danioRecibido = (self.danioRecibido() - cantidad).max(0)
		}
	
	method vidaRestante()
		{	return self.vida() - self.danioRecibido()
		}

	method subirNivel() {
		if (nivel < 4 ){
			nivel= self.nivel() + 1
			self.danioRecibido(0)
		}
	}
			
	method recibirImpactoDe(unaBala)
		{	self.danioRecibido(self.danioRecibido() + unaBala.danio())
			self.agregarEfectoDeimagen("danio")
			self.destruirSiEstoySinVida()
		}
		
	method destruirSiEstoySinVida()
		{	if (self.vidaRestante() <= 0)
			{	self.destruir()
			}
		}
	
	method destruir()
		{	game.removeVisual(self)
		}
				 
	method esAtravezable()
		{	return false
		}
	
		
	// Cambio de imagenes Segun corresponda
	
	method agregarEfectoDeimagen(efecto){
		self.adicionalesAImagen(efecto)
		normalizadorDeImagenes.agregarAColar(self)
	}
	
	method normalizarImagen(){
		self.adicionalesAImagen("")
	}
	
	method imagenNormal(){
		return self.nivel().toString() + "-"
	}
	
	method adicionalesAImagen(){
		return adicionalesAImagen
	}
	method adicionalesAImagen(efecto){
		adicionalesAImagen= efecto.toString()
	}
	
	method imagenCompleta(){
		return self.pathImagen() + self.adicionalesAImagen() + self.imagenNormal()
	}
	
	method image()	{
		return self.imagenCompleta()
	}
}

class TanqueBase inherits ObjetoConVisualesEnElJuego{
	var property orientacion = null
	var property target = null
	
	override method imagenNormal(){
		return self.nivel().toString() + "-" + orientacion.imagen().toString()
	}
	
	method move(nuevaPosicion) 
		{	if (self.puedeMover(nuevaPosicion)) 
			{	 self.position(nuevaPosicion)
			}
		}
		
	method puedeMover(hacia)
		{	return 	 game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
					 and self.orientacion().puedeMover(hacia)
		}
	method disparar(){
		self.agregarEfectoDeimagen("disparo")
		managerBala.generarBalaDisparadaPor(self)
	}
}


class Tanque inherits TanqueBase{
	
	override method  pathImagen(){
		return "Players/Tanque-"
	}
	
	override method destruir (){
		super()
		nivelManager.mapaGameOver()
	}
	
	method tomarPowerUps(powerUp){
			powerUp.aplicar(self)
		}
}