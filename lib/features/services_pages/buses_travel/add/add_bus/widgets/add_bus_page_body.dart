import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/widgets/add_bus_details_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusPageBody extends StatefulWidget {
  const AddBusPageBody({
    required this.rootContext,
    required this.trip,
    super.key,
  });
  final BuildContext rootContext;
  final BusesTravelGetTripModel trip;
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
    BlocProvider.of<AddBusTripCubit>(
      context,
    ).selectOprating(widget.trip.fCenterNo);
    BlocProvider.of<AddBusTripCubit>(context).loadTransports();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesCubit, BusesState>(
      builder: (context, state) {
        final busesCubit = context.read<BusesCubit>().state;
        return BlocBuilder<AddBusTripCubit, AddBusTripState>(
          builder: (context, state) {
            final cubit = context.read<AddBusTripCubit>();
            return state.operations.isEmpty ||
                    busesCubit.isLoadingAddBus ||
                    busesCubit.isLoadingAllBusesByCrietia
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
                            DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(10.r),
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
                              ),
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 15.sp,
                                fontFamily: 'GE SS Two',
                                fontWeight: FontWeight.w300,
                                height: 1.43.h,
                              ),
                              value: widget.trip.fCenterNo,
                              items: [
                                DropdownMenuItem<String>(
                                  value: widget.trip.fCenterNo,
                                  child: Text(widget.trip.fCenterNo),
                                ),
                              ],

                              onChanged: null,
                            ),
                            // DropdownButtonFormField<BusesGetCenterModel>(
                            //   borderRadius: BorderRadius.circular(10.r),
                            //   isExpanded: true,
                            //   decoration: InputDecoration(
                            //     fillColor: kScaffoldBackgroundColor,
                            //     filled: true,
                            //     border: textfieldBorderRadius(
                            //       kMainColorLightColor,
                            //     ),
                            //     focusedBorder: textfieldBorderRadius(
                            //       kMainColorLightColor,
                            //     ),
                            //     enabledBorder: textfieldBorderRadius(
                            //       kMainColorLightColor,
                            //     ),
                            //     focusedErrorBorder: textfieldBorderRadius(
                            //       Colors.red,
                            //     ),
                            //     label: Text(
                            //       'المركز',
                            //       style: TextStyle(
                            //         fontSize: 13.sp,
                            //         color: const Color(0xFFA2A2A2),
                            //         fontWeight: FontWeight.w300,
                            //       ),
                            //     ),
                            //   ),
                            //   icon: const Icon(
                            //     Icons.keyboard_arrow_down_rounded,
                            //     color: kMainColor,
                            //   ),
                            //   style: TextStyle(
                            //     color: kMainColor,
                            //     fontSize: 15.sp,
                            //     fontFamily: 'GE SS Two',
                            //     fontWeight: FontWeight.w300,
                            //     height: 1.43.h,
                            //   ),
                            //   items:
                            //       state.centers.map((center) {
                            //         return DropdownMenuItem(
                            //           value: center,
                            //           child: Text(center.fCenterName),
                            //         );
                            //       }).toList(),
                            //   onChanged: (center) {
                            //     if (center != null) {
                            //       cubit.selectCenter(center);
                            //     }
                            //   },
                            //   value: state.selectedCenter,
                            // ),

                            /// stages dropdown
                            DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(10.r),
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
                              ),
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 15.sp,
                                fontFamily: 'GE SS Two',
                                fontWeight: FontWeight.w300,
                                height: 1.43.h,
                              ),
                              value: widget.trip.fStageNo,
                              items: [
                                DropdownMenuItem<String>(
                                  value: widget.trip.fStageNo,
                                  child: Text(widget.trip.fStageNo),
                                ),
                              ],

                              onChanged: null,
                            ),
                            // if (state.selectedCenter != null)
                            //   DropdownButtonFormField<BusesGetStageModel>(
                            //     borderRadius: BorderRadius.circular(10.r),
                            //     isExpanded: true,
                            //     decoration: InputDecoration(
                            //       fillColor: kScaffoldBackgroundColor,
                            //       filled: true,
                            //       border: textfieldBorderRadius(
                            //         kMainColorLightColor,
                            //       ),
                            //       focusedBorder: textfieldBorderRadius(
                            //         kMainColorLightColor,
                            //       ),
                            //       enabledBorder: textfieldBorderRadius(
                            //         kMainColorLightColor,
                            //       ),
                            //       focusedErrorBorder: textfieldBorderRadius(
                            //         Colors.red,
                            //       ),
                            //       label: Text(
                            //         'المرحلة',
                            //         style: TextStyle(
                            //           fontSize: 13.sp,
                            //           color: const Color(0xFFA2A2A2),
                            //           fontWeight: FontWeight.w300,
                            //         ),
                            //       ),
                            //     ),
                            //     icon: const Icon(
                            //       Icons.keyboard_arrow_down_rounded,
                            //       color: kMainColor,
                            //     ),
                            //     style: TextStyle(
                            //       color: kMainColor,
                            //       fontSize: 15.sp,
                            //       fontFamily: 'GE SS Two',
                            //       fontWeight: FontWeight.w300,
                            //       height: 1.43.h,
                            //     ),
                            //     items:
                            //         state.stages.map((stage) {
                            //           return DropdownMenuItem(
                            //             value: stage,
                            //             child: Text(stage.fStageName),
                            //           );
                            //         }).toList(),
                            //     onChanged: (stage) {
                            //       if (stage != null) {
                            //         cubit.selectStage(
                            //           stage,
                            //           state.selectedCenter!,
                            //         );
                            //       }
                            //     },
                            //     value:
                            //         state.stages.contains(state.selectedStage)
                            //             ? state.selectedStage
                            //             : null,
                            //   ),

                            /// oprations dropdown
                            // if (state.selectedStage != null)
                            DropdownButtonFormField<String>(
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
                                    return DropdownMenuItem<String>(
                                      value: op.fOperatingNo,
                                      child: Text(op.fOperatingNo),
                                    );
                                  }).toList(),
                              onChanged: (opNo) {
                                if (opNo != null) {
                                  cubit.selectOperation(opNo);
                                }
                              },
                              value: state.selectedOperation,
                            ),
                            H(h: 10.w),
                          ],
                        ),
                      ),

                      /// Bus Card
                      // if (state.selectedCenter != null &&
                      //     state.selectedStage != null
                      // //  &&state.selectedOperation != null
                      // ) ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.busForms.length,
                        itemBuilder: (context, index) {
                          if (state.busForms.length != state.formKeys.length) {
                            return const SizedBox();
                          }

                          return AddBusDetailsCardTrip(
                            trip: widget.trip,
                            rootContext: widget.rootContext,
                            index: index,
                            formKey: state.formKeys[index],
                          );
                        },
                      ),

                      /// Add new bus card
                      if (state.showAddButton)
                        ElevatedButton(
                          onPressed: () {
                            cubit
                              ..addNewBusForm() // إضافة النموذج
                              ..hideAddButton(); // إخفاء الزر بعد الضغط
                          },
                          child: const Text(
                            'إضافة حافلة جديدة',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                      //   ] else
                      //     ...[],
                      //   H(h: 16.h),
                    ],
                  ),
                );
          },
        );
      },
    );
  }
}
