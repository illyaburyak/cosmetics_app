import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/makeUpProvider.dart';
import '../prodItem/itemDetailsScreen.dart';

class FavoriteScreenItem extends StatefulWidget {
  final String? id;
  final String? img;
  final String? prodName;

  const FavoriteScreenItem({this.img, this.prodName, this.id});

  @override
  _FavoriteScreenItemState createState() => _FavoriteScreenItemState();
}

class _FavoriteScreenItemState extends State<FavoriteScreenItem> {
  @override
  Widget build(BuildContext context) {
    final loadedProd =
        Provider.of<MakeUpProvider>(context, listen: true).findById(widget.id!);
    return Container(
      child: Stack(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ItemDetailsScreen.routeName,
                    arguments: widget.id);
              },
              child: ClipRect(
                child: Image.network(
                  widget.img!,
                  fit: BoxFit.cover,
                  width: 200,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      widget.prodName!,
                      softWrap: true,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        loadedProd.toggleFavorite();
                      });
                      // print('Please delete me');
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  'https://www.freepngimg.com/download/bmw/58042-car-coupe-m6-bmw-m3-m2-white.png',
