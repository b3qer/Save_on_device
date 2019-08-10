import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  TextEditingController txt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Save On device'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: txt,
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      writeData(txt.text);
                      debugPrint('Saved');
                    },
                  ),
                  FutureBuilder(
                      future: readData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<String> data) {
                        if (data.hasData != null)
                          return Text('${data.data.toString()}');
                        else
                          return Text('Null');
                      })
                ],
              ),
            ),
          ),
        ));
  }
}

Future<String> get localPath async {
  final path = await getApplicationDocumentsDirectory();
  return path.path;
}

Future<File> get localFile async {
  final file = await localPath;
  return new File('$file/MyApp.txt'); // to create new file
}

Future<File> writeData(String value) async {
  final file = await localFile;
  return file.writeAsString('$value');
}

Future<String> readData() async {
  try {
    final file = await localFile;
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return 'File Doesnt Found';
  }
}
