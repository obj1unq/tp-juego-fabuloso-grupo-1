import wollok.game.*
import enemigo.*
import base.*
import randomizer.*


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
		tanque.sumarVida(50)
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
		tanque.bala().aumentarDanio(10)
		game.removeVisual(self)
		
	}
}

object powerUpCuracionBase{
	const paredes = #{pared1,pared2,pared3,pared4,pared5,pared6,pared7,pared8}
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
		paredes.forEach({pared => pared.curarVida(20)})
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
		game.removeVisual(tanqueEnemigo)
		game.removeVisual(self)
	}
	
}
