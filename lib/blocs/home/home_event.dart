import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {
  final Map<String, dynamic> jsonData;

  const LoadHomeDataEvent({required this.jsonData});

  @override
  List<Object?> get props => [jsonData];
}
