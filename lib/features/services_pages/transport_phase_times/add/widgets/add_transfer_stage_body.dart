import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransferStageBody extends StatefulWidget {
  const AddTransferStageBody({required this.center, super.key});
  final TransferStageGetCenterModel center;
  @override
  State<AddTransferStageBody> createState() => _AddTransferStageBodyState();
}

class _AddTransferStageBodyState extends State<AddTransferStageBody> {
  @override
  void initState() {
    BlocProvider.of<TransferStageSharesCubit>(context).getTransportStages();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  /// controllers
  List<TextEditingController> _pilgrimsControllers = [];
  List<TextEditingController> _busesControllers = [];
  List<TextEditingController> _tripsControllers = [];
  @override
  void dispose() {
    for (final controller in _pilgrimsControllers) {
      controller.dispose();
    }
    for (final controller in _busesControllers) {
      controller.dispose();
    }
    for (final controller in _tripsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// padding keyboard
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 16;
    return BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
      builder: (context, state) {
        /// Loading proccess
        if (state.isLoadingAddTransportStage ||
            context.read<HomeCubit>().state.isLoadingAllData ||
            state.isLoadingTransportStages ||
            state.isLoadingTransportStagesByCriteria) {
          return const AppIndicator();

          /// fetch data
        } else if (state.transportStages != null) {
          final stagesName = state.transportStages;

          /// Body Data
          return Stack(
            fit: StackFit.expand,
            children: [
              const H(h: 12),
              Column(
                children: [
                  /// Body Head
                  const ShowTransferStageHeadTitle(),

                  /// Body cards
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: stagesName.length,
                      itemBuilder: (context, index) {
                        final stageName = stagesName[index];
                        if (_pilgrimsControllers.length != stagesName.length) {
                          _pilgrimsControllers = List.generate(
                            stagesName.length,
                            (i) => TextEditingController(),
                          );
                          _busesControllers = List.generate(
                            stagesName.length,
                            (i) => TextEditingController(),
                          );
                          _tripsControllers = List.generate(
                            stagesName.length,
                            (i) => TextEditingController(),
                          );
                        }

                        final matchedStages =
                            stagesName
                                .where(
                                  (att) => att.fStageNo == stageName.fStageNo,
                                )
                                .toList();
                        if (matchedStages.isNotEmpty) {
                          /// Cards
                          return _stageCard(stageName, index);
                        }
                        return _stageCard(stageName, index);
                      },
                    ),
                  ),
                ],
              ),

              /// Saved Button
              Positioned(
                bottom: isKeyboardVisible ? -260 : 16,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'حفظ',
                    padding: 16,
                    onTap: () async {
                      try {
                        final stageInputs = List.generate(stagesName.length, (
                          i,
                        ) {
                          return AddTransportStageModel(
                            fStageNo:
                                int.tryParse(
                                  stagesName[i].fStageNo.toString(),
                                ) ??
                                0,
                            fTripsAco:
                                int.tryParse(_tripsControllers[i].text) ?? 0,
                            fLastUpdate: DateTime.now(),
                            fLastUpdateUser: 1,
                            fLastUpdateSum: 0,
                            fLastUpdateOper: 0,
                            fCompanyId: companyId,
                            fSeasonId:
                                int.tryParse(
                                  context
                                      .read<TransferStageSharesCubit>()
                                      .selectedSeasonId
                                      .toString(),
                                ) ??
                                0,
                            fCenterNo: widget.center.fCenterNo,
                            fPilgrimsAco:
                                int.tryParse(_pilgrimsControllers[i].text) ?? 0,
                            fBusesAco:
                                int.tryParse(_busesControllers[i].text) ?? 0,
                          );
                        });
                        await context
                            .read<TransferStageSharesCubit>()
                            .addTransportStage(stageInputs);
                        await context.read<HomeCubit>().getDashboardData();
                        showSuccessDialog(context, seconds: 1);
                        Future.delayed(const Duration(seconds: 1), () {
                          if (context.mounted) {
                            Navigator.pop(
                              context,
                              state.isLoadingTransportStages,
                            );
                            context
                                .read<TransferStageSharesCubit>()
                                .getCenters();
                          }
                        });
                      } catch (e) {
                        showErrorDialog(
                          isBack: true,
                          context,
                          message: 'هناك خطأ في حفظ البيانات',
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }

        /// when fetch data failed
        return NoDataWidget(
          onPressed:
              () =>
                  context.read<TransferStageSharesCubit>().getTransportStages(),
        );
      },
    );
  }

  /// Cards
  Column _stageCard(TransferStageGetStageModel stageName, int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// اسم المرحلة
              SizedBox(
                width: 100.w,
                child: Text(
                  stageName.fStageName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.43.h,
                  ),
                ),
              ),

              /// خانة عدد الحجاج
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _pilgrimsControllers[index].text = value;
                  },
                  controller: _pilgrimsControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),

              /// خانة عدد الحافلات
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _busesControllers[index].text = value;
                  },
                  controller: _busesControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),

              /// خانة عدد الردود
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _tripsControllers[index].text = value;
                  },
                  controller: _tripsControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
