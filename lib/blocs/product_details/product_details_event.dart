import 'package:book_heaven/model/product_model.dart';

abstract class ProductDetailsEvent {}

class LoadProductDetailsEvent extends ProductDetailsEvent {
  final Product product;

  LoadProductDetailsEvent(this.product);
}

class IncrementQuantityEvent extends ProductDetailsEvent {}

class DecrementQuantityEvent extends ProductDetailsEvent {}
