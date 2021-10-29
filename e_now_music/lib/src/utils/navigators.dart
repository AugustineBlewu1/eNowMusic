import 'package:flutter/material.dart';

extension NavigateAndTheme on BuildContext {
  //push
  push({required Widget screen}) {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  void pop() {
    return Navigator.of(this).pop();
  }

  pushReplacement({required context, required Widget screen}) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  removeUntil({required context, required Widget screen}) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => screen),
        (route) => false);
  }

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

showSnackError({String? error}) {
  return ScaffoldMessenger.of(this)
      .showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(error!)));
}

showSnackSuccess( {String? message}) {
  return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
    content: Text(message!),
    backgroundColor: Colors.green,
  ));
}
}
