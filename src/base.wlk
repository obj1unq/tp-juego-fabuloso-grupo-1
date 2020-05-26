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
//	 coordenadasAlrededorDeBase.({coorX,coorY => self.construirParedBaseEn(coorX, coorY)})				
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
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
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

// ########lista de coordenadas.coordenadaDeADos(lista) construye paredes a parte de una lista de coordenadas#####

object listaDeCoordenadas {
	var property numero
	var property inicio=0
	var property fin
	var actual = 0
	
	method construirParedesEn_(lista){
		self.asignarLista(lista)
		fin= lista.size()
		self.deAPares(lista)
	}
	
	method asignarLista (lista){
		numero = lista
	}
	
	method deAPares(lista){
		if (self.finEsImpar()) {
			self.arreglarLista()
		}
		if  (actual < fin) {
			base.construirParedBaseEn(numero.get(actual),numero.get(actual+1))
			actual= actual + 2
			self.deAPares(lista)
		}else { actual= 0}
	}
	
    method arreglarLista(){
    	numero.add(null)
    }

    method finEsImpar (){
    	return fin%2 != 0
    }
}