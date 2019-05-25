import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DB.dart' as db;

class CreateUserWidget extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

@override
class _CreateUserState extends State<CreateUserWidget> {
  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _addUser() {
    String user = nameController.text;
    if (user != null && user.length > 0) {
      db.getUsers().then((List<String> users) {
        if (db.doesUserExist(users, user)) {
          _showToast("User with that name already exists", user);
        } else {
          doAdd(user, true);
        }
      });
    } else {
      _showToast("Please enter a name", "");
    }
  }

  void doAdd(String user, bool toDB) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    if (toDB) {
      db.addUser(user);
    }
    Navigator.pop(context);
  }

  void _showToast(String message, String user) {
    if (user.length == 0) {
      final snackBar = SnackBar(content: Text(message));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          content: Text(message),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
              label: "Use this",
              onPressed: () {
                doAdd(user, false);
              }));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        tooltip: 'Create',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: Column(
        children: <Widget>[
          Text("First you need to add yourslef as a user"),
          new TextField(
            decoration: new InputDecoration(hintText: 'User name'),
            autofocus: true,
            controller: nameController,
          )
        ],
      ),
    );
  }
}
