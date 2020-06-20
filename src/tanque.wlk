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
		
	method tomarPowerUps(powerUp)
		{	powerUp.aplicar(self)
		}
	override method image()
		{	return   "Players/Tanque-" + self.nivel() + "-" + orientacion.imagen()
		}
}