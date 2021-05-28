import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/profileScreen/profileGridItem.dart';
import 'package:provider/provider.dart';

import '../../providers/makeUpProvider.dart';

class ProfileGrid extends StatefulWidget {
  @override
  _ProfileGridState createState() => _ProfileGridState();
}

class _ProfileGridState extends State<ProfileGrid> {
  var _isWant = false;
  var _isBought = false;
  var _isComments = false;
  var _isGridView = true;
  var _isSorted = false;

  @override
  Widget build(BuildContext context) {
    final listOfWant = Provider.of<MakeUpProvider>(context).wantItems;
    final listOfBought = Provider.of<MakeUpProvider>(context).boughtItems;

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isWant = true;
                    _isBought = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: _isWant ? 4.0 : 0.0,
                        color: _isWant ? Colors.deepOrange : Colors.indigo,
                      ),
                    ),
                  ),
                  child: Text(
                    'Want',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isBought = true;
                    _isWant = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: _isBought ? 4.0 : 0.0,
                        color: _isBought ? Colors.deepOrange : Colors.indigo,
                      ),
                    ),
                  ),
                  child: Text(
                    'Bought',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isComments = !_isComments;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 4.0, color: Colors.indigo),
                    ),
                  ),
                  child: Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isBought)
                    Text(
                      '${listOfBought.length} items Bought',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  if (_isWant)
                    Text(
                      '${listOfWant.length} items Want',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  Text('Sorted by laste added'),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  icon: _isGridView
                      ? Icon(Icons.grid_view)
                      : Icon(Icons.table_rows)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSorted = !_isSorted;
                    });
                  },
                  icon: Icon(
                    Icons.import_export,
                  )),
              IconButton(onPressed: () {}, icon: Icon(Icons.sim_card_alert)),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                // var icon = (area == 1) ? icon1 : (area == 2) ? icon2 : icon0;
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 40,
                ),
                itemCount: listOfWant.length,
                itemBuilder: (context, index) {
                  if (_isBought && listOfBought.length > 0) {
                    return ProfileGridItem(
                      id: listOfBought[index].id,
                      img: listOfBought[index].img,
                      prodName: listOfBought[index].prodName,
                    );
                  } else if (listOfWant.length < 0) {
                    return Center(
                      child: Text('Sorry no items'),
                    );
                  }
                  if (_isWant && listOfWant.length > 0) {
                    return ProfileGridItem(
                      id: listOfWant[index].id,
                      img: listOfWant[index].img,
                      prodName: listOfWant[index].prodName,
                    );
                  } else if (listOfWant.length < 0) {
                    return Center(
                      child: Text('Sorry no items'),
                    );
                  }
                  return Text('Sorry');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
