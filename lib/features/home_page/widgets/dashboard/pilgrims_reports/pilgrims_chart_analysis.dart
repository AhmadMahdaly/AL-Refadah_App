import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        (allData.totalPilgrims ?? 0) +
        (allData.totalStagePilgrims ?? 0) +
        (allData.totalEvacueesPilgrims ?? 0) +
        (allData.totalArrivedPilgrims ?? 0) +
        (allData.totalRemainingPilgrims ?? 0);
    final radius = 80.r;
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
      /// إجمالي الذين وصلوا للمشعر
      PieChartSectionData(
        radius: radius,
        value: allData.totalArrivedPilgrims?.toDouble(),
        color: Colors.purple[100],
        title:
            '${((allData.totalArrivedPilgrims! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: Colors.black45, fontSize: 12.sp),
      ),

      /// إجمالي الذين تم اخلاؤهم
      PieChartSectionData(
        radius: radius,
        value: allData.totalEvacueesPilgrims?.toDouble(),
        color: Colors.purple[300],
        title:
            '${((allData.totalEvacueesPilgrims! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي حجاج المرحلة
      PieChartSectionData(
        radius: radius,
        value: allData.totalStagePilgrims?.toDouble(),
        color: Colors.purple[400],
        title:
            '${((allData.totalStagePilgrims! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي الحجاج المتبقين
      PieChartSectionData(
        radius: radius,
        value: allData.totalRemainingPilgrims?.toDouble(),
        color: Colors.purple[600],
        title:
            '${((allData.totalRemainingPilgrims! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),

      /// إجمالي عدد الحجاج
      PieChartSectionData(
        radius: radius,
        value: allData.totalPilgrims?.toDouble(),
        color: Colors.purple[800],
        title:
            '${((allData.totalPilgrims! / total) * 100).toStringAsFixed(2)}%',
        titleStyle: TextStyle(color: kMainExtrimeLightColor, fontSize: 12.sp),
      ),
    ];
  }

  Widget _buildLegend() {
    final legends = [
      ['إجمالي عدد الحجاج', Colors.purple[800]],
      ['إجمالي الحجاج المتبقين', Colors.purple[600]],
      ['إجمالي حجاج المرحلة', Colors.purple[400]],
      ['إجمالي الذين تم اخلاؤهم', Colors.purple[300]],
      ['إجمالي الواصلين للمشعر', Colors.purple[100]],
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
                const SizedBox(width: 4),
                Text(legend[0]! as String, style: TextStyle(fontSize: 14.sp)),
              ],
            );
          }).toList(),
    );
  }
}
