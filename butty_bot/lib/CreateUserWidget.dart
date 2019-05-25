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

  void _addUser() {
    String user = nameController.text;
    if (user != null && user.length > 0) {
      db.getUsers().then((List<String> users) {
        if (db.doesUserExist(users, user)) {
          _showToast("User with that name already exists");
        } else {
          doAdd(user);
        }
      });
    } else {
      _showToast("Please enter a name");
    }
  }

  void doAdd(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    db.addUser(user);
    Navigator.pop(context);
  }

  void _showToast(String message) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        tooltip: 'Create',
        child: Icon(Icons.add),
      ), // This trailing comma makes a
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
