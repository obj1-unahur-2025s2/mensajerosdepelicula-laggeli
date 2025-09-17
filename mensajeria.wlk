import mensajeros.*
import destinos.*

object mensajeria {
    const paquetesEnviados = []
    const paquetesPendientes = []
    const mensajeros = []
    method mensajeros() = mensajeros
    method contratarMensajero(unMensajero) { self.mensajeros().add(unMensajero) }
    method despedirMensajero(unMensajero) { self.mensajeros().remove(unMensajero) }
    method despedirATodos() { mensajeros.clear() }
    method tamañoDeMensajería() = self.mensajeros().size()
    method paquetesEnviados() = paquetesEnviados
    method paquetesPendientes() = paquetesPendientes
    method algunoPuedeEntregar(paquete, destino) = mensajeros.any {mensajero => paquete.puedeSerEntregado(mensajero, destino)}
    method mensajerosQuePuedenEntregar(unPaquete, unDestino) = mensajeros.filter {mensajero => unPaquete.puedeSerEntregado(mensajero, unDestino)}
    method tieneSobrepeso() = not self.mensajeros().isEmpty() && (self.mensajeros().map { mensajero => mensajero.peso() }.sum() / self.mensajeros().size()) > 500
    method facturación() = self.paquetesEnviados().map {paquetes => paquetes.precio()}.sum()
    method paquetePendienteMasCaro() = paquetesPendientes.max{ paquete => paquete.precio() }
    method enviarPaquete(unPaquete, unDestino) {
        if (not self.mensajerosQuePuedenEntregar(unPaquete, unDestino).isEmpty()) {
            self.paquetesEnviados().add(unPaquete)
            self.paquetesPendientes().remove(unPaquete)
        } 
        else { self.paquetesPendientes().add(unPaquete) }
    }
    method enviarMuchosPaquetes(conjuntoPaquetes, unDestino) {
        if (conjuntoPaquetes.all { unPaquete => not self.mensajerosQuePuedenEntregar(unPaquete, unDestino).isEmpty() }) {
            self.paquetesEnviados().addAll(conjuntoPaquetes)
            self.paquetesPendientes().removeAll(conjuntoPaquetes)
        }
        else { self.paquetesPendientes().addAll(conjuntoPaquetes)}
    }
    method enviarPaquetePendienteMásCaro(unDestino) {
        if (not self.paquetesPendientes().isEmpty()) {
            self.enviarPaquete(self.paquetePendienteMasCaro(), unDestino)
        }
    }
    method agregarUnPaqueteAPendiente(unPaquete) {
        paquetesPendientes.add(unPaquete)
    }
}

object paquete {
    var montoPagado = 0
    method precio() = 50
    method estáPago() = montoPagado >= self.precio()
    method pagar(unMonto) { 
        montoPagado = montoPagado + unMonto
    }
    method puedeSerEntregado(unMensajero, unDestino) = self.estáPago() and unMensajero.puedeLlegar(unDestino)
}

object paquetito {
    method estáPago() = true
    method precio() = 0
    method puedeSerEntregado(unMensajero, unDestino) = self.estáPago()
}

object paquetónViajero {
    var montoPagado = 0
    const destinos = []
    method destinos() = destinos
    method pagar(unMonto) { 
        montoPagado = montoPagado + unMonto
    }
    method estáPago() = montoPagado >= self.precio()
    method añadirDestino(unDestino) {
        self.destinos().add(unDestino)
    }
    method precio() = 100 * destinos.size()
    method puedeSerEntregado(unMensajero, unDestino) = self.estáPago() and destinos.all {destino => unMensajero.puedeLlegar(destino)}
}

object paquetin {
    var montoPagado = 0
    method precio() = 5
    method estáPago() = montoPagado >= self.precio()
    method pagar(unMonto) { 
        montoPagado = montoPagado + unMonto
    }
    method puedeSerEntregado(unMensajero, unDestino) = self.estáPago()
}