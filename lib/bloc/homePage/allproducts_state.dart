import 'package:esempiobloc/models/Prodotto.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllProductsState {}

class AllProductsLoading extends AllProductsState {
  AllProductsLoading(this.nome);
  String nome;
}

class AllProductsLoaded extends AllProductsState {
  AllProductsLoaded(this.prodotti);
  List<Prodotto> prodotti;

}


