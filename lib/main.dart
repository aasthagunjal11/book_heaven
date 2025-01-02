import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation/navigation_bloc.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'blocs/navigation/navigation_state.dart';
import 'screens/boot_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registeration_screen.dart';
import 'screens/dashboard_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()), 
        BlocProvider(
          create: (context) => AuthBloc(context.read<NavigationBloc>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  if (state is BootState) return BootScreen();
                  if (state is GuideState) return GuideScreen();
                  if (state is LoginState) return LoginScreen();
                  if (state is RegisterationState) return RegisterationScreen();
                  if (state is DashboardScreenState) return DashboardScreen(); 

                  return Container(); 
                },
              ),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterationScreen(),
          '/dashboard': (context) => DashboardScreen(),
           
        },
      ),
    );
  }
}
