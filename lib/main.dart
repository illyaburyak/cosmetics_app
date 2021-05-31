import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/screens/homeScreen/homePage.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/commentsProvider.dart';
import 'providers/homeScreenModel.dart';
import 'providers/makeUpProvider.dart';
import 'screens/authScreen/authScreen.dart';
import 'screens/favoriteScreen/favoriteScreen.dart';
import 'screens/prodItem/additemComment.dart';
import 'screens/prodItem/itemDetailsScreen.dart';
import 'screens/prodItem/rowListItemScreen.dart';
import 'screens/profileScreen/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => MakeUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenModelList(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentsProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xfff1f1f1),
          ),
          home: auth.isAuth ? HomePageScreen() : HomePageScreen(),
          routes: {
            ItemDetailsScreen.routeName: (ctx) => ItemDetailsScreen(),
            RowListItemScreen.routeName: (ctx) => RowListItemScreen(),
            AdditemComment.routeName: (ctx) => AdditemComment(),
            Profile.routeName: (ctx) => Profile(),
            FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          },
        ),
      ),
    );
  }
}
