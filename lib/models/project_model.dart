class Project {
  final String name;
  final String description;
  final String projectScope;
  final String projectManager;
  final int criticalImportanceLevel;
  final bool isLegalObligation;
  final int minBudget;
  final int maxBudget;
  final int predictedBudget;
  final int minDuration;
  final int maxDuration;
  final int predictedDuration;
  final int projectDifficulty;
  final int minReturn;
  final int maxReturn;
  final int predictedReturn;
  final String successMetrics;
  final List<String> sponsors;
  final int priority;
  final bool isApproved;

  Project({
    required this.name,
    required this.description,
    required this.projectScope,
    required this.projectManager,
    required this.criticalImportanceLevel,
    required this.isLegalObligation,
    required this.minBudget,
    required this.maxBudget,
    required this.predictedBudget,
    required this.minDuration,
    required this.maxDuration,
    required this.predictedDuration,
    required this.projectDifficulty,
    required this.minReturn,
    required this.maxReturn,
    required this.predictedReturn,
    required this.successMetrics,
    required this.sponsors,
    required this.priority,
    required this.isApproved,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      projectScope: json['projectScope'] ?? '',
      projectManager: json['projectManager'] ?? '',
      criticalImportanceLevel: json['criticalImportanceLevel'] ?? 0,
      isLegalObligation: json['isLegalObligation'] ?? false,
      minBudget: json['minBudget'] ?? 0,
      maxBudget: json['maxBudget'] ?? 0,
      predictedBudget: json['predictedBudget'] ?? 0,
      minDuration: json['minDuration'] ?? 0,
      maxDuration: json['maxDuration'] ?? 0,
      predictedDuration: json['predictedDuration'] ?? 0,
      projectDifficulty: json['projectDifficulty'] ?? 0,
      minReturn: json['minReturn'] ?? 0,
      maxReturn: json['maxReturn'] ?? 0,
      predictedReturn: json['predictedReturn'] ?? 0,
      successMetrics: json['successMetrics'] ?? '',
      sponsors: List<String>.from(json['sponsors'] ?? []),
      priority: json['priority'] ?? 0,
      isApproved: json['isApproved'] ?? false,
    );
  }
}


List<Project> mockProjects = [
  Project(
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
