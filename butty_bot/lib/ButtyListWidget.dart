import 'package:flutter/material.dart';

import 'Butty.dart';
import 'DB.dart' as db;

class ButtyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new FutureBuilder(
            future: db.geButtyList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Butty>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('');
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.waiting:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) return Text('');
                  return new ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new ButtyWidget(
                          butty: snapshot.data[index],
                        );
                      });
              }
            }));
  }
}

class ButtyWidget extends StatefulWidget {
  final Butty butty;
  ButtyWidget({Butty butty}) : this.butty = butty;

  ButtyWidgetState createState() => new ButtyWidgetState(butty);
}

class ButtyWidgetState extends State<ButtyWidget> {
  ButtyWidgetState(this.butty);

  final Butty butty;

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = new List();

    icons.add(new Container(
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

    if (butty.number > 1) {
      icons.add(new Container(
          width: 50,
          height: 50,
          child: Center(
              child: new Text("X ${butty.number}",
                  style: new TextStyle(fontSize: 20.0)))));
    }

    return new Row(children: <Widget>[
      Container(
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
