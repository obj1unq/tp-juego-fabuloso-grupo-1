import wollok.game.*
import enemigo.*
import base.*
import randomizer.*


object powerUpsBase{
	
	var property position = game.at(randomizer.emptyPosition().x(), randomizer.emptyPosition().y())	
    method  image (){ return "powerups/BaseUp.png" }
    
	 method aplicar(){
		game.removeVisual(self)
		base.subirNivel()
		
	}
}

object powerUpsAumentoDanio{
	const property tipo = "powerUp"
	var nivelDeDanio = 1
//	var property aplicableA= aliada
	var property position = game.at(randomizer.emptyPosition().x(),randomizer.emptyPosition().y())	
	 method  image (){ return "powerups/Shot1.png" }
	
	method aumentarDanio (unidad){
			nivelDeDanio= nivelDeDanio + 1
			unidad.danio(nivelDeDanio)
			game.removeVisual(self)
			game.say(unidad,"Subi Eneriga" + unidad.danio())}
	
}