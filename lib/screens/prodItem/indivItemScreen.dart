import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/providers/makeUpProvider.dart';
import 'package:provider/provider.dart';
import 'itemDetailsScreen.dart';

class IndividItemScreen extends StatefulWidget {
  final int? id;
  final String? img;
  final String? prodName;
  final String? prodType;

  const IndividItemScreen({this.id, this.img, this.prodName, this.prodType});

  @override
  _IndividItemScreenState createState() => _IndividItemScreenState();
}

class _IndividItemScreenState extends State<IndividItemScreen> {
  @override
  Widget build(BuildContext context) {
    final loadedProd =
        Provider.of<MakeUpProvider>(context).findById(widget.id!);

    // var str;

    // if (widget.prodName!.length >= 15) {
    //   str = widget.prodName!.substring(10);
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ItemDetailsScreen.routeName,
                  arguments: widget.id!);
            },
            child: Hero(
              tag: widget.id!,
              child: Image.network(
                widget.img!,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            leading: IconButton(
              icon: loadedProd.isFavorite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite,
                    ),
              onPressed: () {
                setState(() {
                  loadedProd.toggleFavorite();
                });
              },
            ),
            title: Text(
              widget.prodType.toString(),
            ),
            trailing: IconButton(
              icon: loadedProd.isWant ? Icon(Icons.done) : Icon(Icons.add),
              onPressed: () {
                setState(() {
                  loadedProd.toggleWant();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
