import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart';

class EditProjectScreen extends StatefulWidget {
  final Project project;
  const EditProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  _EditProjectScreenState createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController projectScopeController;
  late TextEditingController projectManagerController;
  late TextEditingController criticalImportanceLevelController;
  late bool isLegalObligation;
  late TextEditingController minBudgetController;
  late TextEditingController maxBudgetController;
  late TextEditingController predictedBudgetController;
  late TextEditingController minDurationController;
  late TextEditingController maxDurationController;
  late TextEditingController predictedDurationController;
  late TextEditingController projectDifficultyController;
  late TextEditingController minReturnController;
  late TextEditingController maxReturnController;
  late TextEditingController predictedReturnController;
  late TextEditingController successMetricsController;
  late TextEditingController sponsorsController;
  late TextEditingController priorityController;
  late bool isApproved;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.project.name);
    descriptionController = TextEditingController(text: widget.project.description);
    projectScopeController = TextEditingController(text: widget.project.projectScope);
    projectManagerController = TextEditingController(text: widget.project.projectManager);
    criticalImportanceLevelController = TextEditingController(text: widget.project.criticalImportanceLevel.toString());
    isLegalObligation = widget.project.isLegalObligation;
    minBudgetController = TextEditingController(text: widget.project.minBudget.toString());
    maxBudgetController = TextEditingController(text: widget.project.maxBudget.toString());
    predictedBudgetController = TextEditingController(text: widget.project.predictedBudget.toString());
    minDurationController = TextEditingController(text: widget.project.minDuration.toString());
    maxDurationController = TextEditingController(text: widget.project.maxDuration.toString());
    predictedDurationController = TextEditingController(text: widget.project.predictedDuration.toString());
    projectDifficultyController = TextEditingController(text: widget.project.projectDifficulty.toString());
    minReturnController = TextEditingController(text: widget.project.minReturn.toString());
    maxReturnController = TextEditingController(text: widget.project.maxReturn.toString());
    predictedReturnController = TextEditingController(text: widget.project.predictedReturn.toString());
    successMetricsController = TextEditingController(text: widget.project.successMetrics);
    sponsorsController = TextEditingController(text: widget.project.sponsors.join(", "));
    priorityController = TextEditingController(text: widget.project.priority.toString());
    isApproved = widget.project.isApproved;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    projectScopeController.dispose();
    projectManagerController.dispose();
    criticalImportanceLevelController.dispose();
    minBudgetController.dispose();
    maxBudgetController.dispose();
    predictedBudgetController.dispose();
    minDurationController.dispose();
    maxDurationController.dispose();
    predictedDurationController.dispose();
    projectDifficultyController.dispose();
    minReturnController.dispose();
    maxReturnController.dispose();
    predictedReturnController.dispose();
    successMetricsController.dispose();
    sponsorsController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  void _saveProject() {
    // Implement save functionality
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Project Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: projectScopeController,
                decoration: InputDecoration(labelText: 'Project Scope'),
              ),
              TextField(
                controller: projectManagerController,
                decoration: InputDecoration(labelText: 'Project Manager'),
              ),
              TextField(
                controller: criticalImportanceLevelController,
                decoration: InputDecoration(labelText: 'Critical Importance Level'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                title: Text('Is Legal Obligation'),
                value: isLegalObligation,
                onChanged: (bool value) {
                  setState(() {
                    isLegalObligation = value;
                  });
                },
              ),
              TextField(
                controller: minBudgetController,
                decoration: InputDecoration(labelText: 'Min Budget'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: maxBudgetController,
                decoration: InputDecoration(labelText: 'Max Budget'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: predictedBudgetController,
                decoration: InputDecoration(labelText: 'Predicted Budget'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: minDurationController,
                decoration: InputDecoration(labelText: 'Min Duration'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: maxDurationController,
                decoration: InputDecoration(labelText: 'Max Duration'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: predictedDurationController,
                decoration: InputDecoration(labelText: 'Predicted Duration'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: projectDifficultyController,
                decoration: InputDecoration(labelText: 'Project Difficulty'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: minReturnController,
                decoration: InputDecoration(labelText: 'Min Return'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: maxReturnController,
                decoration: InputDecoration(labelText: 'Max Return'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: predictedReturnController,
                decoration: InputDecoration(labelText: 'Predicted Return'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: successMetricsController,
                decoration: InputDecoration(labelText: 'Success Metrics'),
              ),
              TextField(
                controller: sponsorsController,
                decoration: InputDecoration(labelText: 'Sponsors'),
              ),
              TextField(
                controller: priorityController,
                decoration: InputDecoration(labelText: 'Priority'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                title: Text('Is Approved'),
                value: isApproved,
                onChanged: (bool value) {
                  setState(() {
                    isApproved = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProject,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
