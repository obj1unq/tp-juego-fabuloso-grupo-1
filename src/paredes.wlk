import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*

class Pared{
	var property vida = 500
	var property nivel = 1
	var danioRecibidoTotal = 0
	var property position

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
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
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
	var property vida = 500
	var property nivel
	var danioRecibidoTotal = 0
	var property position

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
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()}
	}
	
	method destruir(){
		game.removeVisual(self)
	}
}

