import 'package:provider/provider.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controllers/controllers.dart';
import '../../../controllers/side_menu_controller.dart';
import '../../../core/constants/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: defaultPadding * 3,
                    ),
                    Text("PPMS"),
                    // Image.asset(
                    //   "assets/logo/logo_icon.png",
                    //   scale: 5,
                    // ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text("Smart Portfolio Application")
                  ],
                )),
            DrawerListTile(
              title: "Projects",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                SideMenuController.instance.changeActiveItemTo(dashboard);
                navigationController.navigateTo(dashboard);

              },
            ),
            DrawerListTile(
              title: "Project Demands",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                SideMenuController.instance.changeActiveItemTo(projects);
                navigationController.navigateTo(projects);




              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
