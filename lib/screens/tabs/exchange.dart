import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kantor/providers/currencies.dart';
import 'package:provider/provider.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

enum Currency { PLN, EUR, USD, CHF, GBP, JPY }

class _ExchangeScreenState extends State<ExchangeScreen> {
  final fromTextController = TextEditingController();
  String from = "EUR";
  String to = "PLN";
  double amount;

  fetchAndSetProvidersData() {
    final currencies = Provider.of<Currencies>(context, listen: false);

    setState(() {
      currencies.fetchAndSetData();
    });
  }


  @override
  void initState() {
    fetchAndSetProvidersData();
  }

  Future<void> openDialog(bool val) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Wybierz walutę"),
          children: [
            SimpleDialogOption(
              child: Text("PLN"),
              onPressed: () {
                setState(() {
                  val ? from = "PLN" : to = "PLN";
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("EUR"),
              onPressed: () {
                setState(() {
                  val ? from = "EUR" : to = "EUR";
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("USD"),
              onPressed: () {
                setState(() {
                  val ? from = "USD" : to = "USD";
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("CHF"),
              onPressed: () {
                setState(() {
                  val ? from = "CHF" : to = "CHF";
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("GBP"),
              onPressed: () {
                setState(() {
                  val ? from = "GBP" : to = "GBP";
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("JPY"),
              onPressed: () {
                setState(() {
                  val ? from = "JPY" : to = "JPY";
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currenciesProvider = Provider.of<Currencies>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => openDialog(true),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).disabledColor,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              from,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 60,
                    ),
                    GestureDetector(
                      onTap: () => openDialog(false),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).disabledColor,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              to,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 5.0),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          controller: fromTextController,
                          scrollPadding: EdgeInsets.all(80.0),
                          decoration: InputDecoration(
                            hintText: from,
                            contentPadding: EdgeInsets.all(30),
                            filled: true,
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Wprowadź kwotę',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            from==to ? createSnackBar(
                                'Wprowadź inną walutę',
                                Theme.of(context).disabledColor,
                                context) :
                            currenciesProvider
                                .calculateCurrency(from, to,
                                    double.parse(fromTextController.text))
                                .then((value) => createSnackBar(
                                    currenciesProvider.calculatedValue
                                            .toStringAsFixed(2)+' '+
                                        to,
                                    Theme.of(context).disabledColor,
                                    context));
                          });
                        },
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Icon(
                                Icons.check,
                                size: 30,
                                color: Theme.of(context).buttonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void createSnackBar(String message, Color color, BuildContext context) async {
  final snackBar = new SnackBar(
      backgroundColor: color,
      elevation: 6.0,
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 45,
        ),
      ));

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
