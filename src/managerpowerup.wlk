import wollok.game.*
import powerUps.*
import nivel.*

object managerPowerUp {
	const property powerUps = [powerUpCuracion,powerUpBase,powerUpAumentoDanio,powerUpDestruccion,powerUpCuracionBase]
	
	method inicializarPowersUps(){
		game.onTick(8000, "managerPowerUp", { managerPowerUp.agregarPower(managerPowerUp.powerRandom()) })
		
//		game.whenCollideDo(nivelManager.jugador(), {unPowerUps => nivelManager.jugador().tomarPowerUps(unPowerUps)})
//		game.whenCollideDo(tanquePlayer, {powerUps => tanquePlayer.tomarPowerUps(powerUps)})	
	}
	
	method agregarPower(powerRandom){
		if(powerRandom.estaActivo()){
			game.removeVisual(powerRandom)
		}
		else{
			powerRandom.position(powerRandom.posicionNueva())
			game.addVisual(powerRandom)
		}
	}
	
	method powerRandom(){
		return self.powerUps().anyOne()
	}
}

