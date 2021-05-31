import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/makeUp.dart';
import '../../providers/makeUpProvider.dart';
import 'rowListItemDetailsScreen.dart';

class RowListItemScreen extends StatefulWidget {
  static const routeName = '/row-list-item-screen';

  @override
  _RowListItemScreenState createState() => _RowListItemScreenState();
}

class _RowListItemScreenState extends State<RowListItemScreen> {
  var _init = true;

  Future<List<MakeUp>>? _makeUpProd;

  Future<List<MakeUp>> _indivMakeUpProd() async {
    final prodType1 = ModalRoute.of(context)!.settings.arguments as String;
    return await Provider.of<MakeUpProvider>(context, listen: false)
        .findByProdType(prodType1);
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      _makeUpProd = _indivMakeUpProd();
    }
    setState(() {
      _init = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final lol = prodTypeItem.where((e) => e.prodType == prodType1);
    // print(lol);
    print(_makeUpProd!.then((value) => value.first));

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: FutureBuilder<List<MakeUp>>(
        future: _makeUpProd,
        builder: (context, futureData) {
          if (futureData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (futureData.error == null) {
            return Center(child: Text('Sorry some error'));
          } else if (futureData.data == null) {
            return Center(
              child: Text('Sorry'),
            );
          } else {
            return Container(
              child: ListView.builder(
                itemCount: futureData.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: RowListItemDetailsScreen(
                      img: futureData.data![index].img ?? '',
                      text: futureData.data![index].prodType,
                      descr: futureData.data![index].desc,
                      id: futureData.data![index].id,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
