import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/widgets/custom_help_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses/add/screens/add_bus_page.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_season_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusesPage extends StatelessWidget {
  const BusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'الحافلات'),
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
