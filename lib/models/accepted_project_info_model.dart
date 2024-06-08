import 'package:untitled/core/constants/color_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


class DailyInfoModel {
  IconData? icon;
  String? title;
  int? projectCount;
  int? projectsTotalBudget;
  int? projectsTotalReturn;
  int? projectsTotalROI;
  List<Color>? colors;
  List<FlSpot>? spots;

  DailyInfoModel({
    this.icon,
    this.title,
    this.projectCount,
    this.projectsTotalBudget,
    this.projectsTotalReturn,
    this.projectsTotalROI,
    this.colors,
    this.spots,
  });

  DailyInfoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    projectCount = json['projectCount'];
    icon = json['icon'];
    projectsTotalBudget = json['projectsTotalBudget'];
    projectsTotalReturn = json['projectsTotalReturn'];
    projectsTotalROI = json['projectsTotalROI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['projectCount'] = this.projectCount;
    data['icon'] = this.icon;
    data['projectsTotalBudget'] = this.projectsTotalBudget;
    data['projectsTotalReturn'] = this.projectsTotalReturn;
    data['projectsTotalROI'] = this.projectsTotalROI;
    data['colors'] = this.colors;
    data['spots'] = this.spots;
    return data;
  }
}