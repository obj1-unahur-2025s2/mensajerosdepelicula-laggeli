object roberto {
    var vehículo = bici
    method peso() = 90 + vehículo.peso()
    method puedeLlamar() = false
    method puedeLlegar(unDestino) = unDestino.puedePasar(self)
    method cambiarVehículo(unVehículo) {
        vehículo = unVehículo
    }
}

object bici {
    method peso() = 5
}

object camión {
    var cantAcoplados = 1
    method peso() = 500 * cantAcoplados
    method cambiarAcoplados(unaCantidad) {
        cantAcoplados = unaCantidad
    }
}

object chuckNorris {
    method peso() = 80
    method puedeLlamar() = true
    method puedeLlegar(unDestino) = unDestino.puedePasar(self)
}

object neo {
    var tieneCrédito = true
    method peso() = 0
    method puedeLlamar() = tieneCrédito
    method cambiarCrédito(tieneONo) {
        tieneCrédito = tieneONo
    }
    method puedeLlegar(unDestino) = unDestino.puedePasar(self)
}

object trinity {
    method peso() = 50
    method puedeLlamar() = true
    method puedeLlegar(unDestino) = unDestino.puedePasar(self)
}