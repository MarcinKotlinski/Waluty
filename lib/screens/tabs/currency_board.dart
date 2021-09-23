import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kantor/providers/currencies.dart';
import 'package:kantor/providers/currency.dart';
import 'package:kantor/widgets/currency_item.dart';
import 'package:provider/provider.dart';

class CurrencyBoardScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  _CurrencyBoardScreenState createState() => _CurrencyBoardScreenState();
}

class _CurrencyBoardScreenState extends State<CurrencyBoardScreen> {
  String currency;
  Future<Currency> _futureCurrency;

  Future _obtainCurrencyFuture(BuildContext context) {
    return Provider.of<Currencies>(context, listen: false)
        .fetchCurrencies(currency);
  }

  @override
  void initState() {
    super.initState();
    currency = 'PLN';
    _futureCurrency = _obtainCurrencyFuture(context);
  }

  Future<void> openDialog() async {
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
                  currency = "PLN";
                  _obtainCurrencyFuture(context);
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("EUR"),
              onPressed: () {
                setState(() {
                  currency = "EUR";
                  _obtainCurrencyFuture(context);
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("USD"),
              onPressed: () {
                setState(() {
                  currency = "USD";
                  _obtainCurrencyFuture(context);
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("CHF"),
              onPressed: () {
                setState(() {
                  currency = "CHF";
                  _obtainCurrencyFuture(context);
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("GBP"),
              onPressed: () {
                setState(() {
                  currency = "GBP";
                  _obtainCurrencyFuture(context);
                });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("JPY"),
              onPressed: () {
                setState(() {
                  currency = "JPY";
                  _obtainCurrencyFuture(context);
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
    final productsData = Provider.of<Currencies>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 40, right: 0, bottom: 0),
          child: GestureDetector(
            onTap: () => openDialog(),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).disabledColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    currency,
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).disabledColor,
            color: Theme.of(context).cardColor,
            onRefresh: () => _obtainCurrencyFuture(context),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 15, right: 30, bottom: 30),
              child: FutureBuilder(
                future: _futureCurrency,
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (dataSnapshot.error != null) {
                      // error handling
                      return Center(
                        child: Text('Wystąpił bład!'),
                      );
                    } else {
                      return Consumer<Currencies>(
                        builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: orderData.items.length,
                          itemBuilder: (ctx, i) => CurrencyItem(
                              orderData.items[i].id,
                              orderData.items[i].name,
                              orderData.items[i].rate,
                              currency,
                              orderData.items[i].isFavorite,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
