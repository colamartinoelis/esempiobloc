import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';


class Prodotto {
  Prodotto({@required this.nome, @required this.prezzo, @required this.url});

  final String nome;
  final String url;
  final double prezzo;

  factory Prodotto.fromData(dynamic data) {
    final nome = data["nome"];
    final prezzo = data["prezzo"];
    final url = data["url"];

    return Prodotto(
      nome: nome,
      prezzo: prezzo,
      url: url,
    );
  }
}
