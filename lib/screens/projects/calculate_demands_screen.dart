import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculateDemandsScreen(),
    );
  }
}

class CalculateDemandsScreen extends StatefulWidget {
  @override
  _CalculateDemandsScreenState createState() => _CalculateDemandsScreenState();
}

class _CalculateDemandsScreenState extends State<CalculateDemandsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _durationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _caseController = TextEditingController();
  final _customerSatisfactionController = TextEditingController();
  final _futureGoalsController = TextEditingController();
  final _employeeSatisfactionController = TextEditingController();

  List<dynamic> _apiResponse = [];

  void _calculateProjectDemands() async {
    if (_formKey.currentState!.validate()) {
      final response = await _fetchPredictionResults(
        duration: int.parse(_durationController.text),
        budget: int.parse(_budgetController.text),
        caseType: _caseController.text,
        customerSatisfaction: int.parse(_customerSatisfactionController.text),
        futureGoals: int.parse(_futureGoalsController.text),
        employeeSatisfaction: int.parse(_employeeSatisfactionController.text),
      );

      if (response != null) {
        setState(() {

          _apiResponse = response;
          //print(response);
        });
      }
    }
  }

  Future<List<dynamic>?> _fetchPredictionResults({
    required int duration,
    required int budget,
    required String caseType,
    required int customerSatisfaction,
    required int futureGoals,
    required int employeeSatisfaction,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:8000/brute_force/?duration=$duration&budget=$budget&case=$caseType&customer_satisfaction=$customerSatisfaction&future_goals=$futureGoals&employee_satisfaction=$employeeSatisfaction',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final projectNames = data[1]['project_names'].join(', ');
        final totalBudget = "Total Budget: " + data[1]['total_budget'].toString();
        final totalReturn = "Total Return: " + data[1]['total_return'].toString();
        final totalProfit = "Total Profit: " + data[1]['total_profit'].toString();
        final data_show = [projectNames, totalBudget, totalReturn, totalProfit];

        return data_show;
      } else {
        print('Failed to fetch prediction results. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch prediction results');
      }
    } catch (e) {
      print('Error occurred while fetching prediction results: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Projects'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _durationController,
                      decoration: InputDecoration(labelText: 'Duration'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a duration';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _budgetController,
                      decoration: InputDecoration(labelText: 'Budget'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a budget';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _caseController,
                      decoration: InputDecoration(labelText: 'Case (predicted, worst, best)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a case';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _customerSatisfactionController,
                      decoration: InputDecoration(labelText: 'Customer Satisfaction'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer satisfaction';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _futureGoalsController,
                      decoration: InputDecoration(labelText: 'Future Goals'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter future goals';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _employeeSatisfactionController,
                      decoration: InputDecoration(labelText: 'Employee Satisfaction'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter employee satisfaction';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _calculateProjectDemands,
                      child: Text('Calculate'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (_apiResponse.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Selection Results",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ..._apiResponse.map((result) => Text(result.toString())).toList(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
