import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/dashboard/dashboard_screen.dart';
import 'package:untitled/screens/projects/project_demands_screen.dart';

import '../core/constants/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case projects:
      return _getPageRoute(ProjectDemandsScreen());
    case dashboard:
      return _getPageRoute(DashboardScreen());
    default:
      return _getPageRoute(DashboardScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
