import 'dart:io';
import 'dart:typed_data';

class Servidor {
  void initServidor(String ip, int port) async {
    late ServerSocket server;
    try {
      server = await ServerSocket.bind(ip, port);
      print('Servidor iniciado en $ip:$port');
    } catch (e) {
      print(e);
      return;
    }

    server.listen((cliente) {
      clienteConnect(cliente);
    });
  }
}

void clienteConnect(Socket cliente) {
  cliente.listen((Uint8List data) {
    final mensaje = String.fromCharCodes(data);
    print(mensaje);
  }, onError: (e) {
    print(e);
    cliente.close();
  }, onDone: () {
    print('cliente desconectado');
    cliente.close();
  });
}
