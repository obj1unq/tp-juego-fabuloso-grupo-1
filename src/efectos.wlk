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
		var disparoRecibidoDe= este
		
		method image(){	
			return "efectos/recibirDisparoDel-" + numeroAnimacion + "-" + disparoRecibidoDe + ".png"
		}
		
		method esAtravezable(){
		return true
		}
		
		method animar(unaCoordenada, orientacionBala) {
   			disparoRecibidoDe = orientacionBala
			game.addVisualIn ( self, game.at(unaCoordenada.x(), unaCoordenada.y()))
			game.onTick(50, "AnimacionRecibirImpacto",{self.siguienteAnimacion()})
			self.destruirAnimacionAlTerminar()
		}
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion == 3) {
				game.removeTickEvent("AnimacionRecibirImpacto")
				numeroAnimacion = null
				game.removeVisual(self)
			}
		}
		method siguienteAnimacion (){
			numeroAnimacion++
			self.destruirAnimacionAlTerminar()
		}
		method aplicar(param1){}
}

object animacionExplocionTanque{
	var numeroAnimacion = 1
		var disparoRecibidoDe= este
		
		method image(){	
			return "efectos/recibirDisparoDel-" + numeroAnimacion + "-" + disparoRecibidoDe + ".png"
		}
	
		method esAtravezable(){
		return true
		}
		method animar(unaCoordenada, orientacionBala) {
   			disparoRecibidoDe = orientacionBala
			game.addVisualIn ( self, game.at(unaCoordenada.x(), unaCoordenada.y()))
			game.onTick(50, "destruccionTanque",{self.siguienteAnimacion()})
			self.destruirAnimacionAlTerminar()
		}
		method destruirAnimacionAlTerminar(){
			if (numeroAnimacion == 3) {
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
	
}