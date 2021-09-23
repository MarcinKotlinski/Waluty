import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kantor/providers/currencies.dart';
import 'package:kantor/providers/currency.dart';
import 'package:kantor/screens/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Currencies(),
        ),
        ChangeNotifierProvider(
          create: (_) => Currency(),
        ),
      ],
      child: MaterialApp(
        title: 'Exchange',
        theme: ThemeData(
          // primarySwatch: Colors.yellow,
          accentColor:Color.fromRGBO(23, 38, 1, 1),
          primaryColor: Color.fromRGBO(217, 212, 186, 1),
          buttonColor: Color.fromRGBO(242, 239, 223, 1),
          errorColor: Color.fromRGBO(166, 110, 78, 1),
          disabledColor: Color.fromRGBO(115, 101, 61, 1),
          cardColor: Color.fromRGBO(166, 151, 106, 1),
          canvasColor: Color.fromRGBO(161, 10, 12, 1),
        ),
        home: MainScreen(),
      ),
    );
  }
}


