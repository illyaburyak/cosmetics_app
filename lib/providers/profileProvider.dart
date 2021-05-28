import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final String img;
  final String name;

  ProfileProvider(this.img, this.name);
}
