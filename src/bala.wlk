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
	var property nivel = 1
	
	method danio(){
	 return self.nivel() * 15	
	}
	method image(){
		return "Disparos/normal-" + self.nivel() +"-"+ orientacion.imagen()							
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
		if (!unObjeto.esAtravezable()){
			unObjeto.recibirImpactoDe(self)
			self.destruirObjecto()
			animacionDisparo.crearAnimacion(self.position(), self.orientacion())
		}
	}
	
	method destruirObjecto(){
		game.removeTickEvent(self.nombreTick())
		game.removeVisual(self) //arreglar aca
		managerBala.balasGeneradas().remove(self)
		}
		
	method esAtravezable(){
		return true
	}
	method aplicar(){}
	method aplicar(parametro){}
}


object managerBala{
	var numeroDeBala=1
	var property balasGeneradas=#{}
		method generarBalaDisparadaPor(objeto){
		const balaNueva= new BalaComun	(	position = objeto.position(), 
											orientacion= objeto.orientacion(),
											nivel= objeto.nivel() )
			balaNueva.nombreTick("balaN°" + numeroDeBala.toString())
//			game.addVisual(balaNueva)
			
			game.onTick(100,balaNueva.nombreTick(), { balaNueva.salirDisparada() })
			balaNueva.salirDisparada()
			game.addVisual(balaNueva)
			game.whenCollideDo(balaNueva, { elemento => balaNueva.ocasionarDanioSiCorresponde(elemento)})
		 	numeroDeBala ++	
		 	balasGeneradas.add(balaNueva)
		 }
}