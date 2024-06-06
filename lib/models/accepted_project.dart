class AcceptedProject {
  final String name;
  final String description;
  final bool isLegalObligation;
  final int predictedBudget;
  final int predictedDuration;
  final int predictedReturn;

  AcceptedProject({
    required this.name,
    required this.description,
    required this.isLegalObligation,
    required this.predictedBudget,
    required this.predictedDuration,
    required this.predictedReturn,
  });
}
List<AcceptedProject> mockProjects = [
  AcceptedProject(
    name: "Project A",
    description: "Description of Project A",
    isLegalObligation: true,
    predictedBudget: 20000,
    predictedDuration: 25,
    predictedReturn: 15000,
  ),
  AcceptedProject(
    name: "Project B",
    description: "Description of Project B",
    isLegalObligation: false,
    predictedBudget: 25000,
    predictedDuration: 30,
    predictedReturn: 18000,
  ),
  AcceptedProject(
    name: "Project C",
    description: "Description of Project C",
    isLegalObligation: true,
    predictedBudget: 18000,
    predictedDuration: 20,
    predictedReturn: 14000,

  ),
  // Add more mock projects as needed
];
