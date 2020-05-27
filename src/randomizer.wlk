import wollok.game.*

object randomizer {
	var property ramdomName=#{}
	method emptyPosition(){
		const positionRandom = game.at(
			0.randomUpTo(game.width() - 1 ).truncate(0),
			0.randomUpTo(game.height() - 1 ).truncate(0) 
		)
		
		if(game.getObjectsIn(positionRandom).isEmpty()){
			return positionRandom
		}
		else{
			return self.emptyPosition()
		}
	}
	
	method randomName (){
		const numeroAleatorio = 0.randomUpTo(10000).toString()
		if (ramdomName.contains(numeroAleatorio)) {
			self.randomName()
		}else {
				ramdomName.add(numeroAleatorio)
				return numeroAleatorio	}
		}
		
		method liberarNombre(nombre){
			ramdomName.remove(nombre)
		}	
}

