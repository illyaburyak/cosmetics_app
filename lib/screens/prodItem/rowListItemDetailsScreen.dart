import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/prodItem/itemDetailsScreen.dart';

class RowListItemDetailsScreen extends StatelessWidget {
  final String? img;
  final String? text;
  final String? descr;
  final String? id;

  const RowListItemDetailsScreen({this.img, this.text, this.descr, this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ItemDetailsScreen.routeName, arguments: id);
                },
                child: Image.network(
                  img!,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Divider(
                thickness: 3,
                color: Colors.black,
                height: 10,
              ),
              ExpansionTile(
                title: Row(
                  children: [
                    Text('See Comment'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                childrenPadding: EdgeInsets.all(16),
                leading: Text(
                  text!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
                children: [
                  Text(
                    descr!,
                    style: TextStyle(fontSize: 18, height: 1.4),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
