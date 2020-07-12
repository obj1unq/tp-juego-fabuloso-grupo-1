import wollok.game.*
import enemigo.*
object wollokTanks{

	method cantidadDeObjetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel}).size()
	}
	
	method objetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel})
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