import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart'; // Replace with your actual project model import
import 'package:untitled/services/api_service.dart'; // Replace with your actual API service import
import 'package:uuid/uuid.dart';

import '../../models/project_model.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
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
  late TextEditingController _priorityController;
  late TextEditingController _isApprovedController;
  late TextEditingController _backendDeveloperController;
  late TextEditingController _frontendDeveloperController;
  late TextEditingController _analystController;
  late TextEditingController _qualityAssuranceTesterController;
  late TextEditingController _devopsController;
  late TextEditingController _databaseDeveloperController;
  late TextEditingController _customerSatisfactionController;
  late TextEditingController _futureGoalsController;
  late TextEditingController _employeeSatisfactionController;


  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _projectScopeController = TextEditingController();
    _projectManagerController = TextEditingController();
    _criticalImportanceLevelController = TextEditingController();
    _isLegalObligationController = TextEditingController();
    _minBudgetController = TextEditingController();
    _maxBudgetController = TextEditingController();
    _predictedBudgetController = TextEditingController();
    _minDurationController = TextEditingController();
    _maxDurationController = TextEditingController();
    _predictedDurationController = TextEditingController();
    _projectDifficultyController = TextEditingController();
    _minReturnController = TextEditingController();
    _maxReturnController = TextEditingController();
    _predictedReturnController = TextEditingController();
    _successMetricsController = TextEditingController();
    _priorityController = TextEditingController();
    _isApprovedController = TextEditingController();
    _backendDeveloperController = TextEditingController();
    _frontendDeveloperController = TextEditingController();
    _analystController = TextEditingController();
    _qualityAssuranceTesterController = TextEditingController();
    _devopsController = TextEditingController();
    _databaseDeveloperController = TextEditingController();
    _customerSatisfactionController = TextEditingController();
    _futureGoalsController = TextEditingController();
    _employeeSatisfactionController = TextEditingController();
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
    _priorityController.dispose();
    _isApprovedController.dispose();
    _backendDeveloperController.dispose();
    _frontendDeveloperController.dispose();
    _analystController.dispose();
    _qualityAssuranceTesterController.dispose();
    _devopsController.dispose();
    _databaseDeveloperController.dispose();
    _customerSatisfactionController.dispose();
    _futureGoalsController.dispose();
    _employeeSatisfactionController.dispose();

    super.dispose();
  }

  int generateRandomProjectId() {
    int minId = 1000;
    int maxId = 9999;
    final random = Random();
    return minId + random.nextInt(maxId - minId + 1);
  }

  Future<void> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      int newId = generateRandomProjectId();

      List<Requirements> requirements = [];
      Requirements requirement = Requirements(
        backendDeveloper:  int.tryParse(_backendDeveloperController.text) ?? 0,
        frontendDeveloper:  int.tryParse(_frontendDeveloperController.text) ?? 0,
        analyst: int.tryParse(_analystController.text) ?? 0,
        qualityAssuranceTester:  int.tryParse(_qualityAssuranceTesterController.text) ?? 0,
        devops:  int.tryParse(_devopsController.text) ?? 0,
        databaseDeveloper:  int.tryParse(_databaseDeveloperController.text) ?? 0,
      );
      requirements.add(requirement);

      List<Strategies> strategies = [];
      Strategies strategy = Strategies(
        customerSatisfaction: int.tryParse(_customerSatisfactionController.text) ?? 0,
        futureGoals: int.tryParse(_futureGoalsController.text) ?? 0,
        employeeSatisfaction: int.tryParse(_employeeSatisfactionController.text) ?? 0,
      );
      strategies.add(strategy);

      Project newProject = Project(
        id: newId,
        name: _nameController.text,
        description: _descriptionController.text,
        projectScope: _projectScopeController.text,
        projectManager: _projectManagerController.text,
        criticalImportanceLevel: int.tryParse(_criticalImportanceLevelController.text) ?? 0,
        isLegalObligation: _isLegalObligationController.text.toLowerCase() == 'true',
        minBudget: int.tryParse(_minBudgetController.text) ?? 0,
        maxBudget: int.tryParse(_maxBudgetController.text) ?? 0,
        predictedBudget: int.tryParse(_predictedBudgetController.text) ?? 0,
        minDuration: int.tryParse(_minDurationController.text) ?? 0,
        maxDuration: int.tryParse(_maxDurationController.text) ?? 0,
        predictedDuration: int.tryParse(_predictedDurationController.text) ?? 0,
        projectDifficulty: int.tryParse(_projectDifficultyController.text) ?? 0,
        minReturn: int.tryParse(_minReturnController.text) ?? 0,
        maxReturn: int.tryParse(_maxReturnController.text) ?? 0,
        predictedReturn: int.tryParse(_predictedReturnController.text) ?? 0,
        successMetrics: _successMetricsController.text,
        priority: int.tryParse(_priorityController.text) ?? 0,
        isApproved: _isApprovedController.text.toLowerCase() == 'true',
        requirements: requirements,
        strategies: strategies,
      );

      await apiService.addProject(newProject);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
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
              TextFormField(
                controller: _priorityController,
                decoration: InputDecoration(labelText: 'Priority'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _isApprovedController,
                decoration: InputDecoration(labelText: 'Is Approved (true/false)'),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Requirements',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  )
              ),
              TextFormField(
                controller: _backendDeveloperController,
                decoration: InputDecoration(labelText: 'Backend Developer Count'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _frontendDeveloperController,
                decoration: InputDecoration(labelText: 'Frontend Developer Count'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _analystController,
                decoration: InputDecoration(labelText: 'Analyst Count'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _qualityAssuranceTesterController,
                decoration: InputDecoration(labelText: 'Quality Assurance Tester Count'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _devopsController,
                decoration: InputDecoration(labelText: 'Devops Count'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _databaseDeveloperController,
                decoration: InputDecoration(labelText: 'Database Developer Count'),
                keyboardType: TextInputType.number,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Strategies',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  )
              ),
              TextFormField(
                controller: _customerSatisfactionController,
                decoration: InputDecoration(labelText: 'Customer Satisfaction (0/1)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _futureGoalsController,
                decoration: InputDecoration(labelText: 'Future Goals (0/1)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _employeeSatisfactionController,
                decoration: InputDecoration(labelText: 'Employee Satisfaction (0/1)'),
                keyboardType: TextInputType.number,
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
