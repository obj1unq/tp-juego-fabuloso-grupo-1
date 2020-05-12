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
		self.position(nuevaPosicion)
	}
	
	method ocasionarDanio(){
		game.removeTickEvent("bala")
		game.uniqueCollider(self).recibirImpactoDe(self)		
	}
}

object balaPerforante {
	const property danio = 50
	var property position = null
	var property orientacion = norte 
	
	method image(){
		return "Players/BalaNorte.png"// + orientacion.imagen()
	}
	method salirDisparada(){ 
		self.orientacion().mover(self)
	}
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
}

object tanque{
	var property vida = 100
	var property position = game.at(5,5)
	var property orientacion = este
	var property bala = balaComun
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	
	method image(){
		return "Players/Tanque-2-" + orientacion.imagen()
	}
	
	method disparar(){
		balaComun.position(self.position())
		balaComun.orientacion(self.orientacion())
		game.addVisual(balaComun)
		balaComun.salirDisparada()
		game.onTick(500, "bala", {self.bala().salirDisparada()})
		game.whenCollideDo(self.bala(), { self.bala().ocasionarDanio() })
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
}

object tanqueEnemigo{
	var property vida = 100
	var property position = game.at(6,6)
	var property orientacion = sur
	var property bala = balaComun
	
	method move(nuevaPosicion) {
		if (self.puedeMover(nuevaPosicion)) {
			self.position(nuevaPosicion)
		}
	}
	method image(){
		return   "Players/Tanque-2-" + orientacion.imagen()
	}
	
	method disparar(){
		balaComun.position(self.position())
		balaComun.orientacion(self.orientacion())
		game.addVisual(balaComun)
		balaComun.salirDisparada()
		game.onTick(500, "bala2", {self.bala().salirDisparada()})
		game.whenCollideDo(self.bala(), { self.bala().ocasionarDanio() })
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





