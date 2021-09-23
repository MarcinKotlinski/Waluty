import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantor/providers/currencies.dart';
import 'package:kantor/widgets/favorite_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isFavPageActive;

  @override
  void initState() {
    isFavPageActive = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Currencies>(context, listen: false);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0, left: 0, top: 70),
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
              size: 70,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 15, right: 8, bottom: 0),
              child: productsData.favoriteItems.isEmpty
                  ? Center(
                      child: Text(
                        'Brak ulubionych kursów walut',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: productsData.favoriteItems.length,
                      itemBuilder: (_, i) => Column(
                        children: <Widget>[
                          FavoriteItem(
                            productsData.favoriteItems[i].id,
                            productsData.favoriteItems[i].name,
                            productsData.favoriteItems[i].rate,
                            productsData.favoriteItems[i].fromCurrency,
                            productsData.favoriteItems[i].isFavorite,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    isFavPageActive = false;
    super.dispose();
  }
}
