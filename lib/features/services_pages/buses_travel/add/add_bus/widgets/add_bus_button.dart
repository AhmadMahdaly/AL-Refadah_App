import 'dart:math';

import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String generateRandom6DigitNumber() {
  final random = Random();
  final number = 100000 + random.nextInt(900000); // يضمن أن يكون من 6 أرقام
  return number.toString();
}

class AddBusButton extends StatefulWidget {
  const AddBusButton({
    required this.rootContext,
    required this.trip,
    super.key,
  });
  final BuildContext rootContext;
  final BusesTravelGetTripModel trip;
  @override
  State<AddBusButton> createState() => _AddBusButtonState();
}

class _AddBusButtonState extends State<AddBusButton> {
  /// get userId
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = await CacheHelper.getUserId();
  }

  int? userId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesCubit, BusesState>(
      builder: (context, state) {
        final busesCubit = context.read<BusesCubit>();
        return BlocBuilder<AddBusTripCubit, AddBusTripState>(
          builder: (context, state) {
            /// Loading
            return state.operations.isEmpty ||
                    busesCubit.state.isLoadingAddBus ||
                    busesCubit.state.isLoadingAllBusesByCrietia
                ? const AppIndicator()
                : Padding(
                  padding: EdgeInsets.only(
                    right: 16.sp,
                    left: 16.sp,
                    bottom: 16.sp,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),

                    /// Saved button
                    child: CustomButton(
                      text: 'حفظ',
                      onTap: () async {
                        if (state.busForms.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text('ادخل البيانات المطلوبة'),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );

                          /// validate and handle data
                        }
                        var allValid = true;
                        for (final formKey in state.formKeys) {
                          if (!formKey.currentState!.validate()) {
                            allValid = false;
                          }
                        }

                        if (allValid && state.busForms.isNotEmpty) {
                          final buses =
                              state.busForms.map((form) {
                                return AddBusModel(
                                  fAdditionUser: userId.toString(),
                                  fCompanyId: companyId,
                                  fSeasonId:
                                      context
                                          .read<BusesCubit>()
                                          .selectedSeason!,

                                  fCenterNo:int.parse(widget.trip.fCenterNo) ,
                                  fStageNo: int.parse(widget.trip.fStageNo),
                                  fTransportNo:
                                      form.selectedTransport!.fTransportNo,
                                  fBusNo: form.busNoController.text,
                                  fOperatingNo:
                                      state.selectedOperation!,
                                  fPilgrimsAco: 47,
                                  fTripAco:
                                      int.tryParse(
                                        form.tripsQtyController.text,
                                      ) ??
                                      0,
                                  fBusStatus: 1,
                                  fBusNote: form.notesController.text,
                                  fBusIdTrip: generateRandom6DigitNumber(),
                                  fBusId: generateRandom6DigitNumber(),
                                );
                              }).toList();

                          try {
                            await busesCubit.addBus(buses);

                            if (busesCubit.state.isSuccessAddBus) {
                              await busesCubit.getAllBusesByCrietia(
                               widget.trip.fCenterNo ,
                              );

                              if (widget.rootContext.mounted) {
                                showSuccessDialog(
                                  widget.rootContext,
                                  seconds: 1,
                                );
                              }

                              // Future.delayed(
                              //   const Duration(milliseconds: 100),
                              //   () {
                              //     if (widget.rootContext.mounted) {
                              //       Navigator.pop(widget.rootContext);
                              //     }
                              //   },
                              // );

                              Future.delayed(const Duration(seconds: 1), () {
                                if (widget.rootContext.mounted) {
                                  Navigator.of(
                                    widget.rootContext,
                                    rootNavigator: true,
                                  ).pop();
                                }
                              });
                            }
                          } catch (e) {
                            if (widget.rootContext.mounted) {
                              showErrorDialog(
                                isBack: true,
                                widget.rootContext,
                                message:
                                    'حدث خطأ أثناء حفظ البيانات. الرجاء المحاولة مرة أخرى.',
                              );
                            }
                          }
                        }
                      },
                    ),
                  ),
                );
          },
        );
      },
    );
  }
}
