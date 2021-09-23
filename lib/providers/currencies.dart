import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kantor/helpers/dbhelper.dart';
import 'package:kantor/providers/currency.dart';
import 'package:http/http.dart' as http;

class Currencies with ChangeNotifier {
  String fromCurrency = 'PLN';
  double calculatedValue;

  List<Currency> _items = [];

  List<Currency> _favoriteItems = [];

  List<Currency> get items {
    return [..._items];
  }

  List<Currency> get favoriteItems {
    return [..._favoriteItems];
  }

  deleteItem(String id) {
    final existingProductIndex =
        _favoriteItems.indexWhere((prod) => prod.id == id);
    _favoriteItems.removeAt(existingProductIndex);
    notifyListeners();
    DBHelper.remove('waluty', id);
  }

  addItem(String id, String name, double rate, String fromCurrency) {
    try {
      final newItem =
          Currency(id: id, name: name, rate: rate, fromCurrency: fromCurrency);
      _favoriteItems.add(newItem);
      notifyListeners();
      DBHelper.insert('waluty', {
        'id': newItem.id,
        'name': newItem.name,
        'rate': newItem.rate.toString(),
        'fromCurrency': newItem.fromCurrency
      });
      print("Item added");
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<Currency> fetchCurrencies(String fromCurrency) async {
    final response = await http.get(Uri.parse(
        'https://api.frankfurter.app/latest?amount=1&from=${fromCurrency}'));

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<Currency> loadedProducts = [];
      extractedData['rates']['USD'] == null
          ? 0
          : loadedProducts.add(Currency(
              id: fromCurrency + "USD",
              name: "USD",
              rate: extractedData['rates']['USD']));
      extractedData['rates']['EUR'] == null
          ? 0
          : loadedProducts.add(Currency(
              id: fromCurrency + "EUR",
              name: "EUR",
              rate: extractedData['rates']['EUR']));
      extractedData['rates']['CHF'] == null
          ? 0
          : loadedProducts.add(Currency(
              id: fromCurrency + "CHF",
              name: "CHF",
              rate: extractedData['rates']['CHF']));
      extractedData['rates']['JPY'] == null
          ? 0
          : loadedProducts.add(Currency(
              id: fromCurrency + "JPY",
              name: "JPY",
              rate: extractedData['rates']['JPY']));
      extractedData['rates']['PLN'] == null
          ? 0
          : loadedProducts.add(Currency(
              id: fromCurrency + "PLN",
              name: "PLN",
              rate: extractedData['rates']['PLN']));
      _items = loadedProducts;
      notifyListeners();
    } else {
      throw Exception('Wystapił błąd!');
    }
  }

  Future<String> calculateCurrency(
    String fromCurrency,
    String toCurrency,
    double amount,
  ) async {
    final response = await http.get(Uri.parse(
        'https://api.frankfurter.app/latest?amount=${amount}&from=${fromCurrency}&to=${toCurrency}'));

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      calculatedValue = extractedData['rates'][toCurrency];
      print(calculatedValue.toString());
      notifyListeners();
    } else {
      throw Exception('Wystapił błąd!');
    }
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData('waluty');
    _favoriteItems = dataList
        .map((item) => Currency(
            id: item['id'],
            name: item['name'],
            rate: double.parse(item['rate']),
            fromCurrency: item['fromCurrency'],
            isFavorite: item['isFavorite']))
        .toList();
    notifyListeners();
  }
}
