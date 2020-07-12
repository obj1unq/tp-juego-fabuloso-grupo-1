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
	override method aplicarEfectoDeObjeto(unObjeto){
		super(unObjeto)	
	}
}

