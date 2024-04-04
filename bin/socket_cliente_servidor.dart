import 'dart:io';
import 'dart:typed_data';

void main(List<String> arguments) async {
  String user = arguments[1];
  String ip = arguments[0];
  int port = 3616;
  ServerSocket server;
  Socket cliente;
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
