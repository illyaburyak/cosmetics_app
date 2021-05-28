import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/providers/makeUpProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../prodItem/indivItemScreen.dart';

class ItemsScreenGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<MakeUpProvider>(context).makeUpItems;

    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: itemsData.length,
      itemBuilder: (BuildContext context, int index) => IndividItemScreen(
        id: itemsData[index].id,
        img: itemsData[index].img,
        prodName: itemsData[index].prodName,
        prodType: itemsData[index].prodType,
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 10,
      crossAxisSpacing: 30,
    );
  }
}
