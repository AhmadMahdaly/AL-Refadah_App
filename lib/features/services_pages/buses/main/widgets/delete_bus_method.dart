import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';

Future<String?> deleteBusMethod(BuildContext context, GetAllBusesModel bus) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return BlocListener<BusesCubit, BusesState>(
        listenWhen:
            (previous, current) =>
                previous.isDeletedBus != current.isDeletedBus ||
                previous.showDeleteErrorDialog != current.showDeleteErrorDialog,

        listener: (context, state) async {
          if (state.isDeletedBus) {
            showSuccessDialog(
              context,
              title: 'تم حذف الحافلة بنجاح',
              seconds: 1,
            );

            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                Navigator.pop(context);
                context.read<BusesCubit>().getAllBuses();
              }
            });
          } else if (state.showDeleteErrorDialog) {
            Navigator.pop(context);
            showErrorDialog(
              isBack: true,
              context,
              message: 'هناك خطأ في حذف الحافلة',
              icon: Icons.error_outline_rounded,
              color: kErrorColor,
            );

            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            context.read<BusesCubit>().emit(
              state.copyWith(showDeleteErrorDialog: false),
            );
          }
        },
        child: BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            final cubit = context.read<BusesCubit>();

            return AlertDialog(
              backgroundColor: kScaffoldBackgroundColor,
              title: SizedBox(
                width: 200.w,
                child: Text(
                  'هل أنت متأكد من حذف الحافلة؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              actions: [
                if (state.isLoadingDeleteBus || state.isLoadingAllBuses)
                  const AppIndicator()
                else
                  Row(
                    spacing: 12.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await cubit.deleteBus(
                              bus.fCenterNo,
                              bus.fStageNo,
                              bus.fBusNo,
                              int.parse(bus.fBusId),
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
