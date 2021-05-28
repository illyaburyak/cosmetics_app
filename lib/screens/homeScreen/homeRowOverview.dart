import 'package:flutter/material.dart';

import '../prodItem/rowListItemScreen.dart';

class HomwRowOverwie extends StatelessWidget {
  final String? text;
  final String? img;

  const HomwRowOverwie({this.text, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RowListItemScreen.routeName, arguments: text);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                img!,
                height: 100,
              ),
              Positioned(
                width: 100,
                bottom: 2,
                // left: 30,
                child: Container(
                  height: 20,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    text!,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
