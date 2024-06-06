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
}
