import 'package:flutter/cupertino.dart';
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
  late TextEditingController _customerSatisfactionController;
  late TextEditingController _futureGoalsController;
  late TextEditingController _employeeSatisfactionController;

  late TextEditingController _backendDeveloperController;
  late TextEditingController _frontendDeveloperController;
  late TextEditingController _analystController;
  late TextEditingController _qualityAssuranceTesterController;
  late TextEditingController _devopsController;
  late TextEditingController _databaseDeveloperController;


  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8000');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController =
        TextEditingController(text: widget.project.description);
    _projectScopeController =
        TextEditingController(text: widget.project.projectScope);
    _projectManagerController =
        TextEditingController(text: widget.project.projectManager);
    _criticalImportanceLevelController = TextEditingController(
        text: widget.project.criticalImportanceLevel.toString());
    _isLegalObligationController = TextEditingController(
        text: widget.project.isLegalObligation.toString());
    _minBudgetController =
        TextEditingController(text: widget.project.minBudget.toString());
    _maxBudgetController =
        TextEditingController(text: widget.project.maxBudget.toString());
    _predictedBudgetController =
        TextEditingController(text: widget.project.predictedBudget.toString());
    _minDurationController =
        TextEditingController(text: widget.project.minDuration.toString());
    _maxDurationController =
        TextEditingController(text: widget.project.maxDuration.toString());
    _predictedDurationController = TextEditingController(
        text: widget.project.predictedDuration.toString());
    _projectDifficultyController = TextEditingController(
        text: widget.project.projectDifficulty.toString());
    _minReturnController =
        TextEditingController(text: widget.project.minReturn.toString());
    _maxReturnController =
        TextEditingController(text: widget.project.maxReturn.toString());
    _predictedReturnController =
        TextEditingController(text: widget.project.predictedReturn.toString());
    _successMetricsController =
        TextEditingController(text: widget.project.successMetrics);
    //_sponsorsController = TextEditingController(text: widget.project.sponsors.join(', '));
    _priorityController =
        TextEditingController(text: widget.project.priority.toString());
    _isApprovedController =
        TextEditingController(text: widget.project.isApproved.toString());

    _customerSatisfactionController = TextEditingController(
        text: widget.project.strategies?.first.customerSatisfaction
            .toString() ?? '0');
    _futureGoalsController = TextEditingController(
        text: widget.project.strategies?.first.futureGoals.toString() ?? '0');
    _employeeSatisfactionController = TextEditingController(
        text: widget.project.strategies?.first.employeeSatisfaction
            .toString() ?? '0');

    _backendDeveloperController = TextEditingController(
        text: widget.project.requirements?.first.backendDeveloper.toString() ??
            '0');
    _frontendDeveloperController = TextEditingController(
        text: widget.project.requirements?.first.frontendDeveloper.toString() ??
            '0');
    _analystController = TextEditingController(
        text: widget.project.requirements?.first.analyst.toString() ?? '0');
    _qualityAssuranceTesterController = TextEditingController(
        text: widget.project.requirements?.first.qualityAssuranceTester
            .toString() ?? '0');
    _devopsController = TextEditingController(
        text: widget.project.requirements?.first.devops.toString() ?? '0');
    _databaseDeveloperController = TextEditingController(
        text: widget.project.requirements?.first.databaseDeveloper.toString() ??
            '0');
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

    _customerSatisfactionController.dispose();
    _futureGoalsController.dispose();
    _employeeSatisfactionController.dispose();

    _backendDeveloperController.dispose();
    _frontendDeveloperController.dispose();
    _analystController.dispose();
    _qualityAssuranceTesterController.dispose();
    _devopsController.dispose();
    _databaseDeveloperController.dispose();

    super.dispose();
  }

  Future<void> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      List<Requirements> requirements = [];
      Requirements requirement = Requirements(
        backendDeveloper: int.tryParse(_backendDeveloperController.text) ?? 0,
        frontendDeveloper: int.tryParse(_frontendDeveloperController.text) ?? 0,
        analyst: int.tryParse(_analystController.text) ?? 0,
        qualityAssuranceTester: int.tryParse(
            _qualityAssuranceTesterController.text) ?? 0,
        devops: int.tryParse(_devopsController.text) ?? 0,
        databaseDeveloper: int.tryParse(_databaseDeveloperController.text) ?? 0,
      );
      requirements.add(requirement);

      List<Strategies> strategies = [];
      Strategies strategy = Strategies(
        customerSatisfaction: int.tryParse(
            _customerSatisfactionController.text) ?? 0,
        futureGoals: int.tryParse(_futureGoalsController.text) ?? 0,
        employeeSatisfaction: int.tryParse(
            _employeeSatisfactionController.text) ?? 0,
      );
      strategies.add(strategy);

      Project updatedProject = Project(
          id: widget.project.id,
          name: _nameController.text,
          description: _descriptionController.text,
          projectScope: _projectScopeController.text,
          projectManager: _projectManagerController.text,
          criticalImportanceLevel: int.parse(
              _criticalImportanceLevelController.text),
          isLegalObligation: _isLegalObligationController.text.toLowerCase() ==
              'true',
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
          //handle null values
          priority: int.parse(_priorityController.text) ?? 0,
          isApproved: _isApprovedController.text.toLowerCase() == 'true',
          strategies: strategies,
          requirements: requirements
      );

      await apiService.updateProject(widget.project.id!, updatedProject);
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
                decoration: InputDecoration(
                    labelText: 'Critical Importance Level'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _isLegalObligationController,
                decoration: InputDecoration(
                    labelText: 'Is Legal Obligation (true/false)'),
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
                decoration: InputDecoration(
                    labelText: 'Is Approved (true/false)'),
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
                decoration: InputDecoration(labelText: 'Backend Developer'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _frontendDeveloperController,
                decoration: InputDecoration(labelText: 'Frontend Developer'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _analystController,
                decoration: InputDecoration(labelText: 'Analyst'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _qualityAssuranceTesterController,
                decoration: InputDecoration(
                    labelText: 'Quality Assurance Tester'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _devopsController,
                decoration: InputDecoration(labelText: 'DevOps'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _databaseDeveloperController,
                decoration: InputDecoration(labelText: 'Database Developer'),
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
                decoration: InputDecoration(labelText: 'Customer Satisfaction'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _futureGoalsController,
                decoration: InputDecoration(labelText: 'Future Goals'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _employeeSatisfactionController,
                decoration: InputDecoration(labelText: 'Employee Satisfaction'),
                keyboardType: TextInputType.number,
              ),

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

