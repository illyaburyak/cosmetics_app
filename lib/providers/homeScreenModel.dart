import 'package:flutter/material.dart';

class HomeScreenModel with ChangeNotifier {
  final String? img;
  final String? title;

  HomeScreenModel({
    @required this.img,
    @required this.title,
  });
}

class HomeScreenModelList with ChangeNotifier {
  List<HomeScreenModel> _modelHomeScroll = [
    HomeScreenModel(
      title: 'Nail Polish',
      img:
          'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png',
    ),
    HomeScreenModel(
      title: 'Blush',
      img:
          'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png',
    ),
    HomeScreenModel(
      title: 'Bronzer',
      img:
          'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png',
    ),
    HomeScreenModel(
        title: 'Eeybrow',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
    HomeScreenModel(
        title: 'Eyeshadow',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
    HomeScreenModel(
        title: 'Foundation',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
    HomeScreenModel(
        title: 'Lip Liner',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
    HomeScreenModel(
        title: 'Lipstick',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
    HomeScreenModel(
        title: 'Mascara',
        img:
            'https://www.purpicks.com/wp-content/uploads/2018/03/lotus-cosmetics-usa-creme-to-powder-blush.png'),
  ];

  List<HomeScreenModel> get modelHomeScroll {
    return [..._modelHomeScroll];
  }
}
