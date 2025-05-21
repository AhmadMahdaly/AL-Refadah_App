import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_states.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';

Future<String?> deleteOpertionCommandsMethod(
  BuildContext context,
  GetAllOperatingsModel item,
) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocListener<OpratingCommandsCubit, OperatingCommandState>(
        listenWhen:
            (previous, current) =>
                previous.isSuccessDeleteOperating !=
                    current.isSuccessDeleteOperating ||
                previous.showDeleteErrorDialog != current.showDeleteErrorDialog,

        listener: (context, state) async {
          if (state.isSuccessDeleteOperating) {
            showSuccessDialog(
              context,
              seconds: 1,
              title: 'تم حذف أمر التشغيل بنجاح',
            );
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted) Navigator.pop(context);

            await context
                .read<OpratingCommandsCubit>()
                .getAllTransportOperating();
          } else if (state.showDeleteErrorDialog) {
            Navigator.pop(context);
            showErrorDialog(
              isBack: true,
              context,
              message:
                  'حدث خطأ أثناء حذف أمر التشغيل!\nحاول مرة أخرى أو تواصل مع الدعم.',
              icon: Icons.error_outline_rounded,
              color: kErrorColor,
            );

            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            context.read<OpratingCommandsCubit>().emit(
              state.copyWith(showDeleteErrorDialog: false),
            );
          }
        },
        child: BlocBuilder<OpratingCommandsCubit, OperatingCommandState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: kScaffoldBackgroundColor,
              title: SizedBox(
                width: 200.w,
                child: Text(
                  'هل أنت متأكد من حذف أمر التشغيل رقم: ${item.fOperatingNo}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              actions: [
                if (state.isLoadingDeleteOperating)
                  const AppIndicator()
                else
                  Row(
                    spacing: 12.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context
                                .read<OpratingCommandsCubit>()
                                .deleteOperating(
                                  item.fCenterNo.toString(),
                                  item.fOperatingNo,
                                );
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
        ),
      );
    },
  );
}
