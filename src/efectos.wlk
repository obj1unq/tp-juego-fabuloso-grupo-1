import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import bala.*
import managerpowerup.*
import paredes.*
import nivel.*


class AnimacionRecibirDisparo{
		var numeroAnimacion = 1
		var property disparoRecibidoDe= este
		var property nombreDeTick =""
		
		method image(){	
			return "efectos/recibirDisparoDel-" + numeroAnimacion + "-" + disparoRecibidoDe + ".png"
		}
		
		method esAtravezable(){
		return true
		}
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion ==3) {
				game.removeVisual(self)
				game.removeTickEvent(self.nombreDeTick())
//				numeroAnimacion = 1
				
			}
		}
		method siguienteAnimacion (){
			numeroAnimacion++
			self.destruirAnimacionAlTerminar()
		}
		method aplicar(){}
		method aplicar(algo){}
}

class AnimacionExplocionTanque{
	var numeroAnimacion = 1
		method esAtravezable(){	return true	}
		method image(){	 return "efectos/explosion-" + numeroAnimacion + ".png"	}
	
		
		method animar(unaCoordenada) {
			game.addVisualIn ( self, game.at(unaCoordenada.x(), unaCoordenada.y()))
			game.onTick(10, "destruccionTanque",{self.siguienteAnimacion()})
			self.destruirAnimacionAlTerminar()
		}
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion >= 5) {
				game.removeTickEvent("destruccionTanque")
				numeroAnimacion = 1
				game.removeVisual(self)
			}
		}
		method siguienteAnimacion (){
			numeroAnimacion++
			self.destruirAnimacionAlTerminar()
		}
		method aplicar(param1){}
		method aplicar(){}
}

class AnimacionTomarPowerUps{
	var numeroAnimacion = 1
		method esAtravezable(){	return true	}
		method image(){	 return "efectos/upgrade-" + numeroAnimacion + ".png"	}
	
		
		method animar(unaCoordenada) {
			game.addVisualIn ( self, game.at(unaCoordenada.x(), unaCoordenada.y()))
			game.onTick(50, "tomaPowerUps",{self.siguienteAnimacion()})
			self.destruirAnimacionAlTerminar()
		}
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion >= 3) {
				game.removeTickEvent("tomaPowerUps")
				numeroAnimacion = 1
				game.removeVisual(self)
			}
		}
		method siguienteAnimacion (){
			numeroAnimacion++
			self.destruirAnimacionAlTerminar()
		}
		method aplicar(param1){}
		method aplicar(){}
}

class BalaNivel4 {
	var numeroAnimacion = 1
	
		method animar(bala) {
			game.onTick(50, "animacionBala",{self.siguienteAnimacion()})
			return "Disparos/normal-" + bala.nivel()  +"-"+ numeroAnimacion + "-" + bala.orientacion().imagen()
		}
		
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion >= 3) {
				game.removeTickEvent("tomaPowerUps")
				numeroAnimacion = 1
				game.removeVisual(self)
			}
		}
		method siguienteAnimacion (){
			numeroAnimacion++
			self.destruirAnimacionAlTerminar()
		}
		method aplicar(param1){}
		method aplicar(){}
}

object animacionDisparo{
	var cantidadAnimacion = 1
	
	method crearAnimacion(posicion, orientacion){
		const unaAnimacion= new AnimacionRecibirDisparo()
		unaAnimacion.disparoRecibidoDe(orientacion)
		unaAnimacion.nombreDeTick("animacionDispario" + cantidadAnimacion.toString())
		game.addVisualIn(unaAnimacion, game.at(posicion.x(), posicion.y()))
		game.onTick(50, unaAnimacion.nombreDeTick(),{unaAnimacion.siguienteAnimacion()})
//		unaAnimacion.destruirAnimacionAlTerminar()
		cantidadAnimacion ++
	}
}