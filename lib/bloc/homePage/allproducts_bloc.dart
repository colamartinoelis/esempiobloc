import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:esempiobloc/main.dart';
import 'package:esempiobloc/repositories/ListaProdotti.dart';
import 'allproducts_event.dart';
import 'allproducts_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  String variabileProva = 'ciao';
  @override
  AllProductsState get initialState => AllProductsLoading(variabileProva);

  @override
  Stream<AllProductsState> mapEventToState(
    AllProductsEvent event,
  ) async* {
    if(event is AllProductsEventA) {
      // devo mettere una await perchè il risultato deriva da una future
      final prodotti = await getIt.get<ListaProdottiRepository>().all();
      yield AllProductsLoaded(prodotti);
    }
  }
}
