import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/prodItem/rowListItemDetailsScreen.dart';
import 'package:provider/provider.dart';

import '../../providers/makeUpProvider.dart';

class RowListItemScreen extends StatelessWidget {
  static const routeName = '/row-list-item-screen';

  @override
  Widget build(BuildContext context) {
    final prodType1 = ModalRoute.of(context)!.settings.arguments as String;
    print(prodType1);
    final prodTypeItem =
        Provider.of<MakeUpProvider>(context).findByProdType(prodType1);

    // final lol = prodTypeItem.where((e) => e.prodType == prodType1);
    // print(lol);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: prodTypeItem.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: RowListItemDetailsScreen(
                img: prodTypeItem[index].img,
                text: prodTypeItem[index].prodType,
                descr: prodTypeItem[index].desc,
                id: prodTypeItem[index].id,
              ),
            );
          },
        ),
      ),
    );
  }
}
