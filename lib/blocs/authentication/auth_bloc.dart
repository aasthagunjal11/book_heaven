import 'package:book_heaven/blocs/navigation/navigation_bloc.dart';
import 'package:book_heaven/blocs/navigation/navigation_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NavigationBloc navigationBloc;

  AuthBloc(this.navigationBloc) : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedEmail = prefs.getString('email');
        String? storedPassword = prefs.getString('password');

        if (storedEmail != null && storedPassword != null &&
            event.email == storedEmail && event.password == storedPassword) {
          emit(AuthSuccessState());
          navigationBloc.add(NavigateToHome()); 
        } else {
          emit(AuthFailureState(error: "Invalid email or password"));
        }
      } catch (e) {
        emit(AuthFailureState(error: "Authentication failed"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', event.email);
        await prefs.setString('password', event.password);

        emit(AuthSuccessState());
        navigationBloc.add(NavigateToLogin()); 
      } catch (e) {
        emit(AuthFailureState(error: "Registration failed"));
      }
    });

    on<LogoutEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      emit(AuthInitialState());
    });
  }
}
