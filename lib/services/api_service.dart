import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled/models/project_model.dart';



class ApiService {

  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<List<Project>> fetchApprovedProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects/approved_projects'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<void> addProject(Project projectData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/projects'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 201) {
        // Project added successfully
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
    final response = await http.put(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(project.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update project');
    }
  }

  Future<void> deleteProject(int projectId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:8000/projects/$projectId'),
      );

      if (response.statusCode == 200) {
        fetchProjects();
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



  // Future<List<dynamic>> fetchPredictionResults(
  //     int duration,
  //     int budget,
  //     String caseType,
  //     int customerSatisfaction,
  //     int futureGoals,
  //     int employeeSatisfaction,
  //     ) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         'http://localhost:8000/brute_force/?duration=$duration&budget=$budget&case=$caseType&customer_satisfaction=$customerSatisfaction&future_goals=$futureGoals&employee_satisfaction=$employeeSatisfaction',
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data;
  //     } else {
  //       print('Failed to fetch prediction results. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       throw Exception('Failed to fetch prediction results');
  //     }
  //   } catch (e) {
  //     print('Error occurred while fetching prediction results: $e');
  //     throw e;
  //   }
  // }




}
