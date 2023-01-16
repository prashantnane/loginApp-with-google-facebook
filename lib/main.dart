import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './controllerLogin.dart';
import './loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ControllerLogin()),
        )
      ],
      child: MaterialApp(
        title: 'Google Sign In',
        theme: ThemeData(
          
          primarySwatch: Colors.amber,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

