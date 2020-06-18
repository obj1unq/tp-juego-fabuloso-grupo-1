import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import efectos.*

class Pared{
	var vida = 200
	var property nivel = 1
	var property danioRecibidoTotal = 0
	var property position

	method vida(){
		return vida - self.danioRecibidoTotal()	}
		
	method image(){	return "Paredes/pared-" + self.nivel() + "-" + self.nombreDeImagenSegunDanio() + ".png"	}
	
	method nombreDeImagenSegunDanio(){
	if (self.porcetajeDanioRecibido() > 50 && self.porcetajeDanioRecibido() <= 100) 
											 { return 100}  // danio entre 50 y 100%
	 if (self.porcetajeDanioRecibido()  > 10 &&  self.porcetajeDanioRecibido() <= 50)
			   								{ return 50}  // danio entre 10 y 50%
			   else { return 10} }// danio entre 0 y 10%
	
	 method porcetajeDanioRecibido(){
		return ( self.vida() * 100 / (danioRecibidoTotal + self.vida() )  )
	}
	
	method esAtravezable(){
		return false
	}
	
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	
	method recibirImpactoDe(unaBala){
		danioRecibidoTotal = danioRecibidoTotal  + unaBala.danio()
		self.destruirSiEstoySinVida()
	}
	
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()}
	}
	
	method destruir(){
		game.removeVisual(self)
	}
	
	method agregarParedEn(coordenadaX,coordenadaY){
		return new Pared (position= game.at(coordenadaX ,coordenadaY ))
	}
	method aplicar(x){
		
	}
}

class ParedBase{
	var vida  = 300
	var property nivel
	var property danioRecibidoTotal = 0
	var property position
	
	method vida(){
		return vida - self.danioRecibidoTotal()
	}

	method image(){	return "Paredes/pared-" + self.nivel() + "-" + self.nombreDeImagenSegunDanio() + ".png"	}
	
	method nombreDeImagenSegunDanio(){
		if (self.porcetajeDanioRecibido() > 50 && self.porcetajeDanioRecibido() <= 100) 
											 { return 100}  // danio entre 50 y 100%
	 if (self.porcetajeDanioRecibido()  > 10 &&  self.porcetajeDanioRecibido() <= 50)
			   								{ return 50}  // danio entre 10 y 50%
			   else { return 10} }// danio entre 0 y 10%
	 method porcetajeDanioRecibido(){
		return ( self.vida() * 100 / (danioRecibidoTotal + self.vida() )  )
	}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		danioRecibidoTotal = danioRecibidoTotal  + unaBala.danio()
		self.destruirSiEstoySinVida()	}
	
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()}
	}
	method subirNivel(){
		nivel= self.nivel() + 1 
		vida = vida + 100
	}
	
	method destruir(){
		base.quitarPared(self)
	}
}

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
			self.error("falta una coordenada")
		}
		if  (actual < fin) {
			base.construirParedBaseEn(numero.get(actual),numero.get(actual+1))
			actual= actual + 2
			self.deAPares(lista)
		}else { actual= 0}
	}
	
    method finEsImpar (){
    	return fin%2 != 0
    }
}

