import wollok.game.*

object balaComun {
	const property danio = 20
	var property position = null
	var property orientacion = norte 
	
	method image(){
		return "Players/BalaNorte.png"// + orientacion.imagen()
	}
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			game.removeTickEvent("bala")
			game.removeVisual(self)
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
	
	method ocasionarDanio(){
		game.removeTickEvent("bala")
		game.uniqueCollider(self).recibirImpactoDe(self)		
	}
}

object balaComunEnemigo {
	const property danio = 20
	var property position = null
	var property orientacion = norte 
	
	method image(){
		return "Players/BalaNorte.png"// + orientacion.imagen()
	}
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		} else {
			game.removeTickEvent("balaEnemigo")
			game.removeVisual(self)
		}
	}
	
	method puedeMover(hacia){
		return self.orientacion().puedeMover(hacia)
	}
	
	method ocasionarDanio(){
		game.removeTickEvent("balaEnemigo")
		game.uniqueCollider(self).recibirImpactoDe(self)		
	}
}

object tanque{
	var property vida = 100
	var property position = game.at(5,5)
	var property orientacion = este
	var property bala = balaComun
	var modoAutomatico = false
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	
	method image(){
		return "Players/Tanque-2-" + orientacion.imagen()
	}
	
	method disparar(){
		if (not game.hasVisual(self.bala()) ) {
			self.bala().position(self.position())
			self.bala().orientacion(self.orientacion())
			game.addVisual(self.bala())
			self.bala().salirDisparada()
			game.onTick(500, "bala", { self.bala().salirDisparada() })
			game.whenCollideDo(self.bala(), { self.bala().ocasionarDanio() })
		}
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
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).isEmpty() and self.orientacion().puedeMover(hacia)
	}
	
	method ataque(enemigo){
		self.dispararSiPuede(enemigo)
		self.perseguir(enemigo)
	}
	method autoAtaque(){
		if ( not modoAutomatico){
			modoAutomatico = true
			game.onTick(1000, "tanque", {self.ataque(tanqueEnemigo)})
		} else {
			modoAutomatico = false
			game.removeTickEvent("tanque")
		}
	}
	
	method estoyAlineadoCon(enemigo){
		 return self.estoyAlinadoEnX(enemigo) or self.estoyAlinadoEnY(enemigo)
	}
	
	method estoyAlinadoEnX(enemigo){
		return   enemigo.position().y() == self.position().y() and
				(   enemigo.position().x() < self.position().x() and self.orientacion() == (oeste) 
				 or enemigo.position().x() > self.position().x() and self.orientacion() == (este))
	}
	
	method estoyAlinadoEnY(enemigo){
		return   enemigo.position().x() == self.position().x() and
				(   enemigo.position().y() < self.position().y() and self.orientacion() == (sur) 
				 or enemigo.position().y() > self.position().y() and self.orientacion() == (norte))
	}
	
	method dispararSiPuede(enemigo){
		if (self.estoyAlineadoCon(enemigo)) {
			self.disparar()
		}
	}
	
	method perseguir(enemigo){
		if (enemigo.position().y() > self.position().y()) {
			self.orientacion(norte)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().y() < self.position().y()) {
			self.orientacion(sur)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().x() > self.position().x()) {
			self.orientacion(este)
			self.orientacion().mover(self)
		}
		else {
			self.orientacion(oeste)
			self.orientacion().mover(self)
		}
	}
}

object tanqueEnemigo{
	var property vida = 100
	var property position = game.at(6,6)
	var property orientacion = norte
	var property bala = balaComunEnemigo
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	method image(){
		return   "Players/Tanque-2-" + orientacion.imagen()
	}
	
	method disparar(){
		if (not game.hasVisual(self.bala()) ) {
			self.bala().position(self.position())
			self.bala().orientacion(self.orientacion())
			game.addVisual(self.bala())
			self.bala().salirDisparada()
			game.onTick(500, "balaEnemigo", { self.bala().salirDisparada() })
			game.whenCollideDo(self.bala(), { self.bala().ocasionarDanio() })
		}
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
	
	method puedeMover(hacia){
		return game.getObjectsIn(hacia).isEmpty() and self.orientacion().puedeMover(hacia)
	}
	
	method ataque(enemigo){
		self.dispararSiPuede(enemigo)
		self.perseguir(enemigo)
	}
	
	method estoyAlineadoCon(enemigo){
		 return self.estoyAlinadoEnX(enemigo) or self.estoyAlinadoEnY(enemigo)
	}
	
	method estoyAlinadoEnX(enemigo){
		return   enemigo.position().y() == self.position().y() and
				(   enemigo.position().x() < self.position().x() and self.orientacion() == (oeste) 
				 or enemigo.position().x() > self.position().x() and self.orientacion() == (este))
	}
	
	method estoyAlinadoEnY(enemigo){
		return   enemigo.position().x() == self.position().x() and
				(   enemigo.position().y() < self.position().y() and self.orientacion() == (sur) 
				 or enemigo.position().y() > self.position().y() and self.orientacion() == (norte))
	}
	
	method dispararSiPuede(enemigo){
		if (self.estoyAlineadoCon(enemigo)) {
			self.disparar()
		}
	}
	
	method perseguir(enemigo){
		if (enemigo.position().y() > self.position().y()) {
			self.orientacion(norte)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().y() < self.position().y()) {
			self.orientacion(sur)
			self.orientacion().mover(self)
		} 
		else if (enemigo.position().x() > self.position().x()) {
			self.orientacion(este)
			self.orientacion().mover(self)
		}
		else {
			self.orientacion(oeste)
			self.orientacion().mover(self)
		}
	}
	
	
}


/*
 * Orientaciones
 */
object norte{
	method imagen(){
		return "Arriba.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().up(1))
	}
	method puedeMover(hacia){
		return game.height() > hacia.y() 
	}
}
object este{
	method imagen(){
		return "Izquierda.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().right(1))
	}
	method puedeMover(hacia){
		return game.width() > hacia.x() 
	}
}
object oeste{
	method imagen(){
		return "Derecha.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().left(1))
	}
	method puedeMover(hacia){
		return hacia.x() >= 0 
	}
}
object sur{
	method imagen(){
		return "Abajo.png"
	}
	method mover(objeto){
		objeto.orientacion(self)
		objeto.move(objeto.position().down(1))
	}
	method puedeMover(hacia){
		return hacia.y() >= 0 
	}
}



object pared1{
	var property position = game.at(3,3)
	method image(){
		return "Paredes/ParedGrande.png"
		
	}
	method recibirImpactoDe(unaBala){
		game.removeVisual(unaBala)
	}
}





