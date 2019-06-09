import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'Butty.dart';
import 'DB.dart' as db;

class CreateButtyWidget extends StatefulWidget {
  final Butty butty;
  final String user;

  CreateButtyWidget(this.butty, this.user);

  @override
  _CreateButtyState createState() => _CreateButtyState(this.butty, this.user);
}

@override
class _CreateButtyState extends State<CreateButtyWidget> {
  Butty butty;
  String user;

  _CreateButtyState(this.butty, this.user);

  void _addButty() {
    var uuid = new Uuid();
    butty.id = uuid.v4();
    db.addButty(butty);
    Navigator.pop(context);
  }

  void _updateButty() {
    db.updateButty(butty);
    Navigator.pop(context);
  }

  void _doButty() {
    if (butty.id.length == 0) {
      _addButty();
    } else {
      _updateButty();
    }
  }

  Future<String> getThisUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get("user");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    String title = "Create Butty";
    if (butty != null) {
      title = "Update Butty";
    } else {
      butty = new Butty();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _doButty,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ), // This trailing comma makes a
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/white_bread.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("White bread")),
              Checkbox(
                value: butty.white_bread,
                onChanged: (bool value) {
                  setState(() {
                    butty.white_bread = value;
                    if (value) {
                      butty.brown_bread = false;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/brown_bread.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Brown bread")),
              Checkbox(
                value: butty.brown_bread,
                onChanged: (bool value) {
                  setState(() {
                    butty.brown_bread = value;
                    if (value) {
                      butty.white_bread = false;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/bacon.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Bacon")),
              Checkbox(
                value: butty.bacon,
                onChanged: (bool value) {
                  setState(() {
                    butty.bacon = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/sausage.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Sausage")),
              Checkbox(
                value: butty.sausage,
                onChanged: (bool value) {
                  setState(() {
                    butty.sausage = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/egg.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Egg", textAlign: TextAlign.left)),
              Checkbox(
                value: butty.egg,
                onChanged: (bool value) {
                  setState(() {
                    butty.egg = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/brown_sauce.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Brown sauce")),
              Checkbox(
                value: butty.hp_sauce,
                onChanged: (bool value) {
                  setState(() {
                    butty.hp_sauce = value;
                    if (value) {
                      butty.ketchup = false;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/tom.png', width: 50.0, height: 50.0),
              new Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 50,
                  child: new Text("Tomato ketchup")),
              Checkbox(
                value: butty.ketchup,
                onChanged: (bool value) {
                  setState(() {
                    butty.ketchup = value;
                    if (value) {
                      butty.hp_sauce = false;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (butty.number >= 1) {
                      butty.number--;
                    }
                  });
                },
                child: Image.asset('assets/ic_subtract.png',
                    width: 50.0, height: 50.0),
              ),
              Container(
                alignment: Alignment.center,
                width: 150,
                height: 50,
                child: Text(
                  "Number: ${butty.number}",
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    butty.number++;
                  });
                },
                child: Image.asset('assets/ic_add_circle.png',
                    width: 50.0, height: 50.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
