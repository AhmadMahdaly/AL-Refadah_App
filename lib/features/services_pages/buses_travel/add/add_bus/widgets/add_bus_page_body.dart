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
                                  'الرقم التشغيلي',
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

                      if (state.showAddButton)
                        ElevatedButton(
                          onPressed: () {
                            cubit
                              ..addNewBusForm()
                              ..hideAddButton();
                          },
                          child: const Text(
                            'إضافة حافلة جديدة',
                            style: TextStyle(color: kMainColor),
                          ),
                        ),
                    ],
                  ),
                );
          },
        );
      },
    );
  }
}
