import wollok.game.*
import enemigo.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*

object base {
	var property nivel = 1
	var property vida = 500
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
	method esAtravezable(){
		return false
	}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
	
}

object pared1 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}

object pared2 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}
object pared3 {
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
}
object pared4{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}
object pared5{
	var property vida = 50
		method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
		method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}

object pared6{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
}
object pared7{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}
object pared8{
	var property vida = 50
	method image(){	return "Paredes/pared-" + base.nivel().toString() + ".png"}
	method esAtravezable(){
		return false
	}
	method curarVida(cantidad){
		vida = cantidad + vida
	}
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		game.removeVisual(unaBala)
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	method destruir(){
	game.removeVisual(self)
	}
}
