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


object normalizadorDeImagenes{
	const colaNormalizadoraDeimagenes=#{}

	
	method agregarAColar(unaVisual){
		colaNormalizadoraDeimagenes.add(unaVisual)
	}
	
	method normalizarImagen(){
		if (not colaNormalizadoraDeimagenes.isEmpty()){
			colaNormalizadoraDeimagenes.forEach({unaVisual=> unaVisual.normalizarImagen()})
		}
	}

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
				numeroAnimacion = null
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


object barraDeVida{
	var property position = game.at(0,18)
	const porcentaje = 10
	method image()
		{ 
		return ("efectos/vida-" + self.redondeDeDanio().toString()  + ".png")
		}

	method porcetajeDanioRecibido()
		{
			return ((nivelManager.jugador().vidaRestante() * 100 / 
					(nivelManager.jugador().danioRecibido() + 
						nivelManager.jugador().vidaRestante())
			) / porcentaje)
		}
		
		method redondeDeDanio(){
			return self.porcetajeDanioRecibido().roundUp()
		}
		method mostrar(){
			game.addVisual(self)
		}					
	}
object  enemigosFaltantes {
	var property position = game.at(12,18)
	method image()
		{ 
		return ("efectos/enemigosFaltantes-" + nivelManager.nivel().enemigosParaPasar() + "-muerte-" + nivelManager.enemigosMuertos() + ".png")
		}
		
}
class NumeroScore{
	
	method image(){	return ("assets/puntaje/"+self.numeroMostrado()+ ".png") }
 	method numeroMostrado (){
 		return(nivelManager.puntajeComoTexto().charAt(self.posicionATomar()))
 	}
 	method posicionATomar() //abstracto
}

object decenasDeMil inherits NumeroScore {
	var property position =  game.at(3,19) 
	override method posicionATomar (){return 0} 
}

object unidadesDeMil inherits NumeroScore{
	var property position = game.at(4,19)
	override method posicionATomar (){return 1} 						
}

object centenas inherits NumeroScore {
	var property position = game.at(5,19)
	override method posicionATomar (){return 2} 
}

object decenas inherits NumeroScore{
	var property position = game.at(6,19)
	override method posicionATomar (){return 3} 
	}

object unidades inherits NumeroScore{
	var property position = game.at(7,19)
	override method posicionATomar (){return 4} 
}

object imagenDeNivel {
	var property position = game.at(game.center().x() -1 ,18)
	method image(){	return ("assets/Fondos/"+ nivelManager.nombreDelNivel()+ ".png")}
}

object score {
	var property position = game.at(0,19)
	
	method mostrar(){
		game.addVisual(imagenDeNivel)
	    game.addVisual(enemigosFaltantes)
		game.addVisual(score)
		game.addVisual(decenasDeMil)
	 	game.addVisual(unidadesDeMil)
	 	game.addVisual(centenas)
	 	game.addVisual(decenas)
	 	game.addVisual(unidades)
	}
	
	method image(){ return ("assets/puntaje/score.png")	}
}