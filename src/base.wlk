import wollok.game.*
import enemigo.*
import base.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*

object base {
	var property nivel = 1
	var property position = game.at(game.center().x(),game.center().y() )
	method image(){
		return "Bases/base.png"
	}
	
	method subirNivel(){
		if (nivel < 4 ) {
		nivel= self.nivel() + 1
		self.actualizarVistas()
		}
	}
	
	method actualizarVistas(){
		self.removerParedes()
		self.dibujarParedes()
	
	}
	
	method removerParedes(){
		game.removeVisual(pared1)
		game.removeVisual(pared2)
		game.removeVisual(pared3)
		game.removeVisual(pared4)
		game.removeVisual(pared5)
		game.removeVisual(pared6)
		game.removeVisual(pared7)
		game.removeVisual(pared8)
	}
	
	method dibujarParedes (){
	    game.addVisualIn(pared1, game.at(self.position().x() + 1 ,self.position().y() + 1))
		game.addVisualIn(pared2, game.at(self.position().x(),self.position().y() + 1))
		game.addVisualIn(pared3, game.at(self.position().x() - 1, self.position().y() + 1))
		game.addVisualIn(pared4, game.at(self.position().x() - 1,self.position().y()))
		game.addVisualIn(pared5, game.at(self.position().x() - 1,self.position().y() - 1))
		game.addVisualIn(pared6, game.at(self.position().x(),self.position().y() - 1))
		game.addVisualIn(pared7, game.at(self.position().x() + 1 ,self.position().y() - 1))
		game.addVisualIn(pared8, game.at(self.position().x() + 1,self.position().y()))
		
	}
	
}

object pared1 {
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}

object pared2 {
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}
object pared3 {
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}
object pared4{
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}
object pared5{
		method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}

object pared6{
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}
object pared7{
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}
object pared8{
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
}