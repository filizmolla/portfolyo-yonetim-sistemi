import 'package:flutter/material.dart';
import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/models/roles_model.dart';
import 'package:untitled/services/api_service.dart';

class RolesTable extends StatefulWidget {
  const RolesTable({Key? key}) : super(key: key);

  @override
  RolesTableState createState() => RolesTableState();
}

class RolesTableState extends State<RolesTable> {
  late Future<List<Role>> futureRoles;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    futureRoles = apiService.fetchRoles();
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
            "Roles Table",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder<List<Role>>(
            future: futureRoles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("No roles available");
              } else {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(label: Text("Role Name")),
                        DataColumn(label: Text("Max Slot")),
                        DataColumn(label: Text("Occupied")),
                        DataColumn(label: Text("Available")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                            (index) => roleDataRow(snapshot.data![index], context),
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

  DataRow roleDataRow(Role roleInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Container(
            width: 100, // Set the maximum width for the description column
            child: Text(
              roleInfo.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Text(roleInfo.maxSlot.toString())),
        DataCell(Text(roleInfo.occupied.toString())),
        DataCell(Text(roleInfo.available.toString())),
        DataCell(
          Row(
            children: [
              TextButton(
                child: Text("Edit", style: TextStyle(color: Colors.blueAccent)),
                onPressed: () {
                  _editRoleDialog(context, roleInfo);
                },
              ),
              TextButton(
                child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
                onPressed: () async {
                  try {
                    await apiService.deleteRole(roleInfo.id!);
                    setState(() {
                      futureRoles = apiService.fetchRoles();
                    });
                  } catch (e) {
                    print('Error deleting role: $e');
                    // Handle error
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editRoleDialog(BuildContext context, Role roleInfo) {
    TextEditingController nameController = TextEditingController(text: roleInfo.name);
    TextEditingController maxSlotController = TextEditingController(text: roleInfo.maxSlot.toString());
    TextEditingController occupiedController = TextEditingController(text: roleInfo.occupied.toString());
    TextEditingController availableController = TextEditingController(text: roleInfo.available.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: maxSlotController,
                decoration: InputDecoration(labelText: 'Max Slot'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: occupiedController,
                decoration: InputDecoration(labelText: 'Occupied'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: availableController,
                decoration: InputDecoration(labelText: 'Available'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                roleInfo.name = nameController.text;
                roleInfo.maxSlot = int.parse(maxSlotController.text);
                roleInfo.occupied = int.parse(occupiedController.text);
                roleInfo.available = int.parse(availableController.text);

                try {
                  await apiService.updateRole(roleInfo.id!, roleInfo);
                  setState(() {
                    futureRoles = apiService.fetchRoles();
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating role: $e');
                  // Handle error
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
