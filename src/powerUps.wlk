import wollok.game.*
import enemigo.*
import base.*
import randomizer.*
import paredes.*
import efectos.*

class PowerUp{
	var property position = self.posicionNueva()
	method posicionNueva(){
		return randomizer.emptyPosition()
	}
	
	method esAtravezable(){
		return true
	}
	
	method estaActivo(){
		return game.hasVisual(self)
	}
	
	method aplicar(tanque){
		var animacion = new AnimacionTomarPowerUps()
	 	animacion.animar(self.position())
	 	game.removeVisual(self)
	}
	
}
object powerUpCuracion inherits PowerUp{ 
	method image(){
		return "powerups/BaseHeal.png"
	}
	
	override method aplicar(tanque){
		super(tanque)
		tanque.reducirDanioRecibido(50)
		game.say(tanque,"Me siento mas saludable!!")
	}
}


object powerUpBase inherits PowerUp{	
    method  image (){
    	return "powerups/BaseUp.png"
    }
 
	override method aplicar(tanque){
	 	super(tanque)
		base.subirNivel()
	}
	
}

  object powerUpAumentoDanio inherits PowerUp{
  	method image(){
  		return "powerups/Shot1.png"
  	}
	override method aplicar(tanque){
		super(tanque)
		tanque.subirNivel()
	}
}

object powerUpCuracionBase inherits PowerUp{
	const paredes = base.paredesDeBase()
	method image(){
		return "powerups/Doble.png"
	}
	
	override method aplicar(tanque){
		super(tanque)
		paredes.forEach({pared => pared.reducirDanioRecibido(20)})
		game.say(base, "Paredes Curadas!!")
	}
}


object powerUpDestruccion inherits PowerUp{
	method image(){
		return "powerups/Shot3.png" // le puse cualquier imagen
	}
	override method aplicar(tanque){
		super(tanque)
		if(not tanqueEnemigoManagwer.tanques().isEmpty()){
			tanqueEnemigoManagwer.destruirTodos()
		}	
	}

}

