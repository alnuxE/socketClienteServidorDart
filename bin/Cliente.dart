import 'dart:io';
import 'dart:typed_data';

class Cliente {
  void initCliente(String ip, int port, String user) async {
    Socket cliente;
    try {
      cliente = await Socket.connect(ip, port);
    } catch (e) {
      print(e);
      return;
    }

    cliente.listen((servidor) {
      servidorResponse(servidor as Socket);
    });

    while (true) {
      String? a = stdin.readLineSync();
      await sendMessage(cliente, a, user);
    }
  }
}

void servidorResponse(Socket servidor) async {
  servidor.listen((Uint8List data) async {
    final mensaje = String.fromCharCodes(data);
    print(mensaje);
  }, onError: (e) {
    print(e);
    servidor.close();
  }, onDone: () {
    print('cliente desconectado');
    servidor.close();
  });
}

Future<void> sendMessage(Socket socket, String? message, String user) async {
  print('$user: $message');
  socket.write('$user: $message');
  await Future.delayed(Duration(seconds: 2));
}
