import 'package:flutter/material.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/models/project_model.dart';
import 'package:untitled/services/api_service.dart';

class ProjectsTable extends StatefulWidget {
  const ProjectsTable({Key? key}) : super(key: key);

  @override
  ProjectsTableState createState() => ProjectsTableState();
}

class ProjectsTableState extends State<ProjectsTable> {
  late Future<List<Project>> futureProjects;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    futureProjects = apiService.fetchApprovedProjects();
  }

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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder<List<Project>>(
            future: futureProjects,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("No projects available");
              } else {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(label: Text("Project Name")),
                        DataColumn(label: Text("Description")),
                        DataColumn(label: Text("Is Legal Obligation")),
                        DataColumn(label: Text("Predicted Budget")),
                        DataColumn(label: Text("Predicted Duration")),
                        DataColumn(label: Text("Predicted Return")),
                        DataColumn(label: Text("Reject Project"))

                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                            (index) => projectDataRow(snapshot.data![index], context),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  DataRow projectDataRow(Project projectInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(projectInfo.name)),
        DataCell(Text(projectInfo.description)),
        DataCell(Text(projectInfo.isLegalObligation.toString())),
        DataCell(Text(projectInfo.predictedBudget.toString())),
        DataCell(Text(projectInfo.predictedDuration.toString())),
        DataCell(Text(projectInfo.predictedReturn.toString())),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text("Reject", style: TextStyle(color: Colors.redAccent)),
                onPressed: () async {
                  try {
                    projectInfo.isApproved = false;
                    await apiService.updateProject(projectInfo.id, projectInfo);
                    setState(() {
                      futureProjects = apiService.fetchApprovedProjects();
                    });
                  } catch (e) {
                    print('Error updating project: $e');
                    // Handle error
                  }
                },
              ),
            ],
          ),
        ),
//        DataCell(Text(projectInfo.isApproved.toString()))
      ],
    );
  }
}
