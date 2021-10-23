import 'package:flutter/material.dart';

class ContenitoreImmagine extends StatelessWidget {
  ContenitoreImmagine(
      {@required this.larghezza, @required this.altezza, @required this.url});

  dynamic larghezza, altezza;
  String url;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: larghezza,
      height: altezza,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: new DecorationImage(
              image: new NetworkImage(url),
              fit: BoxFit.cover)),
    );
  }
}
