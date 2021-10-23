import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:esempiobloc/bloc/homePage/allproducts_bloc.dart';
import 'package:esempiobloc/bloc/carrello/bloc.dart';

import 'package:esempiobloc/repositories/ListaProdotti.dart';
import 'package:esempiobloc/repositories/ShoppingCarrello.dart';

import 'package:esempiobloc/screen/HomePage.dart';
import 'package:esempiobloc/screen/Carrello.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(ListaProdottiRepository());
  getIt.registerSingleton(ShoppingCarrelloRepositories());

  return runApp(
    new MultiBlocProvider(
      providers: [
        new BlocProvider(
          create: (context) => new AllProductsBloc(),
        ),
        new BlocProvider(
          create: (context) => new ShoppingCarrelloBloc(),
        ),
      ],
      child: new MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    return new MaterialApp(
      routes: {
        HomePage.routeName: (_) => new HomePage(),
        Carrello.routeName: (_) => new Carrello(),
      },
      initialRoute: HomePage.routeName,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black, //accentcolor serve per avere l'effeto
        // splash NERO quando si pigia un bottone
      ),
    );
  }
}
