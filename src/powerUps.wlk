import wollok.game.*
import enemigo.*
import base.*
import randomizer.*
import paredes.*
import efectos.*

object powerUpCuracion{
	var property position = self.posicionNueva()
	method posicionNueva(){
		return randomizer.emptyPosition()
	}
	
	method image(){
		return "powerups/BaseHeal.png"
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
		tanque.sumarVida(50)
		game.say(tanque,"Me siento mas saludable!!")
		game.removeVisual(self)
	}
}


object powerUpBase{
	
	var property position = self.posicionNueva()
	method posicionNueva(){
		return randomizer.emptyPosition()
	}
	
    method  image (){
    	return "powerups/BaseUp.png"
    }
    
	 method aplicar(tanque){
	 	var animacion = new AnimacionTomarPowerUps()
	 	animacion.animar(self.position())
		base.subirNivel()
		game.removeVisual(self)
		
		
	}
	method esAtravezable(){
		return true
	}
	method estaActivo(){
		return game.hasVisual(self)
	}
}


  object powerUpAumentoDanio{
  	var property position = self.posicionNueva()
	method posicionNueva(){
		return randomizer.emptyPosition()
	}
	
  	method image(){
  		return "powerups/Shot1.png"
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
		tanque.subirNivel()
		game.removeVisual(self)
	}
}

object powerUpCuracionBase{
	const paredes = base.paredesDeBase()
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
	
	method image(){
		return "powerups/Doble.png"
	}
	
	method aplicar(tanque){
		var animacion = new AnimacionTomarPowerUps()
	 	animacion.animar(self.position())
		paredes.forEach({pared => pared.curarVida(20)})
		game.say(base, "Paredes Curadas!!")
		game.removeVisual(self)
	}
}


object powerUpDestruccion{
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
	
	method image(){
		return "powerups/Shot3.png" // le puse cualquier imagen
	}
	
	method aplicar(tanque){
		if(not tanqueEnemigoManagwer.tanques().isEmpty()){
			tanqueEnemigoManagwer.destruirTodos()
		}
		var animacion = new AnimacionTomarPowerUps()
	 	animacion.animar(self.position())
		game.removeVisual(self)}
		
}

