import wollok.game.*

object randomizer {
	var property ramdomName=#{}
	method emptyPosition(){
		const positionRandom = game.at(
			0.randomUpTo(game.width() - 1 ).truncate(0),
			0.randomUpTo(game.height() - 3).truncate(0)  // -1 por implementacion y -2 por el menu
		)
		
		if(game.getObjectsIn(positionRandom).isEmpty()){
			return positionRandom
		}
		else{
			return self.emptyPosition()
		}
		}
	
	method randomName (){
		const numeroAleatorio = 0.randomUpTo(10000).roundUp().toString()
		if (ramdomName.contains(numeroAleatorio)) {
			return self.randomName()
		}else {
				ramdomName.add(numeroAleatorio)
				return numeroAleatorio	}
		}
		
		method liberarNombre(nombre){
			ramdomName.remove(nombre)
		}	
}

