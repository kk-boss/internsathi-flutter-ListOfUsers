import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listofitems/screens/home/home.dart';

import 'typography/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'List of Users',
        theme: ThemeData(
            primarySwatch: kPrimarySwatch,
            scaffoldBackgroundColor: kPrimaryLight,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: kWhiteColor,
              foregroundColor: kPrimaryColor,
              splashColor: kPrimaryLight,
            ),
            cardTheme: const CardTheme(
              color: kWhiteColor,
            ),
            iconTheme: const IconThemeData(color: kPrimaryColor)),
        home: const HomeScreen(),
      ),
    );
  }
}
