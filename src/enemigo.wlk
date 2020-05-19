import wollok.game.*
import tanque.*
import orientaciones.*
import bala.*
import base.*
import randomizer.*

/* manager de tanques enemigos */
object tanqueEnemigoManagwer{
	const property tanques = []
	const tankOnTickSpeed = 500
	var target = base    // la base o el tanque
	var targetAux = base // la base o el tanque 
	var orientacion = norte
	var property maxTanques = 0
	var numeroDeTanque = 1
	var imagen = "Enemigos/tanqueEnemigo-"
	
	method target(atacar){
		target = base
		targetAux = atacar
	}
	method target(){
		if ( target.equals(base) ) {
			target = targetAux
		} else {
			target = base
		}
		return target
	} 
	
	method orientacion(){
		orientacion = orientacion.siguienteOrientacion()
		return orientacion
	}
	
	method crearTanque(){
		const tank = new Tanque()
		
		tank.position(randomizer.emptyPosition())
		tank.orientacion(self.orientacion())
		tank.bala(balaEnemigo)
		tank.imagen(imagen)
		tank.target(self.target())
		tank.nombreTick("tanqueEnemigo" + numeroDeTanque.toString() )
		self.tanques().add(tank)
		game.addVisual(tank)
		game.onTick(tankOnTickSpeed, tank.nombreTick(), {tank.ataque()})
		game.say(tank, "Moriras !!")
		numeroDeTanque ++		
	}
	
	method start(){
		if (self.tanques().size() < self.maxTanques()) {
			self.crearTanque()
		}
		self.tanques().removeAllSuchThat( {tank => not game.hasVisual(tank)} )
	}
	
}