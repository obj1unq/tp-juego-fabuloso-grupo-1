import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*
import efectos.*

class ObjectosQueRecibenDanio{
	
	var property position = null
	var property nivel = 1
	var property danioRecibido = 0
	var adicionalesAImagen= ""
	
	method vida(){ return 100 + ((self.nivel()-1) *100) } //+100 vida por nivel que sube
	
	method reducirDanioRecibido(cantidad){	
		danioRecibido = (self.danioRecibido() - cantidad).max(0)
	}
	
	method configurarColisiones(){
		game.whenCollideDo(self,{elemento => self.aplicarEfectoDeObjeto(elemento)})
	}
	
	method vidaRestante(){
			return self.vida() - self.danioRecibido()
		}

	method subirNivel() {
		if (nivel < 4 ){
			nivel= self.nivel() + 1
			self.danioRecibido(0)
		}
	}
	method aplicarEfectoDeObjeto(unObjeto){
			unObjeto.aplicar(self)
	}
	
	method recibirDanio(unaBala){
		self.danioRecibido(self.danioRecibido() + unaBala.danio())
		self.destruirSiEstoySinVida()
	}		

		
	method destruirSiEstoySinVida(){
		if (self.vidaRestante() <= 0){
				self.destruir()
			}
		}
	
	method destruir()
		{	game.removeVisual(self)
		}
				 
	method esAtravezable()
		{	return false
		}
}

class ObjetosQueCambiaSegunDanio inherits  ObjectosQueRecibenDanio{

	method pathImagen()
	
	method agregarEfectoDeimagen(efecto){
		self.adicionalesAImagen(efecto)
		normalizadorDeImagenes.agregarAColar(self)
	}
	
	method normalizarImagen(){
		self.adicionalesAImagen("")
	}
		
	override method recibirDanio(unaBala){
		super(unaBala)
		self.agregarEfectoDeimagen("danio")
	}
	
	method imagenNormal(){
		return self.nivel().toString() + "-"
	}
	
	method adicionalesAImagen(){
		return adicionalesAImagen
	}
	method adicionalesAImagen(efecto){
		adicionalesAImagen= efecto.toString()
	}
	
	method imagenCompleta(){
		return self.pathImagen() + self.adicionalesAImagen() + self.imagenNormal()
	}
	
	method image()	{
		return self.imagenCompleta()
	}
}

class TanqueBase inherits ObjetosQueCambiaSegunDanio{
	
	var property orientacion = randomizer.orientacionAleatoria()
	
	override method imagenNormal(){
		return self.nivel().toString() + "-" + orientacion.imagen().toString()
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) 
			{	 self.position(nuevaPosicion)
			}
		}
		
	method puedeMover(hacia){
		return 	 game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
					 and self.orientacion().puedeMover(hacia)
		}
		
	method disparar(){
		self.agregarEfectoDeimagen("disparo")
		managerBala.generarMovimientoDe(self.generarBala())

	}
	method generarBala(){
		return new BalaComun(position= self.position(), 
							orientacion= self.orientacion(),
							nivel= self.nivel())
	}
}


class Tanque inherits TanqueBase{

	override method  pathImagen(){
		return "Players/Tanque-"
	}
	
	override method destruir (){
		super()
		nivelManager.mapaFinal(gameOver)
	}
}