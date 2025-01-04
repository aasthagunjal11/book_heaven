import 'package:book_heaven/model/product_model.dart';

abstract class ShoppingBagState {}

class ShoppingBagInitialState extends ShoppingBagState {}

class ShoppingBagUpdatedState extends ShoppingBagState {
  final Map<Product, int> bag;

  ShoppingBagUpdatedState(this.bag);
}
