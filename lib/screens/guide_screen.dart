import 'package:book_heaven/blocs/navigation/navigation_bloc.dart';
import 'package:book_heaven/blocs/navigation/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05), 
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/guide.PNG',
                      height: screenHeight * 0.3, 
                    ), 
                    SizedBox(height: screenHeight * 0.03), 
                    const Text(
                      'Your Bookish Soulmate Awaits',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02), 
                    const Text(
                      'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth, 50), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.blue, 
                    ),
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToRegister());
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth, 50), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color(0xFFADD8E6), 
                    ),
                    onPressed: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigateToLogin());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue), 
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
