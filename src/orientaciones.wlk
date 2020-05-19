import wollok.game.*
import tanque.*



object norte{
	method imagen(){
		return "norte.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().up(1))
	}
	method puedeMover(hacia){
		return game.height() > hacia.y() 
	}
	method siguienteOrientacion(){
		return este
	}
}
object este{
	method imagen(){
		return "este.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().right(1))
	}
	method puedeMover(hacia){
		return game.width() > hacia.x() 
	}
	method siguienteOrientacion(){
		return sur
	}
}
object oeste{
	method imagen(){
		return "oeste.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().left(1))
	}
	method puedeMover(hacia){
		return hacia.x() >= 0 
	}
	method siguienteOrientacion(){
		return norte
	}
}
object sur{
	method imagen(){
		return "sur.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().down(1))
	}
	method puedeMover(hacia){
		return hacia.y() >= 0 
	}
	method siguienteOrientacion(){
		return oeste
	}
}