import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/favoriteScreen/favoriteScreen.dart';
import 'package:flutter_app_search_cosmetic/screens/homeScreen/homePage.dart';
import 'package:flutter_app_search_cosmetic/screens/profileScreen/profile.dart';

Widget buildDrawer() {
  return Drawer(
    child: SafeArea(
      child: Container(
        color: Colors.indigo,
        padding: EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Cosmetic App',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                height: 30,
                thickness: 5.0,
              ),
              _buildText(
                builText: 'Home',
                buildIcon: (Icons.home),
                myRoute: HomePageScreen.routeName,
              ),
              Divider(
                height: 30,
                thickness: 5.0,
              ),
              _buildText(
                builText: 'Favorite',
                buildIcon: (Icons.favorite),
                myRoute: FavoriteScreen.routeName,
              ),
              Divider(
                height: 30,
                thickness: 5.0,
              ),
              _buildText(
                builText: 'Profile',
                buildIcon: (Icons.person),
                myRoute: Profile.routeName,
              ),
              Divider(
                height: 30,
                thickness: 5.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ignore: camel_case_types
class _buildText extends StatelessWidget {
  final String? builText;
  final IconData? buildIcon;
  final String? myRoute;

  _buildText({
    this.builText,
    this.buildIcon,
    this.myRoute,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(myRoute!);
              },
              icon: Icon(buildIcon)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              builText!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
