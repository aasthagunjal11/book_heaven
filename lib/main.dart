import 'package:book_heaven/blocs/product_details/product_details_state.dart';
import 'package:book_heaven/blocs/shopping_bag/shopping_bag_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation/navigation_bloc.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'blocs/navigation/navigation_state.dart';
import 'blocs/shopping_bag/shopping_bag_bloc.dart';
import 'screens/boot_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registeration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/shopping_bag_screen.dart';

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
        BlocProvider(create: (context) => AuthBloc(context.read<NavigationBloc>())),
        BlocProvider(create: (context) => ShoppingBagBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  if (state is BootState) return const BootScreen();
                  if (state is GuideState) return const GuideScreen();
                  if (state is LoginState) return LoginScreen();
                  if (state is RegisterationState) return RegisterationScreen();
                  if (state is HomeScreenState) return const HomeScreen();
                  if(state is ProductDetailsState) return const ProductDetailsScreen();
                  if(state is ShoppingBagState) return const ShoppingBagScreen();
                  return Container(); 
                },
              ),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterationScreen(),
          '/home': (context) => const HomeScreen(),
          '/product_details': (context) => const ProductDetailsScreen(),
          '/shopping_bag': (context) => const ShoppingBagScreen(), 
        },
      ),
    );
  }
}
