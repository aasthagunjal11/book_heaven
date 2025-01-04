import 'package:book_heaven/model/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsLoadedState extends ProductDetailsState {
  final Product product;
  final int quantity;

  ProductDetailsLoadedState(this.product, {required this.quantity});
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String error;

  ProductDetailsErrorState(this.error);
}
