import 'package:flutter/material.dart';
import 'package:untitled/core/constants/routes.dart';
import 'package:untitled/routing/router.dart';
import '../controllers/controllers.dart';
Navigator localNavigator() => Navigator(
    key: navigationController.navigationKey,
    initialRoute:  projects,
    onGenerateRoute: generateRoute,
);
