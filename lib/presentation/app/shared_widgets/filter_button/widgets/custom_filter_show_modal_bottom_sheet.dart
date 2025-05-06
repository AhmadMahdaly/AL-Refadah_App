import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilterShowModalBottomSheet extends StatelessWidget {
  const CustomFilterShowModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Filters',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kScaffoldBackgroundColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.50.h,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Divider(color: kBorderColor, thickness: 1.2),
            // PriceFilterWidget(),
            // Divider(color: kBorderColor, thickness: 0.8),
            // GroupOfMemoryRadio(),
            // Divider(color: kBorderColor, thickness: 0.8),
            // GroupOfColorRadio(),
            // Divider(color: kBorderColor, thickness: 0.8),
            // CustomButton(text: 'Result', padding: 16),
          ],
        ),
      ),
    );
  }
}
