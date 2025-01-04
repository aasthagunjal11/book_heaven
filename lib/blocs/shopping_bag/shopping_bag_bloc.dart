import 'package:book_heaven/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shopping_bag_event.dart';
import 'shopping_bag_state.dart';

class ShoppingBagBloc extends Bloc<ShoppingBagEvent, ShoppingBagState> {
  final Map<Product, int> _bag = {};

  ShoppingBagBloc() : super(ShoppingBagInitialState()) {
    on<AddToBagEvent>((event, emit) {
      _bag[event.product] = (_bag[event.product] ?? 0) + event.quantity;
      emit(ShoppingBagUpdatedState(Map.from(_bag)));
    });

    on<RemoveFromBagEvent>((event, emit) {
      _bag.remove(event.product);
      emit(ShoppingBagUpdatedState(Map.from(_bag)));
    });
  }
}
