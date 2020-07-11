import wollok.game.*

object wollokTanks{

	method cantidadDeObjetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel}).size()
	}
	
	method objetosDeNivel_(nivel){
		return game.allVisuals().filter({unObjeto=> unObjeto.nivel() == nivel})
	}

}