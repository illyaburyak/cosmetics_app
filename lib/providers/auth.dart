import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/httpExeption.dart';

final String key = 'AIzaSyDD5XDgnJiM80wkreNTr0w_xZVQzARzEnc';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expriryDate;
  String? _userId;
  // Timer? _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expriryDate != null &&
        // if the day after now, its valid. if its before now, its invalid
        _expriryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return '';
  }

  String get userId {
    return _userId!;
  }

  Future<void> _auth(String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$key');

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final resData = json.decode(res.body);
      print(resData['error']);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }

      // getting from firebase
      _token = resData['idToken'];
      _userId = resData['localId'];
      _expriryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            resData['expiresIn'],
          ),
        ),
      );
      notifyListeners();

      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(
      //   {
      //     'toekn': _token,
      //     'userId': _userId,
      //     'expriryDate': _expriryDate?.toIso8601String(),
      //   },
      // );

      // prefs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _auth(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _auth(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expriryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
