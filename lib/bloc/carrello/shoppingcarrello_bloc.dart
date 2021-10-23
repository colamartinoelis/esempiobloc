import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:esempiobloc/main.dart';
import 'package:esempiobloc/models/Prodotto.dart';
import 'package:esempiobloc/repositories/ShoppingCarrello.dart';

import 'bloc.dart';

class ShoppingCarrelloBloc
    extends Bloc<ShoppingCarrelloEvent, ShoppingCarrelloState> {
  @override
  ShoppingCarrelloState get initialState => ShoppingCarrelloLoaded([]);

  @override
  Stream<ShoppingCarrelloState> mapEventToState(
    ShoppingCarrelloEvent event,
  ) async* {
    if (event is ShoppingCarrelloAddEvent) {
      final prodottoToAdd = event.prodotto;
      // dobbiamo aggiungerlo nel carrello tramite il nostro repositories con
      // il quale ci accediamo tramite il singleton
      final x =
          getIt<ShoppingCarrelloRepositories>().addProdotto(prodottoToAdd);
      yield ShoppingCarrelloLoaded(x);
    } else if (event is ShoppingCarrelloRemoveEvent) {
      final prodottoToRemove = event.prodotto;
      final x = getIt<ShoppingCarrelloRepositories>()
          .removeProdotto(prodottoToRemove);
      yield ShoppingCarrelloLoaded(x);
    } else if (event is ShoppingCarrelloGetEvent) {
      final x = getIt<ShoppingCarrelloRepositories>().listaCarrello;
      yield ShoppingCarrelloLoaded(x);
    }
  }
}
