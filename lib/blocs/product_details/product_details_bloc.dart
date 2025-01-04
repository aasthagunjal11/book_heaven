import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>((event, emit) {
      emit(ProductDetailsLoadingState());
      try {
        emit(ProductDetailsLoadedState(event.product, quantity: 1));
      } catch (e) {
        emit(ProductDetailsErrorState('Error loading product details.'));
      }
    });

    on<IncrementQuantityEvent>((event, emit) {
      if (state is ProductDetailsLoadedState) {
        final currentState = state as ProductDetailsLoadedState;
        emit(ProductDetailsLoadedState(currentState.product, quantity: currentState.quantity + 1));
      }
    });

    on<DecrementQuantityEvent>((event, emit) {
      if (state is ProductDetailsLoadedState) {
        final currentState = state as ProductDetailsLoadedState;
        if (currentState.quantity > 1) {
          emit(ProductDetailsLoadedState(currentState.product, quantity: currentState.quantity - 1));
        }
      }
    });
  }
}
