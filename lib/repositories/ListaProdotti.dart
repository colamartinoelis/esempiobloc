import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:esempiobloc/models/Prodotto.dart';


class ListaProdottiRepository {

  Future<List<Prodotto>> all() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    return await scaricaDati();
  }

  Future<List<Prodotto>> scaricaDati() async {
    print("2");
    final response =
        await http.get("https://api.npoint.io/4b5f3da7ae1bd8816723");
    List<dynamic> lista = json.decode(response.body)["prodotti"];
    print("3: $lista");
    List<Prodotto> x =
        lista.map((valore) => Prodotto.fromData(valore)).toList();
    return x;
  }
}

//IN questo modo la lista viene caricata senza utilizzare BLOC ed API

/*
class ListaProdottiRepository {

  Future<List<Prodotto>> all() async {
    return await y;
  }

  final List<Prodotto> y = [
    new Prodotto(
      url: "https://picsum.photos/id/15/200/300",
      nome: "Clgdgfdfdgdfguds",
      prezzo: 20.00,
    ),
    new Prodotto(
      url: "https://picsum.photos/id/20/200/300",
      nome: "Altro prodotoo",
      prezzo: 25.00,
    ),
    new Prodotto(
      url: "https://picsum.photos/id/34/200/300",
      nome: "Terzo prodoto fatto a mano",
      prezzo: 400.50,
    ),
    new Prodotto(
        url: "https://picsum.photos/id/94/200/300",
        nome: "Lino in resina purificata a mano",
        prezzo: 2.65),
    new Prodotto(
      url: "https://picsum.photos/id/5/200/300",
      nome: "Clouds and Clouds",
      prezzo: 29.00,
    ),
    new Prodotto(
      url: "https://picsum.photos/id/11/200/300",
      nome: "Clouds",
      prezzo: 20.00,
    ),
    new Prodotto(
      url: "https://picsum.photos/id/2/200/300",
      nome: "Altro prodotoo",
      prezzo: 25.00,
    ),
    new Prodotto(
      url: "https://picsum.photos/id/35/200/300",
      nome: "Terzo prodoto fatto a mano",
      prezzo: 40.05,
    ),
    new Prodotto(
        url: "https://picsum.photos/id/47/200/300",
        nome: "Lino in resina purificata a mano",
        prezzo: 2.65),
    new Prodotto(
      url: "https://picsum.photos/id/57/200/300",
      nome: "Clouds and Clouds",
      prezzo: 29.00,
    )
  ];

}

*/
