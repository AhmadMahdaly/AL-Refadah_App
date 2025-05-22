import 'dart:developer';

import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> deleteGuideMethod(
  BuildContext context,
  AssignmentModel employe,
  GetGuidesCenterModel center,
) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocBuilder<GuidesCubit, GuidesState>(
        builder: (context, state) {
          return AlertDialog(
            backgroundColor: kScaffoldBackgroundColor,
            title: SizedBox(
              width: 200.w,
              child: Text(
                'هل أنت متأكد من حذف المرشد',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            actions: [
              if (state.isLoadingdeleteGuide || state.isLoadingGetByCriteria)
                const AppIndicator()
              else
                Row(
                  spacing: 12.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (context.mounted) {
                            try {
                              await context.read<GuidesCubit>().deleteGuide(
                                employe.fCenterNo.toString(),
                                employe.employee?.fEmpNo.toString() ?? '',
                              );

                              showSuccessDialog(
                                seconds: 1,
                                context,
                                title: 'تم حذف المرشد بنجاح',
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              });

                              if (state.isdeleteGuidesSuccess) {
                                if (state.guidesByCriteria.isNotEmpty) {
                                  await context
                                      .read<GuidesCubit>()
                                      .fetchCenters();

                                  await context
                                      .read<GuidesCubit>()
                                      .getGuideByCriteria(
                                        center.fCenterNo.toString(),
                                      );
                                }
                              } else {
                                Navigator.pop(context);
                                showErrorDialog(
                                  isBack: false,
                                  context,
                                  message:
                                      'حدث خطأ أثناء حذف المرشد!\nحاول مرة أخرى أو تواصل مع الدعم.',
                                  icon: Icons.error_outline_rounded,
                                  color: kErrorColor,
                                );
                              }
                            } catch (e) {
                              log(e.toString());
                              showErrorDialog(
                                isBack: true,
                                context,
                                message: 'هناك خطأ في حذف المرشد',
                                icon: Icons.error_outline_rounded,
                                color: kErrorColor,
                              );
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: const Text(
                            'حذف',
                            style: TextStyle(color: kMainExtrimeLightColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: kScaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(width: 1, color: kMainColor),
                          ),
                          child: const Text(
                            'العودة',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      );
    },
  );
}
