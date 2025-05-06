import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses/add/screens/add_bus_page.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_season_dropdown.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusesPage extends StatelessWidget {
  const BusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 100.h,
        title: Text(
          'الحافلات',
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),
        actions: const [CustomHelpButton()],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const GetBusSeasonDropdown(),
              ),
            ],
          ),
        ),
      ),
      body: const BusesBody(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(320.r),
        ),
        backgroundColor: kMainColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBusPage()),
          );
        },
        child: const Icon(Icons.add, color: kMainColorLightColor),
      ),
    );
  }
}
