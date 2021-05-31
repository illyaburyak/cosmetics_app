import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/providers/makeUpProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../prodItem/indivItemScreen.dart';

class ItemsScreenGrid extends StatefulWidget {
  @override
  _ItemsScreenGridState createState() => _ItemsScreenGridState();
}

class _ItemsScreenGridState extends State<ItemsScreenGrid> {
  var _init = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MakeUpProvider>(context).fetchAndSetMakeUp().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final _makeUpData = Provider.of<MakeUpProvider>(context);
    final _makeUps = _makeUpData.makeUpItems;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: _makeUps.length,
            itemBuilder: (BuildContext context, int index) => IndividItemScreen(
              id: _makeUps[index].id,
              img: _makeUps[index].img,
              prodName: _makeUps[index].prodName,
              prodType: _makeUps[index].prodType,
            ),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 3 : 2),
            mainAxisSpacing: 10,
            crossAxisSpacing: 30,
          );
  }
}
