import wollok.game.*
import base.*
import managerpowerup.*
import nivel.*
import efectos.*
import orientaciones.*

object wollokTankConfig {

	method inicializarJuego(){
		self.configuracionVentanaGame()
		nivelManager.inicializarNivel(nivel1)
		nivelManager.crearJugador1()
		self.configurarControles()
		self.VisualesMenuSuperior()
		
		game.addVisual(nivelManager.jugador())
		managerPowerUp.inicializarPowersUps()

		nivelManager.jugador().configurarColisiones()
		game.onTick (1000, "imagenNormal",{normalizadorDeImagenes.normalizarImagen()})
	}
	
	method VisualesMenuSuperior(){
		barraDeVida.mostrar()
		score.mostrar()
	}
	
	method configurarControles(){
		keyboard.space().onPressDo { nivelManager.jugador().disparar() }
		keyboard.up().onPressDo { norte.mover(nivelManager.jugador()) }
		keyboard.down().onPressDo { sur.mover(nivelManager.jugador()) }
		keyboard.left().onPressDo { oeste.mover(nivelManager.jugador()) }
		keyboard.right().onPressDo { este.mover(nivelManager.jugador()) }
	}
	
	method crearJugardor(){
		nivelManager.crearJugador1()
		game.whenCollideDo(nivelManager.jugador(),{elemento => nivelManager.jugador().recibirImpactoDe(elemento)})
	}
	
	method configuracionVentanaGame(){
		game.title("Wollok Tanks")
		game.height(20)
		game.width(20)
		game.cellSize(41)
		game.boardGround("Fondos/Fondo-1.png")
	}
	
	method ubicacionSalidaPlayer(){
		nivelManager.jugador().position(game.at(base.position().x() -2,base.position().y())) 
	}
}
	