import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect("ws://192.168.1.33:3000");

  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Homework 8'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: StreamBuilder(
                    stream: widget.channel.stream,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText:
                                    "Hesaplamak istediğin işlemi yaz ( 2+2 ) ?",
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            controller: _controller,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                            child: Text(
                              snapshot.hasData ? '${snapshot.data}' : '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          )
                        ],
                      );
                    })),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send),
          onPressed: sendData,
        ),
      );

  void sendData() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    } else {
      _controller.text = "Lütfen bir yanıt yazınız";
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}


/*


/* 



*/ 
 */ 