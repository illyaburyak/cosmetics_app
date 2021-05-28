import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/commentsProvider.dart';

class AdditemComment extends StatefulWidget {
  static const routeName = '/add-item-comment';

  @override
  _AdditemCommentState createState() => _AdditemCommentState();
}

class _AdditemCommentState extends State<AdditemComment> {
  final _form = GlobalKey<FormState>();
  final _imgUrlController = TextEditingController();
  final _imgFocus = FocusNode();

  var _newComment = Comment(
    id: null,
    img: '',
    descr: '',
    rate: 0,
  );

  void _updateImageUrl() {
    if (!_imgFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _imgFocus.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _imgFocus.removeListener(_updateImageUrl);
    _imgUrlController.dispose();
    _imgFocus.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState!.save();
    Provider.of<CommentsProvider>(context, listen: false)
        .addComments(_newComment);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Comment'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.blueAccent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Provide a value';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please eneter value more then 0';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    labelText: 'Your rate',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _newComment = Comment(
                      id: null,
                      img: _newComment.img,
                      descr: _newComment.descr,
                      rate: double.parse(value!),
                    );
                  },
                ),
                Divider(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.length <= 10) {
                      return 'Please provide more information';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Your Comments',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _newComment = Comment(
                      id: null,
                      img: _newComment.img,
                      descr: value,
                      rate: _newComment.rate,
                    );
                  },
                ),
                Divider(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 10, right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: _imgUrlController.text.isEmpty
                          ? Text(
                              'Enter a URl',
                              textAlign: TextAlign.center,
                            )
                          : FittedBox(
                              child: Image.network(
                                _imgUrlController.text,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Your Picture',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.url,
                        controller: _imgUrlController,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        textInputAction: TextInputAction.done,
                        focusNode: _imgFocus,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) {
                          _newComment = Comment(
                            id: null,
                            img: value,
                            descr: _newComment.descr,
                            rate: _newComment.rate,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
