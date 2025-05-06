import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transport_get_by_criteria_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/widgets/show_transfer_stage_head_title.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTransferStageBody extends StatefulWidget {
  const EditTransferStageBody({required this.center, super.key});
  final TransferStageSharesGetCenterModel center;
  @override
  State<EditTransferStageBody> createState() => _EditTransferStageBodyState();
}

class _EditTransferStageBodyState extends State<EditTransferStageBody> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    BlocProvider.of<TransferStageSharesCubit>(context).getTransportStages();
    BlocProvider.of<TransferStageSharesCubit>(
      context,
    ).getTransportStageByCriteria(
      context.read<TransferStageSharesCubit>().selectedSeasonId.toString(),
      widget.center.fCenterNo.toString(),
    );
  }

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
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 16;
    return BlocBuilder<TransferStageSharesCubit, TransferStageSharesState>(
      builder: (context, state) {
        if (state.isLoadingEditTransportStage ||
            state.isLoadingTransportStages ||
            state.isLoadingTransportStagesByCriteria) {
          return const AppIndicator();
        } else if (state.transportStagesByCriteria != null) {
          final stagesData = state.transportStagesByCriteria;
          final stagesName = state.transportStages;
          return Stack(
            fit: StackFit.expand,
            children: [
              const H(h: 12),
              Column(
                children: [
                  const ShowTransferStageHeadTitle(),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.sp),
                      itemCount: stagesData.length,
                      itemBuilder: (context, index) {
                        final stageName = stagesName[index];
                        if (_pilgrimsControllers.length != stagesData.length) {
                          _pilgrimsControllers = List.generate(
                            stagesData.length,
                            (i) => TextEditingController(
                              text: stagesData[i].fPilgrimsAco.toString(),
                            ),
                          );
                          _busesControllers = List.generate(
                            stagesData.length,
                            (i) => TextEditingController(
                              text: stagesData[i].fBusesAco.toString(),
                            ),
                          );
                          _tripsControllers = List.generate(
                            stagesData.length,
                            (i) => TextEditingController(
                              text: stagesData[i].fTripsAco.toString(),
                            ),
                          );
                        }

                        final matchedStages =
                            stagesData
                                .where(
                                  (att) => att.fStageNo == stageName.fStageNo,
                                )
                                .toList();
                        if (matchedStages.isNotEmpty) {
                          return _createStageCard(
                            stageName,
                            matchedStages.first,
                            index,
                          );
                        }
                        final stageData = stagesData[index];
                        _pilgrimsControllers[index].text =
                            stageData.fStageNo == stageName.fStageNo
                                ? stageData.fPilgrimsAco.toString()
                                : '0';
                        _busesControllers[index].text =
                            stageData.fStageNo == stageName.fStageNo
                                ? stageData.fBusesAco.toString()
                                : '0';
                        _tripsControllers[index].text =
                            stageData.fStageNo == stageName.fStageNo
                                ? stageData.fTripsAco.toString()
                                : '0';
                        return _createStageCard(stageName, stageData, index);
                      },
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: isKeyboardVisible ? -260 : 16,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'حفظ',
                    padding: 16,
                    onTap: () async {
                      try {
                        final stageInputs = List.generate(stagesData.length, (
                          i,
                        ) {
                          return AddTransportStageModel(
                            fStageNo: stagesData[i].fStageNo,
                            fTripsAco: int.parse(_tripsControllers[i].text),
                            fLastUpdate: DateTime.now(),
                            fLastUpdateUser: 1,
                            fLastUpdateSum: 0,
                            fLastUpdateOper: 0,
                            fCompanyId: companyId,
                            fSeasonId: stagesData[i].fSeasonId,
                            fCenterNo: stagesData[i].fCenterNo,
                            fPilgrimsAco: int.parse(
                              _pilgrimsControllers[i].text,
                            ),
                            fBusesAco: int.parse(_busesControllers[i].text),
                          );
                        });

                        await context
                            .read<TransferStageSharesCubit>()
                            .editTransportStage(stageInputs);
                        showSuccessDialog(context);
                        Future.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        });
                      } catch (e) {
                        showErrorDialog(
                          isBack: true,
                          context,
                          message: 'حدث خطأ',
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return NoDataWidget(onPressed: initData);
      },
    );
  }

  Column _createStageCard(
    TransferStageSharesGetStageModel stageName,
    TransferStageSharesGetByCriteriaModel stageData,
    int index,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              SizedBox(
                width: 80.w,
                height: 38.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _pilgrimsControllers[index].text = value;
                  },
                  controller: _pilgrimsControllers[index],
                  fontSize: 11,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),
              SizedBox(
                width: 80.w,
                height: 38.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _busesControllers[index].text = value;
                  },
                  controller: _busesControllers[index],
                  fontSize: 11,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),
              SizedBox(
                width: 80.w,
                height: 38.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _tripsControllers[index].text = value;
                  },
                  controller: _tripsControllers[index],
                  fontSize: 11,
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
