import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusesChartAnalysis extends StatelessWidget {
  const BusesChartAnalysis({required this.allData, super.key});
  final DashboardModel allData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210.h,
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(),
              centerSpaceRadius: 0,
              sectionsSpace: 2,
            ),
          ),
        ),
        H(h: 12.h),
        _buildLegend(),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final radius = 85.r;
    final total =
        (allData.totalDepartingBuses ?? 0) +
        (allData.totalFinishedBuses ?? 0) +
        (allData.totalStageTrips ?? 0) +
        (allData.totalTrips ?? 0) +
        (allData.totalStageBuses ?? 0);

    if (total == 0) {
      return [
        PieChartSectionData(
          radius: radius,
          value: 1, // قيمة وهمية حتى تظهر دائرة واحدة بدون تداخل
          color: Colors.grey[300],
          title: 'لا بيانات',
          titleStyle: TextStyle(color: Colors.black45, fontSize: 12.sp),
        ),
      ];
    }

    return [
      PieChartSectionData(
        radius: radius,
        value: allData.totalDepartingBuses?.toDouble(),
        color: chartColor[100],
        title:
            '${((allData.totalDepartingBuses! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: Colors.black45, fontSize: 12.sp),
      ),
      PieChartSectionData(
        radius: radius,
        value: allData.totalFinishedBuses?.toDouble(),
        color: chartColor[300],
        title:
            '${((allData.totalFinishedBuses! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
      PieChartSectionData(
        radius: radius,
        value: allData.totalStageTrips?.toDouble(),
        color: chartColor[400],
        title:
            '${((allData.totalStageTrips! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
      PieChartSectionData(
        radius: radius,
        value: allData.totalTrips?.toDouble(),
        color: chartColor[300],
        title: '${((allData.totalTrips! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
      PieChartSectionData(
        radius: radius,
        value: allData.totalStageBuses?.toDouble(),
        color: chartColor[800],
        title:
            '${((allData.totalStageBuses! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
    ];
  }

  Widget _buildLegend() {
    final legends = [
      ['إجمالي حافلات المرحلة', chartColor[800]],
      ['إجمالي الحافلات التي أكملت الردود', chartColor[600]],
      ['إجمالي ردود المرحلة', chartColor[400]],
      ['إجمالي الردود', chartColor[300]],
      ['إجمالي الحافلات المطلقة', chartColor[100]],
    ];

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          legends.map((legend) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(backgroundColor: legend[1]! as Color, radius: 8.r),
                SizedBox(width: 4.w),
                Text(legend[0]! as String, style: TextStyle(fontSize: 14.sp)),
              ],
            );
          }).toList(),
    );
  }
}
