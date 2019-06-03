import 'dart:async';

import 'package:buttybot/ButtyListByButtyWidget.dart';
import 'package:buttybot/ButtyListByUserWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Butties.dart';
import 'Butty.dart';
import 'CreateButtyWidget.dart';
import 'CreateUserWidget.dart';
import 'DB.dart' as db;

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
  DatabaseReference ref;
  StreamSubscription r1;
  StreamSubscription r2;
  StreamSubscription r3;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    print("init");
    ref = database.reference();
    r1 = ref.onChildAdded.listen(_refresh);
    r2 = ref.onChildChanged.listen(_refresh);
    r3 = ref.onChildRemoved.listen(_refresh);
  }

  @override
  void dispose() {
    super.dispose();
    r1.cancel();
    r2.cancel();
    r3.cancel();
  }

  void _refresh(Event event) {
    setState(() {});
  }

  void _newButty() {
    getThisUser().then((String user) {
      if (user != null && user.length > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateButtyWidget(new Butty())),
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
    return FutureBuilder(
        future: db.geButtyList(),
        builder: (BuildContext context, AsyncSnapshot<Butties> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('');
            case ConnectionState.active:
              return Text('');
            case ConnectionState.waiting:
              return Text('');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('');

              final List<Butty> list = snapshot.data.butties;
              print("tabby");

              return MaterialApp(
                home: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: _newButty,
                      tooltip: 'New Butty',
                      child: Icon(Icons.add),
                    ),
                    appBar: AppBar(
                      bottom: TabBar(
                        tabs: [Tab(text: "By User"), Tab(text: "By Butty")],
                      ),
                      title: Text('Butty Bot'),
                    ),
                    body: TabBarView(
                      children: [
                        ButtyListByUserWidget(list),
                        ButtyListByButtyWidget(list),
                      ],
                    ),
                  ),
                ),
              );
          }
        });
  }
}
