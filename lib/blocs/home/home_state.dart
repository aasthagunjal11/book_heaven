import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final Map<String, dynamic> specialOffer;
  final List<dynamic> topOfWeek;
  final List<dynamic> vendors;
  final List<dynamic> authors;

  const HomeLoadedState({
    required this.specialOffer,
    required this.topOfWeek,
    required this.vendors,
    required this.authors,
  });

  @override
  List<Object?> get props => [specialOffer, topOfWeek, vendors, authors];
}

class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
