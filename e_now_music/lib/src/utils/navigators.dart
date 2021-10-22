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
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}
