import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart';

class EditProjectPage extends StatefulWidget {
  final Project project;

  const EditProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _predictedBudgetController;
  late TextEditingController _predictedDurationController;
  late TextEditingController _predictedReturnController;
  late bool _isLegalObligation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController = TextEditingController(text: widget.project.description);
    _predictedBudgetController = TextEditingController(text: widget.project.predictedBudget.toString());
    _predictedDurationController = TextEditingController(text: widget.project.predictedDuration.toString());
    _predictedReturnController = TextEditingController(text: widget.project.predictedReturn.toString());
    _isLegalObligation = widget.project.isLegalObligation ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _predictedBudgetController.dispose();
    _predictedDurationController.dispose();
    _predictedReturnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _predictedBudgetController,
              decoration: InputDecoration(labelText: 'Predicted Budget'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _predictedDurationController,
              decoration: InputDecoration(labelText: 'Predicted Duration'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _predictedReturnController,
              decoration: InputDecoration(labelText: 'Predicted Return'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text('Is Legal Obligation'),
              value: _isLegalObligation,
              onChanged: (bool value) {
                setState(() {
                  _isLegalObligation = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the updated project details
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
