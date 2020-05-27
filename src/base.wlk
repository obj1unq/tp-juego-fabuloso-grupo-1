import wollok.game.*
import enemigo.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import paredes.*

object base {
	var property vida = 1
	var property position = game.at(game.center().x(),game.center().y() )
	var property nivel= 1
	var property paredesDeBase=#{}
	var property paredesCoordenadas
	
	method quitarPared(unaPared){
		paredesDeBase.remove(unaPared)
		game.removeVisual(unaPared)
		
	}	
	
	method image(){
		return "Bases/base.png"
	}
	method subirNivel(){
		if (nivel < 4 )
		{
			nivel= self.nivel() + 1
			paredesDeBase.forEach({unaPared=> unaPared.nivel(self.nivel())})
		}
	}
	
	method dibujarParedes (){
	   var coordenadasBaseX=  game.center().x()
	   var coordenadasBaseY= game.center().y()
	   paredesCoordenadas= [(coordenadasBaseX + 1 ),(coordenadasBaseY + 1),
	   									(coordenadasBaseX),(coordenadasBaseY + 1),
	   									(coordenadasBaseX - 1), (coordenadasBaseY + 1),
	   									(coordenadasBaseX- 1),(coordenadasBaseY),
	   									(coordenadasBaseX- 1),(coordenadasBaseY - 1),
	   									(coordenadasBaseX),(coordenadasBaseY - 1),
	   									(coordenadasBaseX + 1) ,(coordenadasBaseY- 1),
	   									(coordenadasBaseX + 1),(coordenadasBaseY)]			
	listaDeCoordenadas.construirParedesEn_(paredesCoordenadas)
	}

	method construirParedBaseEn(x,y) {
	var paredBase= new ParedBase(position= game.at(x,y) , nivel= self.nivel())
	game.addVisualIn(paredBase, game.at(x,y))
	paredesDeBase.add(paredBase)
	}
	
	method esAtravezable(){
		return false
	}
	
	method recibirImpactoDe(unaBala){
//		danioRecibidoTotal = danioRecibidoTotal  + unaBala.danio()
		vida -= unaBala.danio()
		self.destruirSiEstoySinVida()	
		}
		
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
	game.removeVisual(self)
	
	}
	
}