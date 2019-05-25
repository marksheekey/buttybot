import 'package:flutter/material.dart';

import 'DB.dart' as db;

class NextButtyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: new FutureBuilder(
            future: db.getNext(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('');
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.waiting:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) return Text('');
                  return new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        _getData(snapshot.data),
                      ))
                    ],
                  );
              }
            }));
  }

  String _getData(String data) {
    print("dat:${data}");
    if (data != null && data.length > 0) {
      return "Next butty run: ${data}";
    }

    return "";
  }
}
