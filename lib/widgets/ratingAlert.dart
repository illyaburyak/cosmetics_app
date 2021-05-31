import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class RatingAlert extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _alertWindow(context);
//   }
// }

Future<bool> alertWindow(BuildContext context) async {
  try {
    final window = await Alert(
        context: context,
        title: "Rate the product please",
        content: Column(
          children: <Widget>[
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (ctx, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print('this is rating $rating');
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            height: 50,
            onPressed: () {
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
              });
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]
        //   DialogButton(
        //     height: 50,
        //     onPressed: () => Navigator.pop(context),
        //     child: Text(
        //       "No thank you",
        //       textAlign: TextAlign.center,
        //       softWrap: true,
        //       style: TextStyle(color: Colors.white, fontSize: 20),
        //     ),
        //   ),
        // ],
        ).show();

    return window!;
  } catch (e) {
    print(e);
    throw e;
  }
}
