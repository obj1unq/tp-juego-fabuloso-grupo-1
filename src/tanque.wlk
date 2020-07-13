import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*
import efectos.*
import objetosParaHerencia.*

class TanqueBase inherits ObjetosQueCambiaSegunDanio{
	
	var property orientacion = randomizer.orientacionAleatoria()
	
	override method imagenNormal(){
		return self.nivel().toString() + "-" + orientacion.imagen().toString()
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) 
			{	 self.position(nuevaPosicion)
			}
		}
		
	method puedeMover(hacia){
		return 	 game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
					 and self.orientacion().puedeMover(hacia)
		}
		
	method disparar(){
		self.agregarEfectoDeimagen("disparo")
		managerBala.generarMovimientoDe(self.generarBala())

	}
	method generarBala(){
		return new BalaComun(position= self.position(), 
							orientacion= self.orientacion(),
							nivel= self.nivel())
	}
}


class Tanque inherits TanqueBase{

	override method  pathImagen(){
		return "Players/Tanque-"
	}
	
	override method destruir (){
		super()
		nivelManager.mapaFinal(gameOver)
	}
}