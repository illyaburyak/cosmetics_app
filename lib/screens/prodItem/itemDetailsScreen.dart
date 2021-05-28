import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/widgets/ratingAlert.dart';
import 'package:provider/provider.dart';

import '../../providers/commentsProvider.dart';
import '../../providers/makeUp.dart';
import '../../providers/makeUpProvider.dart';
import '../../widgets/ItemCommentView.dart';
import 'additemComment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ItemDetailsScreen extends StatefulWidget {
  static const routeName = '/item-details-screen';

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var _showComments = false;

  @override
  Widget build(BuildContext context) {
    final allComments = Provider.of<CommentsProvider>(context).getAllComments;
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProd =
        Provider.of<MakeUpProvider>(context, listen: true).findById(prodId);

    var str;

    if (loadedProd.prodName!.length >= 15) {
      str = loadedProd.prodName!.substring(10);
    } else if (loadedProd.prodName!.length >= 25) {
      str = loadedProd.prodName!.substring(20);
    }

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      loadedProd.toggleFavorite();
                    });
                  },
                  icon: loadedProd.isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                )
              ],
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: loadedProd.id!,
                  child: Image.network(
                    loadedProd.img!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showComments = false;
                                });
                              },
                              icon: Icon(Icons.info),
                              label: Text('Details'),
                            ),
                            TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showComments = true;
                                });
                              },
                              icon: Icon(Icons.preview),
                              label: Text('Review'),
                            ),
                          ],
                        ),
                        Divider(height: 10),
                        if (!_showComments)
                          _buildDetails(str: str, loadedProd: loadedProd),
                        if (!_showComments) Divider(height: 60),
                        if (!_showComments)
                          _buildBtnAndPrice(loadedProd: loadedProd),
                        if (_showComments)
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Container(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      loadedProd.isBought
                                          ? Navigator.of(context).pushNamed(
                                              AdditemComment.routeName)
                                          : Alert(
                                              context: context,
                                              type: AlertType.warning,
                                              title:
                                                  "You have not bought this product",
                                              desc:
                                                  "You can only read comments",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  width: 120,
                                                )
                                              ],
                                            ).show();
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text('Leave comment'),
                                  ),
                                ),
                                Container(
                                  height: 500,
                                  child: ListView.builder(
                                    itemCount: allComments.length,
                                    itemBuilder: (context, index) =>
                                        ChangeNotifierProvider.value(
                                      value: allComments[index],
                                      child: ItemCommentView(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildBtnAndPrice extends StatefulWidget {
  final MakeUp loadedProd;
  const _buildBtnAndPrice({
    required this.loadedProd,
  });

  @override
  __buildBtnAndPriceState createState() => __buildBtnAndPriceState();
}

class __buildBtnAndPriceState extends State<_buildBtnAndPrice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isClicked;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isClicked = true;
  }

  @override
  void dispose() {
    alertWindow(context);
    _isClicked = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: _scaffoldKey,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  focusColor: Colors.red,
                  onTap: () {
                    setState(() {
                      widget.loadedProd.toggleWant();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          widget.loadedProd.isWant ? Colors.red : Colors.black,
                      border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(
                          72,
                          209,
                          204,
                          1,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                        10.0,
                      ) //                 <--- border radius here
                          ),
                    ),
                    child: Text(
                      'Want',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    _isClicked
                        ? alertWindow(_scaffoldKey.currentContext!)
                        : null;
                    setState(() {
                      _isClicked = false;
                      widget.loadedProd.toggleBought();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.loadedProd.isBought
                          ? Colors.red
                          : Colors.black,
                      border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(
                          72,
                          209,
                          204,
                          1,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                        10.0,
                      ) //                 <--- border radius here
                          ),
                    ),
                    child: Text(
                      'Bought',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              widget.loadedProd.price.toString(),
            ),
          )
        ],
      ),
    );
  }
}

class _buildDetails extends StatelessWidget {
  const _buildDetails({
    required this.str,
    required this.loadedProd,
  });

  final str;
  final MakeUp loadedProd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15.0, bottom: 15, left: 20, right: 20),
          child: Text(
            str.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10.0, bottom: 15, left: 20, right: 20),
          child: Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            loadedProd.desc!,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
