import wollok.game.*
import enemigo.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import paredes.*
import nivel.*

object base inherits ObjetoConVisualesEnElJuego {
	var property paredesDeBase=#{}
	var property paredesCoordenadas
	override method position (){
		return game.at(game.center().x(),game.center().y() )
	}
	
	override method vida(){ return 1}
	override method image(){
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

	method construirParedBaseEn(x,y) {
	var paredBase= new Pared(position= game.at(x,y))
	game.addVisual(paredBase)
	paredesDeBase.add(paredBase)
	}
	
	override method destruir(){
	super()
	nivelManager.mapaGameOver()
	}
	
	override method pathImagen(){}
	override method normalizarImagen(){}
	override method imagenNormal(){return ""}
	override method adicionalesAImagen(){return ""}
	override method adicionalesAImagen(efecto){}
	override method imagenCompleta(){return ""}
	
}