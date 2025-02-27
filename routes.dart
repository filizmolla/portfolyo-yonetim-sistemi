import 'package:flutter/material.dart';
import 'package:untitled/screens/home/home_screen.dart';

class Routes {
  Routes._();

  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
  };
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      });
  }
}
