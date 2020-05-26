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
	
	
//	var coordenasDeParedes = [(self.position().x() + 1 , self.position().y() + 1),
//							(self.position().x(),	self.position().y() + 1),
//							,(self.position().x() - 1, self.position().y() + 1)
//							,(self.position().x() - 1,self.position().y())
//							,(self.position().x() - 1,self.position().y() - 1)
//							,(self.position().x(),self.position().y() - 1)
//							,(self.position().x() + 1 ,self.position().y() - 1)
//							,(self.position().x() + 1,self.position().y())]
	
	method image(){
		return "Bases/base.png"
	}
	method subirNivel(){
		if (nivel < 4 ) {
		nivel= self.nivel() + 1
		self.actualizarVistas()
		}
	}
	
	method actualizarVistas(){
		self.removerParedes()
		self.dibujarParedes()
	}
	
	method removerParedes(){
		game.removeVisual(pared1)
		game.removeVisual(pared2)
		game.removeVisual(pared3)
		game.removeVisual(pared4)
		game.removeVisual(pared5)
		game.removeVisual(pared6)
		game.removeVisual(pared7)
		game.removeVisual(pared8)
	}
	
	method dibujarParedes (){
	   var coordenadasBaseX=  game.center().x()
	   var coordenadasBaseY= game.center().y()
	   var coordenadasAlrededorDeBase= [(coordenadasBaseX + 1 ),(coordenadasBaseY + 1),
	   									(coordenadasBaseX),(coordenadasBaseY + 1),
	   									(coordenadasBaseX - 1), (coordenadasBaseY + 1),
	   									(coordenadasBaseX- 1),(coordenadasBaseY),
	   									(coordenadasBaseX- 1),(coordenadasBaseY - 1),
	   									(coordenadasBaseX),(coordenadasBaseY - 1),
	   									(coordenadasBaseX + 1) ,(coordenadasBaseY- 1),
	   									(coordenadasBaseX + 1),(coordenadasBaseY)]
//	 coordenadasAlrededorDeBase.({coorX,coorY => self.construirParedBaseEn(coorX, coorY)})				
	listaDeCoordenadas.coordenadasDeADos(coordenadasAlrededorDeBase)
	}
	
	
	
	method construirParedBaseEn(x,y) {
	var paredBase= new ParedBase()
	game.addVisualIn(paredBase, game.at(x,y))}
	
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

object pared1 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}

object pared2 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}
object pared3 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method aplicar(x){
		
	}
}
object pared4{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}
object pared5{
	var property vida = 50
		method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
		method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}

object pared6{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method aplicar(x){
		
	}
}
object pared7{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}
object pared8{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
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
	method aplicar(x){
		
	}
}


// ########lista de coordenadas.coordenadaDeADos(lista) construye paredes a parte de una lista de coordenadas#####

object listaDeCoordenadas {
	var property numero
	var property inicio=0
	var property fin
	var actual = 0
	
	method coordenadasDeADos_hacer(lista){
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
		}
	}
    method arreglarLista(){
    	numero.add(null)
    }
    
    method finEsImpar (){
    	return fin%2 != 0
    }
}