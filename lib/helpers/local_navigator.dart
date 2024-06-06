import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/navigation_controller.dart';
import 'package:untitled/core/constants/routes.dart';
import 'package:untitled/routing/router.dart';


import '../controllers/controllers.dart';
import '../routing/router.dart';
Navigator localNavigator() => Navigator(
    key: navigationController.navigationKey,
    initialRoute:  projects,
    onGenerateRoute: generateRoute,
);
