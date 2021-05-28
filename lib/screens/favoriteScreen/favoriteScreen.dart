import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/providers/makeUpProvider.dart';
import 'package:flutter_app_search_cosmetic/screens/favoriteScreen/favoriteScreenItem.dart';
import 'package:flutter_app_search_cosmetic/widgets/drawer.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screen';
  @override
  Widget build(BuildContext context) {
    final onlyFavorite =
        Provider.of<MakeUpProvider>(context, listen: false).favoriteItems;
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        title: Text('My Favorites'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: (onlyFavorite.length > 0)
            ? ListView.builder(
                itemCount: onlyFavorite.length,
                itemBuilder: (context, index) {
                  return FavoriteScreenItem(
                    img: onlyFavorite[index].img,
                    prodName: onlyFavorite[index].prodName,
                    id: onlyFavorite[index].id,
                  );
                },
              )
            : Center(
                child: Text(
                  'You dont have favorite yet',
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
    );
  }
}
