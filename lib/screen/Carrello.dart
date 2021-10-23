import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esempiobloc/models/Prodotto.dart';
import 'package:esempiobloc/bloc/carrello/bloc.dart';
import 'package:esempiobloc/bloc/carrello/shoppingcarrello_state.dart';
import 'package:esempiobloc/component/contenitoreImmagine.dart';


class Carrello extends StatelessWidget {
  static const routeName = '/carrello';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        title: new Text('Il mio ordine'),
        centerTitle: true,
      ),
      body: bodyCarrello(context),
    );
  }
}

Widget bodyCarrello(BuildContext context) {
  return new BlocConsumer<ShoppingCarrelloBloc, ShoppingCarrelloState>(
      listener: (context, stato) {
    final List<Prodotto> listaCarrello =
        (stato as ShoppingCarrelloLoaded).listaProdottiCarrello;

    if (listaCarrello.isEmpty) {
      Navigator.pop(context);
    }
  }, builder: (context, stato) {
    final List<Prodotto> listaCarrello =
        (stato as ShoppingCarrelloLoaded).listaProdottiCarrello;
    double prezzoTotale = listaCarrello.isEmpty
        ? 0.0
        : listaCarrello
            .map((valore) => valore.prezzo)
            .reduce((value, element) => value + element)
            .truncateToDouble();

    return Padding(
      padding: EdgeInsets.all(20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          corpoCentrale(context, listaCarrello),
          new SizedBox(
            height: 10,
          ),
          footer(prezzoTotale)
        ],
      ),
    );
  });
}

Widget corpoCentrale(BuildContext context, List<Prodotto> prodotti) =>
    new Expanded(
      child: rigaProdotti(context, prodotti),
    );

Widget rigaProdotti(BuildContext context, List<Prodotto> prodotti) =>
    new ListView.separated(
        itemBuilder: (context, index) =>
            prodottoComprato(context, prodotti[index]),
        separatorBuilder: (context, index) => new SizedBox(
              height: 10,
            ),
        itemCount: prodotti.length);

Widget prodottoComprato(BuildContext context, Prodotto prodotto) => new Row(
      children: [
        new ContenitoreImmagine(
            larghezza: 120.00, altezza: 150.00, url: prodotto.url),
        new SizedBox(
          width: 10,
        ),
        new Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                prodotto.nome,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              new SizedBox(
                height: 10,
              ),
              new Text(
                prodotto.prezzo.toString(),
                style:
                    new TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
              new SizedBox(
                height: 10,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new IconButton(
                    icon: new Icon(Icons.delete, color: Colors.red,),
                    onPressed: () => print('prova'),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(0),),
                  new Text(
                    "tap per togliere ",
                    style: new TextStyle(color: Colors.black38),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
*/
              new GestureDetector(
                onTap: () => BlocProvider.of<ShoppingCarrelloBloc>(context)
                    .add(ShoppingCarrelloRemoveEvent(prodotto)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    new Text(
                      "tap per togliere ",
                      style: new TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );

Widget footer(double totale) => new Column(
      children: [
        rigaTotale(totale),
        new SizedBox(
          height: 10,
        ),
        pulsantePagamento()
      ],
    );

Widget rigaTotale(double prezzoTotale) =>
    new BlocBuilder<ShoppingCarrelloBloc, ShoppingCarrelloState>(
      builder: (context, stato) => new Row(children: <Widget>[
        new Text(
          "Totale",
          style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
        new Expanded(child: new Container()),
        new Text(
          '€ ${prezzoTotale}',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ]),
    );

Widget pulsantePagamento() => new SafeArea(
      child: new MaterialButton(
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          color: Colors.black,
          onPressed: () {},
          height: 50,
          minWidth: double.infinity,
          child: new Text(
            "vai al pagamento",
            style: new TextStyle(color: Colors.white),
          )),
    );
