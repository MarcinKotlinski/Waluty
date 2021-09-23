import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kantor/providers/currencies.dart';
import 'package:kantor/providers/currency.dart';
import 'package:provider/provider.dart';

class CurrencyItem extends StatefulWidget {
  final String id;
  final String name;
  final double rate;
  final String fromCurrency;
  final bool isFavorite;

  CurrencyItem(
      this.id, this.name, this.rate, this.fromCurrency, this.isFavorite);

  @override
  _CurrencyItemState createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<Currency>(context, listen: false);
    return Card(
      key: ValueKey(widget.id),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 0, top: 0, right: 12, bottom: 0),
              //   child: Text('1'),
              // ),
              CircleAvatar(
                backgroundColor: Theme.of(context).buttonColor,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
              Visibility(
                visible: false,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text(
                        'PLN',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text('${widget.rate.toStringAsFixed(2)}'),
          trailing: Consumer<Currencies>(
            builder: (ctx, currency, _) => IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  print(widget.name);
                  print(widget.fromCurrency);
                  currency.addItem(
                      widget.id, widget.name, widget.rate, widget.fromCurrency);
                  createSnackBar('Dodano do ulubionych',
                      Theme.of(context).disabledColor, context);
                }),
          ),
        ),
      ),
    );
  }

  void createSnackBar(String message, Color color, BuildContext context) async {
    final snackBar = new SnackBar(
        backgroundColor: color,
        elevation: 6.0,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 28,
          ),
        ));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
