import 'package:book_heaven/model/product_model.dart';

abstract class ShoppingBagEvent {}

class AddToBagEvent extends ShoppingBagEvent {
  final Product product;
  final int quantity;

  AddToBagEvent(this.product, this.quantity);
}

class RemoveFromBagEvent extends ShoppingBagEvent {
  final Product product;

  RemoveFromBagEvent(this.product);
}
