import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Butty.dart';
import 'CreateButtyWidget.dart';

class ButtyListByUserWidget extends StatelessWidget {
  final List<Butty> butties;

  ButtyListByUserWidget(this.butties);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: butties.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new InkWell(
              child: new ButtyWidget(
                butties[index],
              ),
              onTap: () {
                getThisUser().then((String user) {
                  if (user == butties[index].user || user == "mark") {
                    Navigator.push(
                      ctxt,
                      new MaterialPageRoute(
                        builder: (ctxt) {
                          return CreateButtyWidget(
                              butties[index], butties[index].user);
                        },
                      ),
                    );
                  }
                });
              });
        });
  }
}

Future<String> getThisUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = prefs.get("user");
  return user;
}

class ButtyWidget extends StatelessWidget {
  final Butty butty;

  ButtyWidget(this.butty);

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = new List();

    Color a = Colors.white;
    if (butty.number == 0) {
      a = Colors.black12;
    }

    icons.add(new Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        width: 75,
        height: 50,
        child: Center(child: new Text(butty.user))));

    if (butty.white_bread) {
      icons.add(
          Image.asset('assets/white_bread.png', width: 50.0, height: 50.0));
    }

    if (butty.brown_bread) {
      icons.add(
          Image.asset('assets/brown_bread.png', width: 50.0, height: 50.0));
    }

    if (butty.bacon) {
      icons.add(Image.asset('assets/bacon.png', width: 50.0, height: 50.0));
    }

    if (butty.sausage) {
      icons.add(Image.asset('assets/sausage.png', width: 50.0, height: 50.0));
    }

    if (butty.egg) {
      icons.add(Image.asset('assets/egg.png', width: 50.0, height: 50.0));
    }

    if (butty.ketchup) {
      icons.add(Image.asset('assets/tom.png', width: 50.0, height: 50.0));
    }

    if (butty.hp_sauce) {
      icons.add(
          Image.asset('assets/brown_sauce.png', width: 50.0, height: 50.0));
    }

    print("user ${butty.user} ${butty.number}");

    if (butty.number != 1) {
      icons.add(new Container(
          width: 50,
          height: 50,
          child: Center(
              child: new Text("X ${butty.number}",
                  style: new TextStyle(fontSize: 20.0)))));
    }

    return new Row(children: <Widget>[
      Container(
        color: a,
        height: 50,
        child: new ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: icons.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return icons[index];
            }),
      ),
    ]);
  }
}
