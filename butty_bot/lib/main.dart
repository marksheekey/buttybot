import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ButtyListWidget.dart';
import 'CreateButtyWidget.dart';
import 'CreateUserWidget.dart';
import 'NextButtyWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ButtyBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ButtyBot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    getThisUser().then((String user) {
      if (user != null && user.length > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateButtyWidget()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateUserWidget()),
        );
      }
    });
  }

  Future<String> getThisUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get("user");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NextButtyWidget(),
            ButtyListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'New Butty',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
