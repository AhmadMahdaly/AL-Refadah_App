import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/guides/delete/widgets/widgets/delete_guide_popup.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteGuideCard extends StatelessWidget {
  const DeleteGuideCard({
    required this.employe,
    required this.center,
    super.key,
  });
  final AssignmentModel employe;
  final GetGuidesCenterModel center;
  @override
  Widget build(BuildContext context) {
    final sentence = employe.employee!.fEmpName;
    final words = sentence.split(' ');
    final empName = words.take(3).join(' ');
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        employe.fEmpNo.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: kDartTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 150.w,
                      child: Text(
                        empName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: kDartTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const W(w: 10),
                  ],
                ),
                const H(h: 14),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  'رقم الهوية',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kAnalysisMediumColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  'رقم الجوال',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kAnalysisMediumColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 110.w,
                                child: Text(
                                  'البريد الإلكتروني',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: kAnalysisMediumColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  employe.employee!.fIdNo.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  employe.employee!.fJawNo,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  employe.employee!.fEmail,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 40.w,
              height: 40.h,
              decoration: ShapeDecoration(
                color: kMainExtrimeLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              child: deleteGuidePopupMenuButton(context, employe, center),
            ),
          ],
        ),
        const Divider(color: kAnalysisMediumColor),
      ],
    );
  }
}
