import 'package:untitled/core/constants/color_constants.dart';
import 'package:untitled/models/daily_info_model.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.dailyData,
  }) : super(key: key);
  final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

int _value = 1;

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: widget.dailyData.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text("Budget")
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: DropdownButton(
                  icon: Icon(Icons.more_vert, size: 18),
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.button,
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Predicted"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Best"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Worst"),
                      value: 3,
                    ),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      _value = value!; // Assign the value to the selected value
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            height: 8,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.dailyData.volumeData}",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white70),
              ),
              Text(
                widget.dailyData.totalStorage!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    Key? key,
    required this.colors,
    required this.spotsData,
  }) : super(key: key);
  final List<Color>? colors;
  final List<FlSpot>? spotsData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 30,
          // child: LineChart(
          //   LineChartData(
          //       lineBarsData: [
          //         LineChartBarData(
          //             spots: spotsData,
          //             belowBarData: BarAreaData(show: false),
          //             aboveBarData: BarAreaData(show: false),
          //             isCurved: true,
          //             dotData: FlDotData(show: false),
          //             colors: colors,
          //             barWidth: 3),
          //       ],
          //       lineTouchData: LineTouchData(enabled: false),
          //       titlesData: FlTitlesData(show: false),
          //       axisTitleData: FlAxisTitleData(show: false),
          //       gridData: FlGridData(show: false),
          //       borderData: FlBorderData(show: false)),
          // ),
        ),
      ],
    );
  }
}


