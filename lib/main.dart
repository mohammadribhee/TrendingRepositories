import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/repository_viewmodel.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RepositoryViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
