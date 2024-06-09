import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/project_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});


  //WORKS!!
  Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      // Log the JSON response
      print(jsonResponse);
      return jsonResponse.map<Project>((json) => Project.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  //WORKS
  Future<List<Project>> fetchNonApprovedProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects/non_approved_projects'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map<Project>((json) => Project.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  //WORKS!
  Future<List<Project>> fetchApprovedProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects/approved_projects'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map<Project>((json) => Project.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  //WORKS!!
  Future<void> addProject(Project projectData) async {
    try {
      final projectJson = {
        'project': projectData.toJson(),
        'strategies': {
          'customer_satisfaction': projectData.strategies?.first.customerSatisfaction ?? 0,
          'future_goals': projectData.strategies?.first.futureGoals ?? 0,
          'employee_satisfaction': projectData.strategies?.first.employeeSatisfaction ?? 0,
        },
        'requirements': {
          'backend_developer': projectData.requirements?.first.backendDeveloper ?? 0,
          'frontend_developer': projectData.requirements?.first.frontendDeveloper ?? 0,
          'analyst': projectData.requirements?.first.analyst ?? 0,
          'quality_assurance_tester': projectData.requirements?.first.qualityAssuranceTester ?? 0,
          'devops': projectData.requirements?.first.devops ?? 0,
          'database_developer': projectData.requirements?.first.databaseDeveloper ?? 0,
        }
      };

      print(projectJson);
      // Print the JSON structure
      print('Project JSON: ${jsonEncode(projectJson)}');

      final response = await http.post(
        Uri.parse('$baseUrl/projects'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectJson),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Project added successfully');
      } else {
        print('Failed to add project. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add project');
      }
    } catch (e) {
      print('Error occurred while adding project: $e');
      throw e;
    }
  }


  Future<void> updateProject(int id, Project project) async {
    try {
      final projectJson = {
        'project': project.toJson(),
        'strategies': {
          'customer_satisfaction': project.strategies?.first.customerSatisfaction ?? 0,
          'future_goals': project.strategies?.first.futureGoals ?? 0,
          'employee_satisfaction': project.strategies?.first.employeeSatisfaction ?? 0,
        },
        'requirements': {
          'backend_developer': project.requirements?.first.backendDeveloper ?? 0,
          'frontend_developer': project.requirements?.first.frontendDeveloper ?? 0,
          'analyst': project.requirements?.first.analyst ?? 0,
          'quality_assurance_tester': project.requirements?.first.qualityAssuranceTester ?? 0,
          'devops': project.requirements?.first.devops ?? 0,
          'database_developer': project.requirements?.first.databaseDeveloper ?? 0,
        }
      };

      print('Update Project JSON: ${jsonEncode(projectJson)}');

      final response = await http.put(
        Uri.parse('$baseUrl/projects/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(projectJson),
      );

      if (response.statusCode == 200) {
        print('Project updated successfully');
      } else {
        print('Failed to update project. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update project');
      }
    } catch (e) {
      print('Error occurred while updating project: $e');
      throw e;
    }
  }



  Future<void> deleteProject(int projectId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/projects/$projectId'),
      );

      if (response.statusCode == 200) {
        print('Project deleted successfully');
      } else {
        print('Failed to delete project. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete project');
      }
    } catch (e) {
      print('Error occurred while deleting project: $e');
      throw e;
    }
  }

  Future<List<dynamic>?> getBruteForcePredictedResults({
    required int duration,
    required int budget,
    required String caseType,
    required int customerSatisfaction,
    required int futureGoals,
    required int employeeSatisfaction,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/?duration=$duration&budget=$budget&case=$caseType&customer_satisfaction=$customerSatisfaction&future_goals=$futureGoals&employee_satisfaction=$employeeSatisfaction'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      // Handle error response
      return null;
    }
  }
}
