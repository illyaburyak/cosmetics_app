import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../providers/homeScreenModel.dart';
import '../../widgets/drawer.dart';
import 'itemsScreenGrid.dart';
import 'homeRowOverview.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var _darkMode = false;

  @override
  Widget build(BuildContext context) {
    AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          'Fade First',
          textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        ScaleAnimatedText(
          'Then Scale',
          textStyle: TextStyle(fontSize: 20.0, fontFamily: 'Canterbury'),
        ),
      ],
    );

    final scrollInfo =
        Provider.of<HomeScreenModelList>(context).modelHomeScroll;

    return SafeArea(
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          backgroundColor: _darkMode ? Colors.blueGrey : Colors.white,
          title: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.pinkAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('Your'),
                    FlickerAnimatedText('Favorite'),
                    FlickerAnimatedText('Cosmetic'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _darkMode = !_darkMode;
                });
              },
              icon: Icon(
                _darkMode ? Icons.dark_mode : Icons.light_mode,
                color:
                    _darkMode ? Color.fromRGBO(25, 25, 112, 1) : Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(40.0),
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Search",
                  fillColor: Colors.red,
                ),
              ),
            ),
            Container(
              child: Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...scrollInfo
                        .map((e) => HomwRowOverwie(img: e.img, text: e.title))
                        .toList(),
                  ],
                ),
              )),
            ),
            Divider(height: 30),
            Text(
              'Check it out!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(5),
                child: ItemsScreenGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
