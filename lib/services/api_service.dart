import 'dart:convert';
import 'package:http/http.dart' as http;
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



}
