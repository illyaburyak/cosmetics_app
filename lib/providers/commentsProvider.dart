import 'package:flutter/material.dart';

class Comment with ChangeNotifier {
  final String? id;
  final String? img;
  final String? descr;
  final double? rate;

  Comment({
    @required this.id,
    @required this.img,
    @required this.descr,
    @required this.rate,
  });
}

class CommentsProvider with ChangeNotifier {
  List<Comment> _allComments = [
    Comment(
      id: '1',
      img: 'https://cdn.motor1.com/images/mgl/vEJmQ/s1/bmw-i8-m-rendering.jpg',
      descr: 'Soo Cool',
      rate: 8.0,
    ),
  ];

  List<Comment> get getAllComments {
    return [..._allComments];
  }

  void addComments(Comment comment) {
    final newComment = Comment(
      id: DateTime.now().toString(),
      img: comment.img,
      descr: comment.descr,
      rate: comment.rate,
    );
    _allComments.insert(0, newComment);

    notifyListeners();
  }

  void deleteComment(String id) {
    _allComments.removeWhere((el) => el.id == id);
    notifyListeners();
  }
}
