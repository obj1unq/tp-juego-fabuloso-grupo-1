import wollok.game.*
import base.*
import managerpowerup.*
import nivel.*
import efectos.*
import orientaciones.*

object wollokTankConfig {

	method InicializarJuego(){
		self.configuracionVentanaGame()
		self.inicializarPrimerNivel()
		self.configurarControles()
		score.mostrarMenuSuperior()
		managerPowerUp.inicializarPowersUps()
		game.onTick (1000, "imagenNormal",{normalizadorDeImagenes.normalizarImagen()})
	}
	
	method configurarControles(){
		keyboard.space().onPressDo { nivelManager.jugador().disparar() }
		keyboard.up().onPressDo { norte.mover(nivelManager.jugador()) }
		keyboard.down().onPressDo { sur.mover(nivelManager.jugador()) }
		keyboard.left().onPressDo { oeste.mover(nivelManager.jugador()) }
		keyboard.right().onPressDo { este.mover(nivelManager.jugador()) }
	}
	
	method inicializarPrimerNivel(){
		nivelManager.nivel(new Nivel1())
    	nivelManager.base(base)
    	nivelManager.crearJugador1()
		nivelManager.incializarMapa()
	}
	
	method configuracionVentanaGame(){
		game.title("Wollok Tanks")
		game.height(20)
		game.width(20)
		game.cellSize(41)
		game.boardGround("Fondos/Fondo-1.png")
	}
}
	