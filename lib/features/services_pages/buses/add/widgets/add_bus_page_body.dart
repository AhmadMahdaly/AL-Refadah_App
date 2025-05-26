import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_details_card.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusPageBody extends StatefulWidget {
  const AddBusPageBody({super.key});
  @override
  State<AddBusPageBody> createState() => _AddBusPageBodyState();
}

class _AddBusPageBodyState extends State<AddBusPageBody> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final busesCubit = BlocProvider.of<BusesCubit>(context)..getSeasons();
    final addBusCubit = BlocProvider.of<AddBusCubit>(context);
    busesCubit.stream.listen((state) {
      if (state.seasons != null) {
        final session = state.seasons.map((e) => e.fSeasonId);
        if (session.isNotEmpty) {
          busesCubit.selectedSeason = session.last;
        }
      }
    });
    addBusCubit.stream.listen((state) {
      if (busesCubit.selectedSeason != null) {
        addBusCubit.selectedSeason = busesCubit.selectedSeason;
      }
    });
    context
      ..read<AddBusCubit>().loadCenters()
      ..read<AddBusCubit>().loadTransports();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesCubit, BusesState>(
      builder: (context, state) {
        final busesCubit = context.read<BusesCubit>().state;
        return BlocBuilder<AddBusCubit, AddBusState>(
          builder: (context, state) {
            final cubit = context.read<AddBusCubit>();
            return state.centers.isEmpty ||
                    busesCubit.isLoadingAddBus ||
                    busesCubit.isLoadingAllBuses
                ? const AppIndicator()
                : SingleChildScrollView(
                  child: Column(
                    spacing: 12.h,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10.h,
                          children: [
                            const H(h: 12),

                            /// Centers dropdown
                            DropdownButtonFormField<BusesGetCenterModel>(
                              borderRadius: BorderRadius.circular(10.r),
                              isExpanded: true,

                              decoration: InputDecoration(
                                fillColor: kScaffoldBackgroundColor,
                                filled: true,
                                border: textfieldBorderRadius(
                                  kMainColorLightColor,
                                ),
                                focusedBorder: textfieldBorderRadius(
                                  kMainColorLightColor,
                                ),
                                enabledBorder: textfieldBorderRadius(
                                  kMainColorLightColor,
                                ),
                                focusedErrorBorder: textfieldBorderRadius(
                                  Colors.red,
                                ),
                                label: Text(
                                  'المركز',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFFA2A2A2),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),

                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: kMainColor,
                              ),
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 15.sp,
                                fontFamily: 'GE SS Two',
                                fontWeight: FontWeight.w300,
                                height: 1.43.h,
                              ),
                              items:
                                  state.centers.map((center) {
                                    return DropdownMenuItem(
                                      value: center,
                                      child: Text(center.fCenterName),
                                    );
                                  }).toList(),
                              onChanged: (center) {
                                if (center != null) {
                                  cubit.selectCenter(center);
                                }
                              },
                              value: state.selectedCenter,
                            ),

                            /// stages dropdown
                            if (state.selectedCenter != null)
                              DropdownButtonFormField<BusesGetStageModel>(
                                borderRadius: BorderRadius.circular(10.r),
                                isExpanded: true,

                                decoration: InputDecoration(
                                  fillColor: kScaffoldBackgroundColor,
                                  filled: true,
                                  border: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  enabledBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedErrorBorder: textfieldBorderRadius(
                                    Colors.red,
                                  ),
                                  label: Text(
                                    'المرحلة',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFFA2A2A2),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kMainColor,
                                ),
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'GE SS Two',
                                  fontWeight: FontWeight.w300,
                                  height: 1.43.h,
                                ),
                                items:
                                    state.stages.map((stage) {
                                      return DropdownMenuItem(
                                        value: stage,
                                        child: Text(stage.fStageName),
                                      );
                                    }).toList(),
                                onChanged: (stage) {
                                  if (stage != null) {
                                    cubit.selectStage(
                                      stage,
                                      state.selectedCenter!,
                                    );
                                  }
                                },
                                value:
                                    state.stages.contains(state.selectedStage)
                                        ? state.selectedStage
                                        : null,
                              ),

                            /// oprations dropdown
                            if (state.selectedStage != null)
                              DropdownButtonFormField<BusesGetOperatingModel>(
                                borderRadius: BorderRadius.circular(10.r),
                                isExpanded: true,

                                decoration: InputDecoration(
                                  fillColor: kScaffoldBackgroundColor,
                                  filled: true,
                                  border: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  enabledBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedErrorBorder: textfieldBorderRadius(
                                    Colors.red,
                                  ),
                                  label: Text(
                                    'أمر التشغيل',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFFA2A2A2),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kMainColor,
                                ),
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'GE SS Two',
                                  fontWeight: FontWeight.w300,
                                  height: 1.43.h,
                                ),
                                items:
                                    state.operations.map((op) {
                                      return DropdownMenuItem(
                                        value: op,
                                        child: Text(op.fOperatingNo),
                                      );
                                    }).toList(),
                                onChanged: (op) {
                                  if (op != null) {
                                    cubit.selectOperation(op);
                                  }
                                },
                                value:
                                    state.operations.contains(
                                          state.selectedOperation,
                                        )
                                        ? state.selectedOperation
                                        : null,
                              ),
                            H(h: 10.w),
                          ],
                        ),
                      ),

                      /// Bus Card
                      if (state.selectedCenter != null &&
                          state.selectedStage != null &&
                          state.selectedOperation != null) ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.busForms.length,
                          itemBuilder: (context, index) {
                            if (state.busForms.length !=
                                state.formKeys.length) {
                              return const SizedBox();
                            }

                            return AddBusDetailsCard(
                              index: index,
                              formKey: state.formKeys[index],
                            );
                          },
                        ),

                        /// Add new bus card
                        ElevatedButton(
                          onPressed: cubit.addNewBusForm,
                          child: const Text(
                            'إضافة حافلة جديدة',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                      ] else
                        ...[],
                      H(h: 16.h),
                    ],
                  ),
                );
          },
        );
      },
    );
  }
}
