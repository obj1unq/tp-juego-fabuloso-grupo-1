import wollok.game.*
import enemigo.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import paredes.*
import nivel.*

object base inherits ObjectosQueRecibenDanio {
	var property paredesDeBase=#{}
	var property paredesCoordenadas
	override method position (){
		return game.at(game.center().x(),game.center().y() )
	}
	override method vida(){ return 1}
	
	method image(){
		return "Bases/base.png"
	}
	
	override method subirNivel(){
		if (self.nivel() < 4 )
		{	nivel= self.nivel() + 1
			paredesDeBase.forEach({unaPared=> unaPared.subirNivel()})
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
	method ubicarBase(){
		game.addVisual(self)
		self.dibujarParedes()
	}

	method construirParedBaseEn(x,y) {
	var paredBase= new Pared(position= game.at(x,y))
	game.addVisual(paredBase)
	paredesDeBase.add(paredBase)
	paredBase.configurarColisiones()
	}
	
	override method destruir(){
	super()
	nivelManager.mapaGameOver()
	}
	
}