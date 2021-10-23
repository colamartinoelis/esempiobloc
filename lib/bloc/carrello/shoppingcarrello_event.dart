import 'package:esempiobloc/models/Prodotto.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCarrelloEvent {}

class ShoppingCarrelloAddEvent extends ShoppingCarrelloEvent{
  ShoppingCarrelloAddEvent(this.prodotto);
  Prodotto prodotto;

}

class ShoppingCarrelloRemoveEvent extends ShoppingCarrelloEvent{
  ShoppingCarrelloRemoveEvent(this.prodotto);
  Prodotto prodotto;

}

class ShoppingCarrelloGetEvent extends ShoppingCarrelloEvent{}

