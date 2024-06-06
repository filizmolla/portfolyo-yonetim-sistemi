import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/screens/dashboard/components/calendart_widget.dart';
import 'package:untitled/screens/dashboard/components/charts.dart';
import 'package:untitled/screens/dashboard/components/user_details_mini_card.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarWidget(),
        ],
      ),
    );
  }
}
