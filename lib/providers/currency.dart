import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Currency with ChangeNotifier {
  final String id;
  final String name;
  final double rate;
  final fromCurrency;
  bool isFavorite;

  Currency(
      {@required this.id,
      @required this.name,
      @required this.rate,
      this.fromCurrency,
      this.isFavorite = false});

  void setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus(String id) async {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
