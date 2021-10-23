
import 'package:esempiobloc/models/Prodotto.dart';

class ShoppingCarrelloRepositories{
List<Prodotto> listaCarrello = [];

  List<Prodotto> addProdotto(Prodotto prodotto){
    listaCarrello.add(prodotto);
    return listaCarrello;
  }

List<Prodotto> removeProdotto(Prodotto prodotto){
  listaCarrello.remove(prodotto);
  return listaCarrello;
}



}