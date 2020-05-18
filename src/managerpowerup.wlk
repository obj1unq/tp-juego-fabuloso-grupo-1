import wollok.game.*
import powerUps.*

object managerPowerUp {
	const property powerUps = #{powerUpCuracion,powerUpBase,powerUpAumentoDanio,powerUpDestruccion,powerUpCuracionBase}
	
	method agregarPower(powerRandom){
		if(powerRandom.estaActivo()){
			
		}
		else{
			game.addVisual(powerRandom)
		}
		
	}
	
	
}

