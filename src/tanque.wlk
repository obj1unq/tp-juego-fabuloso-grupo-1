import wollok.game.*

object balaComun {
	const property danio = 20
	var property position = null
	
	method salirDisparadaHacia(orientacion){ 
		/*
		 * ver como hacer que la bala avance en la direccion indicada hasta que se tope con algo
		 */
	}
}

object balaPerforante {
	const property danio = 50
	var property position = null
	
	method salirDisparadaHacia(orientacion){
		/*
		 * ver como hacer que la bala avance en la direccion indicada hasta que se tope con algo
		 */ 
	}
}

object tanque{
	var property vida = 100
	var property position = game.at(5,5)
	var property orientacion = este
	/* norte - este - sur -  oeste */
	
	method move(nuevaPosicion, enSentido) {
		self.orientacion(enSentido)
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	
	method image(){
		
		return "Players/Tanque-2-" + orientacion.imagen()
	}
	
	
	
	
	method disparar(unaBala){
		unaBala.position(self.position())
		unaBala.salirDisparadaHacia(self.orientacion())
	}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
		/* ver como se ellmina el tanque */
	}
	
	method puedeMover(hacia){
		/* tenemos que ver si se puede mover en esa direccion
		 * puede ser que haya una pared u otro tanque o que
		 * es een el funal del tablero
		 * 
		 * POR HORA SIEMPRE TRUE
		 */
		return game.getObjectsIn(hacia).isEmpty()
	}
}

object tanqueEnemigo{
	var property vida = 100
	var property position = game.at(6,6)
	var property orientacion = sur
	/* norte - este - sur -  oeste */
	
	method move(nuevaPosicion, enSentido) {
		self.orientacion(enSentido)
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	method image(){
		
		return   "Players/Tanque-2-" + orientacion.imagen()
		
	}
	
		
	
	
	method disparar(unaBala){
		unaBala.position(self.position())
		unaBala.salirDisparadaHacia(self.orientacion()) // ver xd
	}
	
	method recibirImpactoDe(unaBala){
		vida -= unaBala.danio()
		self.destruirSiEstoySinVida()
	}
	method destruirSiEstoySinVida(){
		if (self.vida() <= 0){
			self.destruir()
		}
	}
	
	method destruir(){
		/* ver como se ellmina el tanque */
	}
	
	method puedeMover(hacia){
		/* tenemos que ver si se puede mover en esa direccion
		 * puede ser que haya una pared u otro tanque o que
		 * es een el funal del tablero
		 * 
		 * POR HORA SIEMPRE TRUE
		 */
		return game.getObjectsIn(hacia).isEmpty()
	}
}

object norte{
	method imagen(){
		return "Arriba.png"
	}
}
object este{
	method imagen(){
		return "Izquierda.png"
	}
}
object oeste{
	method imagen(){
		return "Derecha.png"
	}
}
object sur{
	method imagen(){
		return "Abajo.png"
	}
}



object pared1{
	var property position = game.at(3,3)
	method image(){
		return "Paredes/ParedGrande.png"
		
	}
}





