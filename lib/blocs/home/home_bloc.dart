import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {

    on<LoadHomeDataEvent>((event, emit) async {
      emit(HomeLoadingState()); 
      try {
        await Future.delayed(const Duration(seconds: 2));
        final specialOffer = event.jsonData['specialOffer'];
        final topOfWeek = event.jsonData['topOfWeek'];
        final vendors = event.jsonData['vendors'];
        final authors = event.jsonData['authors'];

        emit(HomeLoadedState(
          specialOffer: specialOffer,
          topOfWeek: topOfWeek,
          vendors: vendors,
          authors: authors,
        ));
      } catch (error) {
        emit(HomeErrorState(error: error.toString()));
      }
    });
  }
}
