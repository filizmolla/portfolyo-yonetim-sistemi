import 'package:flutter/cupertino.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/responsive.dart';
import 'package:untitled/screens/dashboard/components/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/projects/add_project_screen.dart';
import 'package:untitled/screens/projects/components/project_demands_table.dart';
import '../dashboard/components/header.dart';
import '../forms/input_form.dart';

class ProjectDemandsScreen extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {
                      //TODO: yeni proje ekle sayfasina gitsin!
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProjectScreen(),
                        ),
                      );

                      // Navigator.of(context).push(new MaterialPageRoute<Null>(
                      //     builder: (BuildContext context) {
                      //       return new FormMaterial();
                      //     },
                      //     fullscreenDialog: true));


                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Add New",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {
                      //TODO: brute_force hesaplamaları

                    },
                    icon: Icon(Icons.calculate),
                    label: Text(
                      "Calculate",
                    ),
                  ),
                ],
              ),

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

                        ProjectDemandsTable(),
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


