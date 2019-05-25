import 'package:firebase_database/firebase_database.dart';

import 'Butty.dart';

final butties = FirebaseDatabase.instance.reference().child('butties');
final users = FirebaseDatabase.instance.reference().child('users');
final next = FirebaseDatabase.instance.reference().child('next');

void addButty(Butty butty) {
  butties.push().set({
    'user': butty.user,
    'white_bread': butty.white_bread,
    'brown_bread': butty.brown_bread,
    'bacon': butty.bacon,
    'sausage': butty.sausage,
    'egg': butty.egg,
    'hp_sauce': butty.hp_sauce,
    'ketchup': butty.ketchup,
    'number': butty.number
  });
}

void addUser(String user) {
  users.push().set({'user': user});
}

void addNext(String nextTime) {
  next.push().set({'next': nextTime});
}

void getButties() {
  butties.once().then((DataSnapshot snapshot) {});
}

Future<List<String>> getUsers() async {
  List<String> n = new List();
  await users.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = snapshot.value;
    if (map != null && map.values != null) {
      List names = map.values.toList();
      for (int i = 0; i < names.length; i++) {
        n.add(names[i]["user"]);
      }
    }
  });

  return n;
}

bool doesUserExist(List<String> users, String user) {
  if (users == null || users.length == 0) {
    return false;
  }

  return users.contains(user);
}

Future<String> getNext() async {
  String n = "Not specified";
  await next.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = snapshot.value;
    if (map != null && map.values != null) {
      List nexts = map.values.toList();
      print("lenght ${nexts.length}");
      if (nexts.length > 0) {
        print("lenght ${nexts[0].toString()}");
        n = nexts[0]["next"];
      }
    }
  });

  return n;
}

Future<List<Butty>> geButtyList() async {
  List<Butty> buttyList = new List();
  await butties.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = snapshot.value;
    if (map != null && map.values != null) {
      List b = map.values.toList();
      for (int i = 0; i < b.length; i++) {
        Butty butty = new Butty();
        butty.user = b[i]["user"];
        butty.white_bread = b[i]["white_bread"];
        butty.brown_bread = b[i]["brown_bread"];
        butty.bacon = b[i]["bacon"];
        butty.sausage = b[i]["sausage"];
        butty.egg = b[i]["egg"];
        butty.hp_sauce = b[i]["hp_sauce"];
        butty.ketchup = b[i]["ketchup"];
        butty.number = b[i]["number"];
        if (butty.user == null) {
          butty.user = "Unknown";
        }
        buttyList.add(butty);
      }
    }
  });

  return buttyList;
}
