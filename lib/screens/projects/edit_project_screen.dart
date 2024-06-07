import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart';
import 'package:untitled/services/api_service.dart';

class EditProjectScreen extends StatefulWidget {
  final Project project;


  const EditProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  _EditProjectScreenState createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _projectScopeController;
  late TextEditingController _projectManagerController;
  late TextEditingController _criticalImportanceLevelController;
  late TextEditingController _isLegalObligationController;
  late TextEditingController _minBudgetController;
  late TextEditingController _maxBudgetController;
  late TextEditingController _predictedBudgetController;
  late TextEditingController _minDurationController;
  late TextEditingController _maxDurationController;
  late TextEditingController _predictedDurationController;
  late TextEditingController _projectDifficultyController;
  late TextEditingController _minReturnController;
  late TextEditingController _maxReturnController;
  late TextEditingController _predictedReturnController;
  late TextEditingController _successMetricsController;
  //late TextEditingController _sponsorsController;
  late TextEditingController _priorityController;
  late TextEditingController _isApprovedController;

  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController = TextEditingController(text: widget.project.description);
    _projectScopeController = TextEditingController(text: widget.project.projectScope);
    _projectManagerController = TextEditingController(text: widget.project.projectManager);
    _criticalImportanceLevelController = TextEditingController(text: widget.project.criticalImportanceLevel.toString());
    _isLegalObligationController = TextEditingController(text: widget.project.isLegalObligation.toString());
    _minBudgetController = TextEditingController(text: widget.project.minBudget.toString());
    _maxBudgetController = TextEditingController(text: widget.project.maxBudget.toString());
    _predictedBudgetController = TextEditingController(text: widget.project.predictedBudget.toString());
    _minDurationController = TextEditingController(text: widget.project.minDuration.toString());
    _maxDurationController = TextEditingController(text: widget.project.maxDuration.toString());
    _predictedDurationController = TextEditingController(text: widget.project.predictedDuration.toString());
    _projectDifficultyController = TextEditingController(text: widget.project.projectDifficulty.toString());
    _minReturnController = TextEditingController(text: widget.project.minReturn.toString());
    _maxReturnController = TextEditingController(text: widget.project.maxReturn.toString());
    _predictedReturnController = TextEditingController(text: widget.project.predictedReturn.toString());
    _successMetricsController = TextEditingController(text: widget.project.successMetrics);
    //_sponsorsController = TextEditingController(text: widget.project.sponsors.join(', '));
    _priorityController = TextEditingController(text: widget.project.priority.toString());
    _isApprovedController = TextEditingController(text: widget.project.isApproved.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _projectScopeController.dispose();
    _projectManagerController.dispose();
    _criticalImportanceLevelController.dispose();
    _isLegalObligationController.dispose();
    _minBudgetController.dispose();
    _maxBudgetController.dispose();
    _predictedBudgetController.dispose();
    _minDurationController.dispose();
    _maxDurationController.dispose();
    _predictedDurationController.dispose();
    _projectDifficultyController.dispose();
    _minReturnController.dispose();
    _maxReturnController.dispose();
    _predictedReturnController.dispose();
    _successMetricsController.dispose();
    //_sponsorsController.dispose();
    _priorityController.dispose();
    _isApprovedController.dispose();
    super.dispose();
  }

  Future<void> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      Project updatedProject = Project(
        id: widget.project.id,
        name: _nameController.text,
        description: _descriptionController.text,
        projectScope: _projectScopeController.text,
        projectManager: _projectManagerController.text,
        criticalImportanceLevel: int.parse(_criticalImportanceLevelController.text),
        isLegalObligation: _isLegalObligationController.text.toLowerCase() == 'true',
        minBudget: int.parse(_minBudgetController.text),
        maxBudget: int.parse(_maxBudgetController.text),
        predictedBudget: int.parse(_predictedBudgetController.text),
        minDuration: int.parse(_minDurationController.text),
        maxDuration: int.parse(_maxDurationController.text),
        predictedDuration: int.parse(_predictedDurationController.text),
        projectDifficulty: int.parse(_projectDifficultyController.text),
        minReturn: int.parse(_minReturnController.text),
        maxReturn: int.parse(_maxReturnController.text),
        predictedReturn: int.parse(_predictedReturnController.text),
        successMetrics: _successMetricsController.text,
        //sponsors: _sponsorsController.text.split(',').map((e) => e.trim()).toList(),
        priority: int.parse(_priorityController.text),
        isApproved: _isApprovedController.text.toLowerCase() == 'true',
      );

      await apiService.updateProject(widget.project.id, updatedProject);
      Navigator.pop(context, updatedProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Project"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Project Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _projectScopeController,
                decoration: InputDecoration(labelText: 'Project Scope'),
              ),
              TextFormField(
                controller: _projectManagerController,
                decoration: InputDecoration(labelText: 'Project Manager'),
              ),
              TextFormField(
                controller: _criticalImportanceLevelController,
                decoration: InputDecoration(labelText: 'Critical Importance Level'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _isLegalObligationController,
                decoration: InputDecoration(labelText: 'Is Legal Obligation (true/false)'),
              ),
              TextFormField(
                controller: _minBudgetController,
                decoration: InputDecoration(labelText: 'Min Budget'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _maxBudgetController,
                decoration: InputDecoration(labelText: 'Max Budget'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _predictedBudgetController,
                decoration: InputDecoration(labelText: 'Predicted Budget'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a predicted budget';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _minDurationController,
                decoration: InputDecoration(labelText: 'Min Duration'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _maxDurationController,
                decoration: InputDecoration(labelText: 'Max Duration'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _predictedDurationController,
                decoration: InputDecoration(labelText: 'Predicted Duration'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a predicted duration';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _projectDifficultyController,
                decoration: InputDecoration(labelText: 'Project Difficulty'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _minReturnController,
                decoration: InputDecoration(labelText: 'Min Return'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _maxReturnController,
                decoration: InputDecoration(labelText: 'Max Return'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _predictedReturnController,
                decoration: InputDecoration(labelText: 'Predicted Return'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a predicted return';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _successMetricsController,
                decoration: InputDecoration(labelText: 'Success Metrics'),
              ),
              // TextFormField(
              //   controller: _sponsorsController,
              //   decoration: InputDecoration(labelText: 'Sponsors (comma separated)'),
              // ),
              TextFormField(
                controller: _priorityController,
                decoration: InputDecoration(labelText: 'Priority'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _isApprovedController,
                decoration: InputDecoration(labelText: 'Is Approved (true/false)'),
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
