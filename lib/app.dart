import 'package:flutter/material.dart';
import 'screens/signin_screen.dart';
import 'screens/screens_wrapper.dart';
import 'themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ticket Booking',
      theme: customTheme,
      home: const SignInScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreensWrapper(),
    );
  }
}
