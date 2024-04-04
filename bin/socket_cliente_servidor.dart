import 'Cliente.dart';
import 'Servidor.dart';

void main(List<String> arguments) async {
  String user = arguments[1];
  String ip = arguments[0];
  int port = int.parse(arguments[2]);

  //iniciamos el servidor
  final server = Servidor();
  server.initServidor(ip, port);

  //iniciamos el cliente
  final cliente = Cliente();
  cliente.initCliente(ip, port, user);
}
