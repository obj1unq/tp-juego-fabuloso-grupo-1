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
//	var balasPropias=#{}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) { self.position(nuevaPosicion)}}
		
	method sumarVida(cantidad){
		vida = vida + cantidad
	}
	
	method imagen(path){
		imagen = path}
		
	method image(){
		return   imagen + self.nivel() + "-" + orientacion.imagen()	}
		
	method disparar(){
		var bala = new BalaComun()
		bala.generarBala(self)}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		self.destruirSiEstoySinVida()}
	
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
			game.removeVisual(self)
			nivelManager.finalizarNivel()
	}
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).all({cosa => cosa.esAtravezable()})
				 and self.orientacion().puedeMover(hacia)}
				 
	method esAtravezable(){
		return false
	}
	
	method tomarPowerUps(powerUp){
		powerUp.aplicar(self)
	}	
	
	method subirNivel() {
		if (nivel < 4 )
		{  nivel= self.nivel() + 1
		}}
}