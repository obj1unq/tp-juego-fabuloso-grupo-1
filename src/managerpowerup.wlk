import wollok.game.*
import powerUps.*

object managerPowerUp {
	const property powerUps = [powerUpCuracion,powerUpBase,powerUpAumentoDanio,powerUpDestruccion,powerUpCuracionBase]
	var property powerUpActual = self.powerUps().anyOne()
	
	method agregarPower(powerRandom){
		if(powerRandom.estaActivo()){
			game.removeVisual(powerRandom)
			self.cambiarPower()
			
		}
		else{
			powerRandom.position(powerRandom.posicionNueva())
			game.addVisual(powerRandom)
			self.cambiarPower()
			
		}
		
		
	}
	method cambiarPower(){
		powerUpActual = self.powerUps().anyOne()
	}
	
	method powerRandom(){
		return powerUpActual
	}
	
	
}

