import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import efectos.* 


class BalaComun {
	var property position = null
	var property orientacion = norte 
	var property nombreTick="bala"
	var property nivel= 1
	
	method danio(){
	 return self.nivel() * 15	
	}
	method image(){
		return if ( nivel < 4 ) {"Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()}
								else {self.disparoNivel4(self)}
	}
	
	method disparoNivel4 (bala){
		var animacion = new BalaNivel4()
		return animacion.animar(bala)
	}
	
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			self.destruirObjecto()
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
	
	method ocasionarDanioSiCorresponde(unObjeto){
		var animacion=  new AnimacionRecibirDisparo()
		if (!unObjeto.esAtravezable()){
				unObjeto.recibirImpactoDe(self)
				self.destruirObjecto()
				animacion.animar(self.position(), self.orientacion())
		}
	}
	method destruirObjecto(){
		game.removeTickEvent(self.nombreTick())
//		randomizer.liberarNombre(self.nombreTick())
		game.removeVisual(self)
	}
	
	method generarBala(objeto){
		var balaNueva= new BalaComun(position = objeto.position(), 
									orientacion= objeto.orientacion(),
									nivel= objeto.nivel() )
			balaNueva.nombreTick(self.nombreTick())
			balaNueva.salirDisparada()
			game.addVisual(balaNueva)
			game.onTick(100,balaNueva.nombreTick(), { balaNueva.salirDisparada() })
			game.whenCollideDo(balaNueva, { elemento => balaNueva.ocasionarDanioSiCorresponde(elemento) })
	}
	method esAtravezable(){
		return true
	}
	method aplicar(){}
	method aplicar(parametro){}
}




//object balaEnemigo {
//	var property danio = 20
//	var property position = null
//	var property orientacion = norte
//	const property nombreTick = "balaEnemigo" 
//	var property nivel= 1
//	
//	method subirNivel(){
//	}
//	
//	method image(){
//		return "Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()
//	}
//	method salirDisparada(){ 
//		self.orientacion().mover(self)
//	}
//	method aumentarDanio(cantidad){
//		danio = danio + cantidad
//	}
//	
//	method move(nuevaPosicion) {
//		if (self.puedeMover(nuevaPosicion)) {
//			self.position(nuevaPosicion)
//		} else {
//			game.removeTickEvent(self.nombreTick())
//			game.removeVisual(self)
//		}
//	}
//	
//	method puedeMover(hacia){
//		return self.orientacion().puedeMover(hacia)
//	}
//	
//	method ocasionarDanio(){
//		game.removeTickEvent(self.nombreTick())
//		game.uniqueCollider(self).recibirImpactoDe(self)		
//	}
//	
//	method recibirImpactoDe(objeto){
//		if (game.hasVisual(objeto)) {
//			game.removeVisual(objeto)
//		}
//		if (game.hasVisual(self)) {
//			game.removeTickEvent(self.nombreTick())
//			game.removeVisual(self)
//		}
//	}
//	method esAtravezable(){
//		return true
//	}
//	method aplicar(){}
//}
