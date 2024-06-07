import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/core/constants/routes.dart';
import 'package:untitled/core/utils/colorful_tag.dart';
import 'package:untitled/models/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import '../../../models/project_model.dart';

class ProjectsTable extends StatelessWidget {
  const ProjectsTable({
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
          Text(
            "Projects Table",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Description"),
                  ),
                  DataColumn(
                    label: Text("Is Legal"),
                  ),
                  DataColumn(
                    label: Text("PBudget"),
                  ),
                  DataColumn(
                    label: Text("PDuration"),
                  ),
                  DataColumn(
                    label: Text("PReturn"),
                  ),

                ],
                rows: List.generate(
                  mockProjects.length,
                      (index) => projectDataRow(mockProjects[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow projectDataRow(Project projectInfo, BuildContext context){
  return DataRow(
    cells:[
      DataCell(Text(projectInfo.name!)),
      DataCell(Text(projectInfo.description!)),
      DataCell(Text(projectInfo.isLegalObligation.toString())),
      DataCell(Text(projectInfo.predictedBudget.toString())),
      DataCell(Text(projectInfo.predictedDuration.toString())),
      DataCell(Text(projectInfo.predictedReturn.toString())),
    ]

  );
}

