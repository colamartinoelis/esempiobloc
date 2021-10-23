import 'package:esempiobloc/models/Prodotto.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCarrelloState {}
// qui devo avere la lista dei prodotti nel carrello
class ShoppingCarrelloLoaded extends ShoppingCarrelloState {
  ShoppingCarrelloLoaded(this.listaProdottiCarrello);
  List<Prodotto> listaProdottiCarrello;
}
