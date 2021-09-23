import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kantor/screens/tabs/currency_board.dart';
import 'package:kantor/screens/tabs/exchange.dart';
import 'package:kantor/screens/tabs/favorites.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static const routeName = '/main';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  ScrollController scrollController;
  bool scrollVisible = true;

  static List<Widget> _widgetOptions = <Widget>[
    ExchangeScreen(),
    CurrencyBoardScreen(),
    FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      scrollVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            label: 'Kalkulator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Waluty',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Ulubione',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).buttonColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
