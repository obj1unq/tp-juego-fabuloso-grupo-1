import wollok.game.*
import enemigo.*
import orientaciones.*
import powerUps.*
import randomizer.*
import tanque.*
import paredes.*
import nivel.*

object base inherits ObjectosQueRecibenDanio {
	var property paredesDeBase=#{}
	
	method paredesBaseCoordenadas(){	
			return	[	[(game.center().x() + 1 ),	(game.center().y() +1 )	],
	   					[(game.center().x()     ),	(game.center().y() +1 )	],
	   					[(game.center().x() -1  ), 	(game.center().y() +1 )	],
	   					[(game.center().x() -1  ),	(game.center().y()    )	],
	   					[(game.center().x() -1  ),	(game.center().y() -1 )	],
	   					[(game.center().x()     ),	(game.center().y() -1 )	],
	   					[(game.center().x()  +1 ),	(game.center().y() -1 )	],
	   					[(game.center().x()  +1 ),	(game.center().y()    )	]	]					
	   }				
	override method position (){
		return game.at(game.center().x(),game.center().y() )
	}
	override method vida(){ return 1}
	
	method image(){
		return "Bases/base.png"
	}
	
	override method subirNivel(){
		if (self.nivel() < 4 ){
			nivel= self.nivel() + 1
			self.paredesDeBase().forEach({unaParedDeBase=>unaParedDeBase.subirNivel()})
		}
	}
	
	method dibujarParedes (){
	   nivelManager.dibujarParedesPorLista(self.paredesBaseCoordenadas())
	}
	method ubicarBase(){
		game.addVisual(self)
		self.dibujarParedes()
		self.configurarColisiones()
	}

	method construirParedBaseEn(x,y) {
	var paredBase= new Pared(position= game.at(x,y))
	game.addVisual(paredBase)
	paredesDeBase.add(paredBase)
	paredBase.configurarColisiones()
	}
	
	override method destruir(){
	super()
	nivelManager.mapaFinal(gameOver)
	}
	
}