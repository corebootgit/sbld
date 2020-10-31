import 'package:flutter/material.dart';
import 'package:sbld/tcpip.dart';

import 'sqlite.dart';
import 'devices.dart';

Device mydevice = Device(id: 1, ipAddress: "192.168.0.45");
double _currentSliderValue = 50;
String bright = '50';
bool _switchValue = false;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Yeelight',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Yeelight'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      //tcpSend('192.168.0.45', 55443, '{ "id": 1, "method": "set_power", "params":["on", "smooth", 500]}\r\n');
      tcpSend('${mydevice.ipAddress}', 55443,
          '{"id":${mydevice.id},"method":"toggle","params":[]}\r\n');
      // tcpSend('${mydevice.ipAddress}', 55443, '{"id":${mydevice.id},"method":"set_bright","params":[$bright, "smooth", 500]}\r\n');
      //sqliteTest();

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Container(
        width: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(20.0) ),
          child: Drawer(
            child: DrawerHeader(
              duration: Duration(milliseconds: 1000),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton (
                    child: Text('Options'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OptionsRoute()),
                      );
                    },
                  ),
                  ElevatedButton (
                    child: Text('Exit'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
             // decoration: BoxDecoration(
            //    color: Colors.blue,
           //   ),
            ),
          ),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
              value: _currentSliderValue,
              min: 1,
              max: 100,
              // divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  bright = _currentSliderValue.toInt().toString();
                });
              },
              onChangeEnd: (double value) {
                tcpSend('${mydevice.ipAddress}', 55443,
                    '{"id":${mydevice.id},"method":"set_bright","params":[$bright, "smooth", 500]}\r\n');
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('${mydevice.ipAddress}'),
            Switch(
              value: _switchValue,
              onChanged: (bool value) {
                setState(() {
                  _switchValue = value;
                });

                if(value){
                  tcpSend('${mydevice.ipAddress}', 55443,
                      '{"id":${mydevice.id},"method":"set_power","params":["on", "smooth", 500]}\r\n');
                }
                else {
                  tcpSend('${mydevice.ipAddress}', 55443,
                      '{"id":${mydevice.id},"method":"set_power","params":["off", "smooth", 500]}\r\n');
                }
              },

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.lightbulb),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OptionsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}