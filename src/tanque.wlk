import wollok.game.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import bala.*
import nivel.*
import enemigo.*
import efectos.*

class Tanque{
	var property vida = 100
	var property position = null
	var property orientacion = null
	var property nivel = 1
	var property target = null
	var imagen = "Players/Tanque-"
	var balasDisparadas=#{}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) { self.position(nuevaPosicion)}}
	method sumarVida(cantidad){
		vida = vida + cantidad
	}
	method imagen(path){
		imagen = path
	}
	method image(){
		return   imagen + self.nivel() + "-" + orientacion.imagen()
	}
	method disparar(){
		var balaNueva= new BalaComun(position = self.position(), 
									orientacion= self.orientacion(),
									nivel= self.nivel() )
			balaNueva.nombreTick(randomizer.randomName())
			game.addVisual(balaNueva)
			balaNueva.salirDisparada()
			game.onTick(100,balaNueva.nombreTick(), { balaNueva.salirDisparada() })
			game.whenCollideDo(balaNueva, { elemento => balaNueva.ocasionarDanio() })
		}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		randomizer.liberarNombre(unaBala.nombreTick())
		self.destruirSiEstoySinVida()
		animacionRecibirDisparo.animar(self.position(), unaBala.orientacion())
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
//			game.removeTickEvent(self.nombreTick())
			game.removeVisual(self)
			nivelManager.finalizarNivel()
	}
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
				 and self.orientacion().puedeMover(hacia)
	}
	method esAtravezable(){
		return false
	}
	method tomarPowerUps(powerUp){
		powerUp.aplicar(self)
	}	
	method subirNivel() {
		if (nivel < 4 )
		{  nivel= self.nivel() + 1
			self.bala().subirNivel()
		}}
}