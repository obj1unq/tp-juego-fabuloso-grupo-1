import wollok.game.*
import base.*
import bala.*
import enemigo.*
import tanque.*
import orientaciones.*
import efectos.*

class Pared inherits ObjetosQueCambiaSegunDanio{
	
	override method  pathImagen(){
		return "Paredes/pared-"
	}
	
	method nombreDeImagenSegunDanio(){
	if (self.porcetajeDanioRecibido() > 50 && self.porcetajeDanioRecibido() <= 100) 
											 { return 100}  // danio entre 50 y 100%
	 if (self.porcetajeDanioRecibido()  > 10 &&  self.porcetajeDanioRecibido() <= 50)
			   								{ return 50}  // danio entre 10 y 50%
			   else { return 10} }// danio entre 0 y 10%
	
	 method porcetajeDanioRecibido(){
		return ( self.vida() * 100 / (self.danioRecibido() + self.vida() )  )
	}
	
	override method imagenNormal(){
		return self.nivel().toString() + "-" + self.nombreDeImagenSegunDanio() + ".png"
	}
}


// objeto que dibuja las paredes segun una lista.. Esto creo que esta en el nivel Manager, 
//Aunque hay que revisarlo
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

