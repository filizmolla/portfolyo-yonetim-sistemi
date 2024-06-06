import 'package:flutter/cupertino.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/responsive.dart';

import 'package:untitled/screens/dashboard/components/mini_information_card.dart';

import 'package:untitled/screens/dashboard/components/recent_forums.dart';
import 'package:untitled/screens/dashboard/components/recent_users.dart';
import 'package:untitled/screens/dashboard/components/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/projects/components/projects_table.dart';

import '../dashboard/components/header.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        ProjectsTable(),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


