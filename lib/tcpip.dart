import 'dart:io';
import 'dart:convert';

void tcpSend(String ipAddress, int port, String data) async {
  Socket socket = await Socket.connect(ipAddress, port);
  print('connected\n');

  // listen to the received data event stream
  socket.listen((List<int> event) {
    print(utf8.decode(event));
  });
  // send hello
  socket.add(utf8.encode(data + '\n'));
  print('sent -> ' + data + '\n');
  // wait 5 seconds
  //await Future.delayed(Duration(seconds: 5));

  // .. and close the socket
  socket.close();
  print('closed\n');
}