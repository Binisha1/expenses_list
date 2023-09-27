import 'package:flutter/material.dart';
import 'package:pexpense_tracker/expenses.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 81, 179, 248));
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.primaryContainer,
          foregroundColor: kcolorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
