class Project {
  String? name;
  String? description;
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
  String? sponsors;
  int? priority;
  bool? isApproved;
  int? id;
  List<Strategies>? strategies;
  List<Requirements>? requirements;

  Project(
      {this.name,
      this.description,
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
      this.id,
      this.strategies,
      this.requirements});

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    projectScope = json['projectScope'];
    projectManager = json['projectManager'];
    criticalImportanceLevel = json['criticalImportanceLevel'];
    isLegalObligation = json['isLegalObligation'];
    minBudget = json['minBudget'];
    maxBudget = json['maxBudget'];
    predictedBudget = json['predictedBudget'];
    minDuration = json['minDuration'];
    maxDuration = json['maxDuration'];
    predictedDuration = json['predictedDuration'];
    projectDifficulty = json['projectDifficulty'];
    minReturn = json['minReturn'];
    maxReturn = json['maxReturn'];
    predictedReturn = json['predictedReturn'];
    successMetrics = json['successMetrics'];
    sponsors = json['sponsors'] is List ? json['sponsors'].join(', ') : json['sponsors']; // Adjusting sponsors field
    priority = json['priority'];
    isApproved = json['isApproved'];
    id = json['id'];
    if (json['strategies'] != null) {
      strategies = <Strategies>[];
      json['strategies'].forEach((v) {
        strategies!.add(Strategies.fromJson(v));
      });
    }
    if (json['requirements'] != null) {
      requirements = <Requirements>[];
      json['requirements'].forEach((v) {
        requirements!.add(Requirements.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['projectScope'] = this.projectScope;
    data['projectManager'] = this.projectManager;
    data['criticalImportanceLevel'] = this.criticalImportanceLevel;
    data['isLegalObligation'] = this.isLegalObligation;
    data['minBudget'] = this.minBudget;
    data['maxBudget'] = this.maxBudget;
    data['predictedBudget'] = this.predictedBudget;
    data['minDuration'] = this.minDuration;
    data['maxDuration'] = this.maxDuration;
    data['predictedDuration'] = this.predictedDuration;
    data['projectDifficulty'] = this.projectDifficulty;
    data['minReturn'] = this.minReturn;
    data['maxReturn'] = this.maxReturn;
    data['predictedReturn'] = this.predictedReturn;
    data['successMetrics'] = this.successMetrics;
    data['sponsors'] = this.sponsors;
    data['priority'] = this.priority;
    data['isApproved'] = this.isApproved;
    data['id'] = this.id;
    if (this.strategies != null) {
      data['strategies'] = this.strategies!.map((v) => v.toJson()).toList();
    }
    if (this.requirements != null) {
      data['requirements'] = this.requirements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Strategies {
  int? customerSatisfaction;
  int? futureGoals;
  int? employeeSatisfaction;
  int? id;
  int? projectId;

  Strategies(
      {this.customerSatisfaction,
      this.futureGoals,
      this.employeeSatisfaction,
      this.id,
      this.projectId});

  Strategies.fromJson(Map<String, dynamic> json) {
    customerSatisfaction = json['customer_satisfaction'];
    futureGoals = json['future_goals'];
    employeeSatisfaction = json['employee_satisfaction'];
    id = json['id'];
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_satisfaction'] = this.customerSatisfaction;
    data['future_goals'] = this.futureGoals;
    data['employee_satisfaction'] = this.employeeSatisfaction;
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    return data;
  }
}

class Requirements {
  int? backendDeveloper;
  int? frontendDeveloper;
  int? analyst;
  int? qualityAssuranceTester;
  int? devops;
  int? databaseDeveloper;
  int? id;
  int? projectId;

  Requirements(
      {this.backendDeveloper,
      this.frontendDeveloper,
      this.analyst,
      this.qualityAssuranceTester,
      this.devops,
      this.databaseDeveloper,
      this.id,
      this.projectId});

  Requirements.fromJson(Map<String, dynamic> json) {
    backendDeveloper = json['backend_developer'];
    frontendDeveloper = json['frontend_developer'];
    analyst = json['analyst'];
    qualityAssuranceTester = json['quality_assurance_tester'];
    devops = json['devops'];
    databaseDeveloper = json['database_developer'];
    id = json['id'];
    projectId = json['project_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backend_developer'] = this.backendDeveloper;
    data['frontend_developer'] = this.frontendDeveloper;
    data['analyst'] = this.analyst;
    data['quality_assurance_tester'] = this.qualityAssuranceTester;
    data['devops'] = this.devops;
    data['database_developer'] = this.databaseDeveloper;
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    return data;
  }
}
