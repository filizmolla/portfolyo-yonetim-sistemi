import 'package:flutter/material.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/models/project_model.dart';
import 'package:untitled/services/api_service.dart';

class AcceptedProjectsTable extends StatefulWidget {
  const AcceptedProjectsTable({Key? key}) : super(key: key);

  @override
  AcceptedProjectsTableState createState() => AcceptedProjectsTableState();
}

class AcceptedProjectsTableState extends State<AcceptedProjectsTable> {
  late Future<List<Project>> futureProjects;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    futureProjects = apiService.fetchProjects();
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
            style: Theme.of(context).textTheme.subtitle1,
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
                        DataColumn(label: Text("Operation")),
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
                child: Text('View', style: TextStyle(color: greenColor)),
                onPressed: () {},
              ),
              SizedBox(width: 6),
              TextButton(
                child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Center(
                          child: Column(
                            children: [
                              Icon(Icons.warning_outlined,
                                  size: 36, color: Colors.red),
                              SizedBox(height: 20),
                              Text("Confirm Deletion"),
                            ],
                          ),
                        ),
                        content: Container(
                          color: secondaryColor,
                          height: 70,
                          child: Column(
                            children: [
                              Text("Are you sure want to delete '${projectInfo.name}'?"),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.close, size: 14),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    label: Text("Cancel"),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.delete, size: 14),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      // Add delete functionality here
                                    },
                                    label: Text("Delete"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
