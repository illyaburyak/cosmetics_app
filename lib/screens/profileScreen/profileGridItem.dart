import 'package:flutter/material.dart';

class ProfileGridItem extends StatelessWidget {
  final String? id;
  final String? img;
  final String? prodName;

  const ProfileGridItem({this.img, this.prodName, this.id});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        child: Image.network(
          img!,
          fit: BoxFit.fitHeight,
        ),
      ),
      footer: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        height: 50,
        child: Text(
          prodName!,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
