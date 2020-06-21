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
	method image()
	
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
	
	method disparar()
		{	managerBala.generarBalaDisparadaPor(self)
		}
	
	method recibirImpactoDe(unaBala)
		{	danioRecibido = danioRecibido + unaBala.danio()
			nivelManager.jugador().adicionalesAImagen("danio")
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
}

class Tanque inherits TanqueBase{
	const pathImagen= "Players/Tanque-"
	var adicionalesAImagen= ""
	override method destruir ()
		{	super()
			nivelManager.mapaGameOver()
		}
	method subirNivel()
		 {	if (nivel < 4 )	
		 	{	nivel= self.nivel() + 1
				vida = vida + 100 
				self.danioRecibido(0)
			}
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
	
	override method image()	{
			return   self.imagenCompleta()
	}
		
	method tomarPowerUps(powerUp){
			powerUp.aplicar(self)
		}
}