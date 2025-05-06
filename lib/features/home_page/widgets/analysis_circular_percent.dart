import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripsChartExample extends StatelessWidget {
  const TripsChartExample({required this.allData, super.key});
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
        allData.totalDepartingBuses +
        allData.totalFinishedBuses +
        allData.totalStageTrips +
        allData.totalTrips +
        allData.totalStageBuses;
    return [
      /// إجمالي الحافلات المطلقة
      PieChartSectionData(
        radius: radius,
        value: allData.totalDepartingBuses.toDouble(),
        color: Colors.red[100],
        title:
            '${((allData.totalDepartingBuses / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي الحافلات التي أكملت الردود
      PieChartSectionData(
        radius: radius,
        value: allData.totalFinishedBuses.toDouble(),
        color: Colors.red[300],
        title:
            '${((allData.totalFinishedBuses / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي ردود المرحلة
      PieChartSectionData(
        radius: radius,
        value: allData.totalStageTrips.toDouble(),
        color: Colors.red[400],
        title:
            '${((allData.totalStageTrips / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي الردود
      PieChartSectionData(
        radius: radius,
        value: allData.totalTrips.toDouble(),
        color: Colors.red[300],
        title: '${((allData.totalTrips / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي حافلات المرحلة
      PieChartSectionData(
        radius: radius,
        value: allData.totalStageBuses.toDouble(),
        color: Colors.red[800],
        title:
            '${((allData.totalStageBuses / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
    ];
  }

  Widget _buildLegend() {
    final legends = [
      ['إجمالي حافلات المرحلة', Colors.red[800]],
      ['إجمالي الحافلات التي أكملت الردود', Colors.red[600]],
      ['إجمالي ردود المرحلة', Colors.red[400]],
      ['إجمالي الردود', Colors.red[300]],
      ['إجمالي الحافلات المطلقة', Colors.red[100]],
    ];

    return Wrap(
      // alignment: WrapAlignment.center,
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

class PilgrimsChartAnalysis extends StatelessWidget {
  const PilgrimsChartAnalysis({required this.allData, super.key});
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
    final total =
        allData.totalPilgrims +
        allData.totalStagePilgrims +
        allData.totalEvacueesPilgrims +
        allData.totalArrivedPilgrims +
        allData.totalRemainingPilgrims;
    final radius = 80.r;
    return [
      /// إجمالي الذين وصلوا للمشعر
      PieChartSectionData(
        radius: radius,
        value: allData.totalArrivedPilgrims.toDouble(),
        color: Colors.red[100],
        title:
            '${((allData.totalArrivedPilgrims / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي الذين تم اخلاؤهم
      PieChartSectionData(
        radius: radius,
        value: allData.totalEvacueesPilgrims.toDouble(),
        color: Colors.red[300],
        title:
            '${((allData.totalEvacueesPilgrims / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي حجاج المرحلة
      PieChartSectionData(
        radius: radius,
        value: allData.totalStagePilgrims.toDouble(),
        color: Colors.red[400],
        title:
            '${((allData.totalStagePilgrims / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي الحجاج المتبقين
      PieChartSectionData(
        radius: radius,
        value: allData.totalRemainingPilgrims.toDouble(),
        color: Colors.red[600],
        title:
            '${((allData.totalRemainingPilgrims / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي عدد الحجاج
      PieChartSectionData(
        radius: radius,
        value: allData.totalPilgrims.toDouble(),
        color: Colors.red[800],
        title: '${((allData.totalPilgrims / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
    ];
  }

  Widget _buildLegend() {
    final legends = [
      ['إجمالي عدد الحجاج', Colors.red[800]],
      ['إجمالي الحجاج المتبقين', Colors.red[600]],
      ['إجمالي حجاج المرحلة', Colors.red[400]],
      ['إجمالي الذين تم اخلاؤهم', Colors.red[300]],
      ['إجمالي الواصلين للمشعر', Colors.red[100]],
    ];

    return Wrap(
      // alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children:
          legends.map((legend) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(backgroundColor: legend[1]! as Color, radius: 8.r),
                const SizedBox(width: 4),
                Text(legend[0]! as String, style: TextStyle(fontSize: 14.sp)),
              ],
            );
          }).toList(),
    );
  }
}
