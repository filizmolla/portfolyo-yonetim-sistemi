import 'dart:convert';import 'dart:convert';

class Project {
  int id;
  String name;
  String description;
  String? projectScope;
  String? projectManager;
  int? criticalImportanceLevel;
  bool? isLegalObligation;
  int? minBudget;
  int? maxBudget;
  int? predictedBudget;
  int? minDuration;
  int? maxDuration;
  int? predictedDuration;
  int? projectDifficulty;
  int? minReturn;
  int? maxReturn;
  int? predictedReturn;
  String? successMetrics;
  List<String>? sponsors;
  int? priority;
  bool? isApproved;

  Project({
    required this.id,
    required this.name,
    required this.description,
    this.projectScope,
    this.projectManager,
    this.criticalImportanceLevel,
    this.isLegalObligation,
    this.minBudget,
    this.maxBudget,
    this.predictedBudget,
    this.minDuration,
    this.maxDuration,
    this.predictedDuration,
    this.projectDifficulty,
    this.minReturn,
    this.maxReturn,
    this.predictedReturn,
    this.successMetrics,
    this.sponsors,
    this.priority,
    this.isApproved,
  });

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(
      id: json?['id'] ?? 0,
      name: json?['name'] ?? '',
      description: json?['description'] ?? '',
      projectScope: json?['projectScope'],
      projectManager: json?['projectManager'],
      criticalImportanceLevel: json?['criticalImportanceLevel'],
      isLegalObligation: json?['isLegalObligation'],
      minBudget: json?['minBudget'],
      maxBudget: json?['maxBudget'],
      predictedBudget: json?['predictedBudget'],
      minDuration: json?['minDuration'],
      maxDuration: json?['maxDuration'],
      predictedDuration: json?['predictedDuration'],
      projectDifficulty: json?['projectDifficulty'],
      minReturn: json?['minReturn'],
      maxReturn: json?['maxReturn'],
      predictedReturn: json?['predictedReturn'],
      successMetrics: json?['successMetrics'],
      //sponsors: json?['sponsors'] != null ? List<String>.from(json['sponsors']) : null,
      priority: json?['priority'],
      isApproved: json?['isApproved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'projectScope': projectScope,
      'projectManager': projectManager,
      'criticalImportanceLevel': criticalImportanceLevel,
      'isLegalObligation': isLegalObligation,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'predictedBudget': predictedBudget,
      'minDuration': minDuration,
      'maxDuration': maxDuration,
      'predictedDuration': predictedDuration,
      'projectDifficulty': projectDifficulty,
      'minReturn': minReturn,
      'maxReturn': maxReturn,
      'predictedReturn': predictedReturn,
      'successMetrics': successMetrics,
      //'sponsors': sponsors,
      'priority': priority,
      'isApproved': isApproved,
    };
  }
}


List<Project> mockProjects = [
  Project
    (
    id:1,
    //add mock data with fields
    name: "Project A",
    description: "Description of Project A",
    projectScope: "Scope of Project A",
    projectManager: "Manager of Project A",
    criticalImportanceLevel: 5,
    isLegalObligation: true,
    minBudget: 20000,
    maxBudget: 25000,
    predictedBudget: 20000,
    minDuration: 20,
    maxDuration: 25,
    predictedDuration: 25,
    projectDifficulty: 3,
    minReturn: 15000,
    maxReturn: 20000,
    predictedReturn: 15000,
    successMetrics: "Success Metrics of Project A",
    sponsors: ["Sponsor A", "Sponsor B"],
    priority: 1,
    isApproved: true,
  )
  // Add more mock projects as needed
];
