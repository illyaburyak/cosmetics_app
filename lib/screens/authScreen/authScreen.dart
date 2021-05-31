import 'package:flutter/material.dart';
import 'package:flutter_app_search_cosmetic/models/httpExeption.dart';
import '../../providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignUp, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occurred'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Ok'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
      // this eerror will go from auth if failed validation of data
    } on HttpException catch (e) {
      var errorMessage = 'Auth failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is alredy in use';
      } else if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is to weak';
      } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      const errorMessage = 'Could not auth you. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://raw.githubusercontent.com/oliver-gomes/flutter-loginui/master/assets/images/1.png'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_authMode == AuthMode.Login)
                      Text(
                        'Hello there, \nwelcome back',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      Text(
                        'SignUp into beautiful world \nof you favorite cosmetic',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100]!,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email';
                                }
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100]!,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          if (_authMode == AuthMode.SignUp)
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[100]!,
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                enabled: _authMode == AuthMode.SignUp,
                                validator: _authMode == AuthMode.SignUp
                                    ? (value) {
                                        if (value != _passwordController.text) {
                                          return 'Password do not match!';
                                        }
                                      }
                                    : null,
                                decoration: InputDecoration(
                                  enabled: _authMode == AuthMode.SignUp,
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                    InkWell(
                      onTap: _submit,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: Center(
                          child: Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: _switchAuthMode,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(50),
                          //   color: Color.fromRGBO(49, 39, 79, 1),
                          // ),
                          child: Center(
                            child: Text(
                              '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTED',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
