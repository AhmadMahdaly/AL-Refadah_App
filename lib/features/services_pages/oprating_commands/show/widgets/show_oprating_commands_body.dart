import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowOpratingCommandsBody extends StatelessWidget {
  const ShowOpratingCommandsBody({required this.data, super.key});
  final GetAllOperatingsModel data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رقم أمر التشغيل',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kMainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                height: 1.43.h,
              ),
            ),
            Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                border: Border.all(color: kGrayColor),
              ),
              child: Text(data.fOperatingNo),
            ),

            Text(
              'عدد الحافلات',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kMainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                height: 1.43.h,
              ),
            ),
            Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                border: Border.all(color: kGrayColor),
              ),
              child: Text(data.fBusAco.toString()),
            ),
            Text(
              'نوع النقل',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kMainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                height: 1.43.h,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRadioOption(title: 'تقليدي', value: '1'),
                buildRadioOption(title: 'ترددي', value: '2'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioOption({required String value, required String title}) {
    final isSelected = value == data.fTransportType.toString();

    return Container(
      width: 170.w,
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1,
          color: isSelected ? kMainColor : const Color(0xFFD6D6D6),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? kMainColor : Colors.grey,
              size: 20.sp,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? kMainColor : const Color(0xFFD6D6D6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.71.h,
            ),
          ),
        ],
      ),
    );
  }
}
