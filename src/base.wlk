import wollok.game.*

object base {
	var property position = game.at(10,15)
	method image(){
		return "Bases/base.png"
	}
	
	method dibujarParedes (){
		game.addVisualIn(pared1, game.at(11,16))
		game.addVisualIn(pared2, game.at(10,16))
		game.addVisualIn(pared3, game.at(9,16))
		game.addVisualIn(pared4, game.at(9,15))
		game.addVisualIn(pared5, game.at(9,14))
		game.addVisualIn(pared6, game.at(10,14))
		game.addVisualIn(pared7, game.at(11,14))
		game.addVisualIn(pared8, game.at(11,15))
		
	}
	
}

object pared1 {
	method image(){	return "Bases/pared-norte-este.png"}
}

object pared2 {
	method image(){	return "Bases/pared-norte.png"}
}
object pared3 {
	method image(){	return "Bases/pared-norte-oeste.png"}
}
object pared4{
	method image(){	return "Bases/pared-oeste.png"}
}
object pared5{
	method image(){	return "Bases/pared-sur-oeste.png"}
}

object pared6{
	method image(){	return "Bases/pared-sur.png"}
}
object pared7{
	method image(){	return "Bases/pared-sur-este.png"}
}
object pared8{
	method image(){	return "Bases/pared-este.png"}
}