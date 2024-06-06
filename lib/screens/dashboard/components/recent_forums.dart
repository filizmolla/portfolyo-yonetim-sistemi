import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/core/utils/colorful_tag.dart';
import 'package:untitled/models/recent_user_model.dart';
import 'package:flutter/material.dart';

class RecentDiscussions extends StatelessWidget {
  const RecentDiscussions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


// Boxların kenarlarını set ediyor okay.
DataRow recentUserDataRow(RecentUser userInfo) {
  return DataRow(
    cells: [
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getRoleColor(userInfo.role).withOpacity(.2),
            border: Border.all(color: getRoleColor(userInfo.role)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(userInfo.role!))),
      DataCell(Text(userInfo.date!)),
      DataCell(Text(userInfo.posts!)),
    ],
  );
}
