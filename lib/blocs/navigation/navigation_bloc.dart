import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(BootState()) {
    on<NavigateToguide>((event, emit) => emit(GuideState()));
    on<NavigateToLogin>((event, emit) => emit(LoginState()));
    on<NavigateToRegister>((event, emit) => emit(RegisterationState()));
    on<NavigateToDashboard>((event, emit) => emit(DashboardScreenState())); 
  }
}