import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/add/repo/add_bus_repo.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusButton extends StatelessWidget {
  const AddBusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.sp, left: 16.sp, bottom: 16.sp),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CustomButton(
          text: 'حفظ',
          onTap: () async {
            final state = context.read<AddBusCubit>().state;

            try {
              final buses =
                  state.busForms.map((form) {
                    return AddBusModel(
                      fCompanyId: companyId,
                      fSeasonId: int.parse(
                        context.read<BusesCubit>().selectedSeason!,
                      ),
                      fCenterNo: state.selectedCenter!.fCenterNo,
                      fStageNo: state.selectedStage!.fStageNo,
                      fTransportNo: form.selectedTransport!.fTransportNo,
                      fBusNo: form.busNoController.text,
                      fOperatingNo: state.selectedOperation!.fOperatingNo,
                      fPilgrimsAco:
                          int.tryParse(form.pilgrimsQtyController.text) ?? 0,
                      fTripAco: int.tryParse(form.tripsQtyController.text) ?? 0,
                      fBusStatus: 1,
                      fBusNote: form.notesController.text,
                      fBusIdTrip: form.busNoController.text,
                      fBusId: form.busNoController.text,
                    );
                  }).toList();

              await AddBusesRepo().addBusesData(buses, context);
            } catch (e) {
              showErrorDialog(
                isBack: true,
                context,
                message: 'هناك خطأ في إضافة الحافلة',
              );
            }
          },
        ),
      ),
    );
  }
}
