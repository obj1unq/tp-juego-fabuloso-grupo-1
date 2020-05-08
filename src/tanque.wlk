/*
 * aca esta modelado el tanque y la bala
 * 
 * lo que puede hacer el tanque es:
 * muve --> se mueve con una direccion mientras no tenga obtaculo o est en el borde del tablero
 * disparar --> dispara algun tipo de bala en la direccion hacia donde esta orientado
 * recibirImpactoDe --> recibe el impato de una bala que le baja la "vida" si la vida llega a cero se destruye
 * 
 * para la bala se espera que haga:
 * salirDisparadaHacia --> se dispara en una direccion si en su camino se topa con un objeto le hace daño
 */


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
	var property orientacion = "este" 
	/* norte - este - sur -  oeste */
	
	method move(nuevaPosicion, enSentido) {
		self.orientacion(enSentido)
		if (self.puedeMover(enSentido)) {
			self.position(nuevaPosicion)
		}
	}
	
	method disparar(unaBala){
		unaBala.position(self.position())
		unaBala.salirDisparadaHacia(tanque.orientacion())
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
		return true
	}
	
	
}