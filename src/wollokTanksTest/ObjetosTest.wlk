import wollok.game.*
import enemigo.*
import base.*
//import nivel.*
object wollokTanks{
	method cantidadDeObjetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel}).size()
	}
	
	method objetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel})
	}
	
	method baseConParedNivel(nivel){
		return base.paredesDeBase().all({unaPared => unaPared.nivel() == nivel})
	}
	
	method baseTodasParedesConDanio(unNumero){
		return base.paredesDeBase().all({unaPared => unaPared.danioRecibido() == unNumero})	
	}
	method cualquierParedDeLaBase(){
		return base.paredesDeBase().anyOne()
	}
	method crear3tanqueEnemigo(){
		tanqueEnemigoManager.crearTanque()
		tanqueEnemigoManager.crearTanque()
		tanqueEnemigoManager.crearTanque()
	}

}

object tanqueConPocavida inherits TanqueBase{
	override method vida(){
		return 1
	}
	
}

object balaConMuchoDanio inherits BalaComun{
	override method danio(){
		return 101
	}
}