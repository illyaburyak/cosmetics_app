import 'package:flutter/material.dart';

class MakeUp with ChangeNotifier {
  final String? id;
  final String? prodName;
  final String? prodBrand;
  final String? desc;
  final double? price;
  final String? category;
  final String? img;
  final String? prodType;
  bool isFavorite;
  bool isWant;
  bool isBought;

  double isRating;

  MakeUp({
    @required this.id,
    @required this.img,
    @required this.prodName,
    @required this.prodBrand,
    @required this.desc,
    @required this.price,
    @required this.category,
    @required this.prodType,
    this.isBought = false,
    this.isFavorite = false,
    this.isRating = 0,
    this.isWant = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  // void togglePopular() {
  //   isPopular = !isPopular;
  //   notifyListeners();
  // }

  void toggleWant() {
    isWant = !isWant;
    notifyListeners();
  }

  void toggleBought() {
    isBought = !isBought;
    notifyListeners();
  }
}
