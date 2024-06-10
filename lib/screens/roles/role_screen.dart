import 'package:flutter/material.dart';
import 'package:untitled/screens/roles/components/role_table.dart';
import 'package:untitled/services/api_service.dart';

import '../../models/roles_model.dart';

class RoleScreen extends StatelessWidget {

  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RolesTable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRoleDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRoleDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController maxSlotController = TextEditingController();
    TextEditingController occupiedController = TextEditingController();
    TextEditingController availableController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Role'),
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
                final role = Role(
                  name: nameController.text,
                  maxSlot: int.parse(maxSlotController.text),
                  occupied: int.parse(occupiedController.text),
                  available: int.parse(availableController.text),
                );

                try {

                  apiService.addRole(role);
                  Navigator.of(context).pop();
                  // Optionally refresh the table
                  // setState(() {});
                } catch (e) {
                  print('Error adding role: $e');
                  // Handle error
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
