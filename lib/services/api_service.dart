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

  // fetchProjects() async {
  //   try {
  //     final response = await http.get(Uri.parse('http://localhost:8000/projects'));
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = json.decode(response.body);
  //       if (data.isNotEmpty) {
  //         columns = data[0].keys.where((key) => !excludedColumns.contains(key)).toList();
  //       }
  //       setState(() {
  //         projects = data.cast<Map<String, dynamic>>();
  //       });
  //     } else {
  //       print('Failed to load projects. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       throw Exception('Failed to load projects');
  //     }
  //   } catch (e) {
  //     print('Error occurred while fetching projects: $e');
  //     throw e;
  //   }
  // }

  Future<void> addProject(Map<String, dynamic> projectData) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/projects'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 201) {
        fetchProjects();
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

  Future<void> updateProject(int projectId, Map<String, dynamic> projectData) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8000/projects/$projectId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 200) {
        fetchProjects();
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
