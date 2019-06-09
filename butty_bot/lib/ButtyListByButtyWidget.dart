import 'package:flutter/material.dart';

import 'Butty.dart';
import 'ButtyButty.dart';

class ButtyListByButtyWidget extends StatelessWidget {
  final List<Butty> butties;

  ButtyListByButtyWidget(this.butties);

  @override
  Widget build(BuildContext context) {
    final List<ButtyButty> byButty = extractButties(this.butties);
    return Column(
      children: <Widget>[
        // new ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: byButty.length,
        //     itemBuilder: (BuildContext ctxt, int index) {
        //       return new ButtyWidget(
        //         byButty[index],
        //       );
        //     }),
        new ListView.builder(
            shrinkWrap: true,
            itemCount: byButty.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new ButtyTextWidget(
                byButty[index],
              );
            })
      ],
    );
  }

  List<ButtyButty> extractButties(List<Butty> bb) {
    List<ButtyButty> b = new List();
    b.clear();
    for (int i = 0; i < bb.length; i++) {
      if (bb[i].number > 0) {
        int x = inList(b, bb, i);
        if (x < 0) {
          ButtyButty c = new ButtyButty();
          c.ketchup = bb[i].ketchup;
          c.sausage = bb[i].sausage;
          c.white_bread = bb[i].white_bread;
          c.brown_bread = bb[i].brown_bread;
          c.hp_sauce = bb[i].hp_sauce;
          c.egg = bb[i].egg;
          c.bacon = bb[i].bacon;
          c.total = bb[i].number;
          b.add(c);
        } else {
          b[x].total = b[x].total + bb[i].number;
        }
      }
    }
    return b;
  }

  int inList(List<ButtyButty> b, List<Butty> bb, int ii) {
    for (int i = 0; i < b.length; i++) {
      ButtyButty l = b[i];
      Butty t = bb[ii];
      if (l.brown_bread == t.brown_bread &&
          l.white_bread == t.white_bread &&
          l.bacon == t.bacon &&
          l.egg == t.egg &&
          l.hp_sauce == t.hp_sauce &&
          l.sausage == t.sausage &&
          l.ketchup == t.ketchup) {
        return i;
      }
    }

    return -1;
  }
}

class ButtyWidget extends StatelessWidget {
  final ButtyButty butty;

  ButtyWidget(this.butty);

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = new List();

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

    if (butty.total > 0) {
      icons.add(new Container(
          width: 50,
          height: 50,
          child: Center(
              child: new Text("X ${butty.total}",
                  style: new TextStyle(fontSize: 20.0)))));
    }

    return new Row(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 15.0, bottom: 15.0),
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

class ButtyTextWidget extends StatelessWidget {
  final ButtyButty butty;

  ButtyTextWidget(this.butty);

  @override
  Widget build(BuildContext context) {
    List<Widget> text = new List();

    if (butty.white_bread) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child:
                  new Text("White, ", style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.brown_bread) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child:
                  new Text("Brown, ", style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.bacon) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child:
                  new Text(" Bacon, ", style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.sausage) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child: new Text(" Sausage, ",
                  style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.egg) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child:
                  new Text(" Egg, ", style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.ketchup) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child: new Text(" Ketchup.",
                  style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.hp_sauce) {
      text.add(new Container(
          alignment: Alignment.centerLeft,
          child: Center(
              child: new Text(" Brown sauce.",
                  style: new TextStyle(fontSize: 15.0)))));
    }

    if (butty.total > 0) {
      text.add(new Container(
          child: Center(
              child: new Text("X ${butty.total}",
                  style: new TextStyle(fontSize: 15.0)))));
    }

    return new Row(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 15.0),
        height: 18,
        child: new ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: text.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return text[index];
            }),
      ),
    ]);
  }
}
