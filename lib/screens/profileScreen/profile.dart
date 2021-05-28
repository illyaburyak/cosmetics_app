import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/profileScreen/profileGrid.dart';

import '../../widgets/drawer.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        elevation: 0,
        title: Text('My Profile'),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://cdn.motor1.com/images/mgl/vEJmQ/s1/bmw-i8-m-rendering.jpg',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: ProfileGrid(),
    );
  }
}
