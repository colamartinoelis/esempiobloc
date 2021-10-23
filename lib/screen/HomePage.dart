import 'package:esempiobloc/bloc/carrello/shoppingcarrello_bloc.dart';
import 'package:esempiobloc/bloc/carrello/shoppingcarrello_event.dart';
import 'package:esempiobloc/bloc/carrello/shoppingcarrello_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:esempiobloc/bloc/homePage/allproducts_bloc.dart';
import 'package:esempiobloc/bloc/homePage/allproducts_event.dart';
import 'package:esempiobloc/bloc/homePage/allproducts_state.dart';

import 'package:esempiobloc/screen/Carrello.dart';
import 'package:esempiobloc/models/Prodotto.dart';

import 'package:esempiobloc/component/contenitoreImmagine.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Prodotto> y = [];
  //QUI NEL CASO NON VOLESSI USARE BLOC e API PER CARICARE HomePAGE
  // I metodo---------------------------
  /*  @override
  void initState() {
    super.initState();
    // con il metodo then posso prelevare i valore della future
    ListaProdottiRepository().all().then((value) => this.y = value);
  }
*/
// II metodo---------------------------con chiamata API
/*
  @override
  void initState() {
    super.initState();
    ListaProdottiRepository().all().then((value) {
      setState(() {
        this.y = value;
      });
    });
  }
*/

  // III metodo con uso di BLOC-------------------------------
  @override
  void initState() {
    super.initState();
    //inizializzo lo stato immettendo nell'initState AllProductsEventA che mi
    // modifica lo stato in loaded
    BlocProvider.of<AllProductsBloc>(context).add(AllProductsEventA());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: [
          appBar(context),
          titolo(),
          body(context),
        ],
      ),
    );
  }
}

Widget appBar(BuildContext context) => new SliverAppBar(
      elevation: 0,
      floating: true,
      snap: true,
      actions: [
        new BlocBuilder<ShoppingCarrelloBloc, ShoppingCarrelloState>(
            builder: (context, stato) {
          final quantitaProdottiCarrello =
              (stato as ShoppingCarrelloLoaded).listaProdottiCarrello.length;
          return new Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: new Container(
                  width: 20,
                  height: 20,
                  decoration: new BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: new Center(
                    child: Text( quantitaProdottiCarrello.toString(), style: new
                    TextStyle(color: Colors
                        .white)),
                  ),
                ),
              ),
              new IconButton(
                tooltip: "vai al carrello",
                icon: new Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.pushNamed(context, Carrello.routeName),
              ),
            ],
          );
        }),
      ],
    );

Widget titolo() => new SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: new SliverToBoxAdapter(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              'Our',
              style: new TextStyle(fontSize: 20),
            ),
            new Text(
              'Product',
              style: new TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

Widget body(BuildContext context) =>
    new BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, stato) {
      if (stato is AllProductsLoading) {
        stato.nome;
        return new SliverToBoxAdapter(
          child: Center(
            child: new Container(),
          ),
        );
      } else {
        final y = (stato as AllProductsLoaded).prodotti;

        return new SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: new SliverGrid.count(
              crossAxisSpacing: 20,
              childAspectRatio: 0.65,
              crossAxisCount: 2,
              children: List.generate(
                  10, (index) => elementoGriglia(context, y[index])),
            ));
      }
    });

Widget elementoGriglia(BuildContext context, Prodotto prodotto) => new Column(
      children: <Widget>[
        new ContenitoreImmagine(
            larghezza: double.infinity, altezza: 180.00, url: prodotto.url),
        new SizedBox(
          height: 10,
        ),
        rigaDescrizione(context, prodotto),
      ],
    );

Widget rigaDescrizione(BuildContext context, Prodotto prodotto) => new Row(
      children: [
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                prodotto.nome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(),
              ),
              new Text(
                prodotto.prezzo.toString(),
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new BlocBuilder<ShoppingCarrelloBloc, ShoppingCarrelloState>(
          builder: (context, stato) => new IconButton(
            tooltip: "aggiungi al carrello",
            icon: new Icon(Icons.add_box,
                color: (stato as ShoppingCarrelloLoaded)
                        .listaProdottiCarrello
                        .contains(prodotto)
                    ? Colors.red
                    : Colors.greenAccent),
            onPressed: () {
              if ((stato as ShoppingCarrelloLoaded)
                  .listaProdottiCarrello
                  .contains(prodotto)) {
                BlocProvider.of<ShoppingCarrelloBloc>(context).add(
                  ShoppingCarrelloRemoveEvent(prodotto),
                );
              } else {
                BlocProvider.of<ShoppingCarrelloBloc>(context).add(
                  ShoppingCarrelloAddEvent(prodotto),
                );
              }
              ;
            },
          ),
        ),
      ],
    );
