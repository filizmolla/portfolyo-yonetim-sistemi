import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart';
import 'package:untitled/screens/projects/edit_project_screen.dart';


class ViewProjectScreen extends StatelessWidget {
  final Project project;

  const ViewProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Project"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfoRow('Project Name', project.name!),
            _buildInfoRow('Description', project.description!),
            _buildInfoRow('Project Scope', project.projectScope!),
            _buildInfoRow('Project Manager', project.projectManager!),
            _buildInfoRow('Critical Importance Level',
                project.criticalImportanceLevel.toString()),
            _buildInfoRow(
                'Is Legal Obligation', project.isLegalObligation.toString()),
            _buildInfoRow('Min Budget', project.minBudget.toString()),
            _buildInfoRow('Max Budget', project.maxBudget.toString()),
            _buildInfoRow(
                'Predicted Budget', project.predictedBudget.toString()),
            _buildInfoRow('Min Duration', project.minDuration.toString()),
            _buildInfoRow('Max Duration', project.maxDuration.toString()),
            _buildInfoRow(
                'Predicted Duration', project.predictedDuration.toString()),
            _buildInfoRow(
                'Project Difficulty', project.projectDifficulty.toString()),
            _buildInfoRow('Min Return', project.minReturn.toString()),
            _buildInfoRow('Max Return', project.maxReturn.toString()),
            _buildInfoRow(
                'Predicted Return', project.predictedReturn.toString()),
            _buildInfoRow('Success Metrics', project.successMetrics!),
            _buildInfoRow('Sponsors', project.sponsors?.join(', ') ?? ''),
            _buildInfoRow('Priority', project.priority.toString()),
            _buildInfoRow('Is Approved', project.isApproved.toString()),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Requirements',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            _buildInfoRow('Backend Developer',
                project.requirements?.first.backendDeveloper.toString() ?? '0'),
            _buildInfoRow('Frontend Developer',
                project.requirements?.first.frontendDeveloper.toString() ?? '0'),
            _buildInfoRow('Analyst',
                project.requirements?.first.analyst.toString() ?? '0'),
            _buildInfoRow(
                'Quality Assurance Tester',
                project.requirements?.first.qualityAssuranceTester.toString() ??
                    '0'),
            _buildInfoRow('DevOps',
                project.requirements?.first.devops.toString() ?? '0'),
            _buildInfoRow(
                'Database Developer',
                project.requirements?.first.databaseDeveloper.toString() ?? '0'),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Strategies',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            _buildInfoRow(
                'Customer Satisfaction',
                project.strategies?.first.customerSatisfaction.toString() ??
                    '0'),
            _buildInfoRow('Future Goals',
                project.strategies?.first.futureGoals.toString() ?? '0'),
            _buildInfoRow(
                'Employee Satisfaction',
                project.strategies?.first.employeeSatisfaction.toString() ??
                    '0'),

            SizedBox(height: 20),
            TextButton(
              child: Text('Edit', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProjectScreen(project: project),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
