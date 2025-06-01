import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowTripBody extends StatefulWidget {
  const ShowTripBody({required this.trip, super.key});

  final TripModel trip;

  @override
  State<ShowTripBody> createState() => _ShowTripBodyState();
}

class _ShowTripBodyState extends State<ShowTripBody> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await Future.wait([
      context.read<BusTravelCubit>().getTripsByStage(
        widget.trip.fCenterNo,
        widget.trip.fStageNo,
      ),
      context.read<BusTravelCubit>().getTrackTrip(),
      context.read<GuidesCubit>().getGuideByCriteria(widget.trip.fCenterNo),
      context.read<BusesCubit>().getAllBuses(),
    ]);
    final trackStates = context.read<BusTravelCubit>().state;

    trackTrip =
        trackStates.track.where((track) {
          final trackName = track.fTrackName;
          return trackName != null && trackName.isNotEmpty;
        }).toList();
    selectedTrack = trackTrip.firstWhere(
      (track) => track.fTrackNo == widget.trip.fTrackNo,
      orElse: TrackModel.new,
    );

    final busesState = context.read<BusesCubit>().state;
    busesList =
        busesState.allBuses.where((bus) {
          final fBusNo = bus.fBusNo;
          return fBusNo != null && fBusNo.isNotEmpty;
        }).toList();

    selectedBus = busesList.firstWhereOrNull(
      (bus) => bus.fBusNo == widget.trip.fBus.fBusNo,
    );

    ///
    final guidesState = context.read<GuidesCubit>().state;
    guidesList =
        guidesState.guidesByCriteria
            .where((emp) => emp.employee?.fEmpName.isNotEmpty ?? false)
            .toList();
  }

  TrackModel? selectedTrack;
  List<TrackModel> trackTrip = [];
  GetAllBusesModel? selectedBus;
  List<GetAllBusesModel> busesList = [];
  List<AssignmentModel> guidesList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final busTravelState = context.read<BusTravelCubit>().state;
        return BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            final busesState = context.read<BusesCubit>().state;
            return BlocBuilder<GuidesCubit, GuidesState>(
              builder: (context, state) {
                if (busTravelState.isAddingTripByStage ||
                    busTravelState.isLoadingTripsByStage ||
                    guidesList.isEmpty ||
                    busesState.isLoadingAllBuses) {
                  return const AppIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        const H(h: 0),
                        Row(
                          spacing: 12.w,
                          children: [
                            /// الموسم
                            Expanded(
                              child: CustomTextFieldWithLabel(
                                controller: TextEditingController(
                                  text: widget.trip.fSeasonId,
                                ),
                                text: 'موسم',
                                readOnly: true,
                                enabled: false,
                              ),
                            ),

                            /// المركز
                            Expanded(
                              child: CustomTextFieldWithLabel(
                                controller: TextEditingController(
                                  text: widget.trip.fCenterNo,
                                ),
                                text: 'رقم المركز',
                                readOnly: true,
                                enabled: false,
                              ),
                            ),
                          ],
                        ),

                        /// المرحلة
                        CustomTextFieldWithLabel(
                          readOnly: true,
                          controller: TextEditingController(
                            text: context.read<BusTravelCubit>().getStageName(
                              widget.trip.fStageNo,
                            ),
                          ),
                          text: 'المرحلة',
                          enabled: false,
                        ),

                        /// رقم الحافلة
                        CustomTextFieldWithLabel(
                          readOnly: true,
                          text: 'رقم الحافلة',
                          controller: TextEditingController(
                            text: widget.trip.fBus.fBusNo,
                          ),
                          enabled: false,
                        ),

                        /// الشركة الناقلة
                        CustomTextFieldWithLabel(
                          readOnly: true,
                          controller: TextEditingController(
                            text: widget.trip.fBus.transport?.fTransportName,
                          ),
                          text: 'الشركة الناقلة',
                          enabled: false,
                        ),
                        Row(
                          spacing: 12.w,
                          children: [
                            ///أمر التشغيل
                            Expanded(
                              child: CustomTextFieldWithLabel(
                                enabled: false,
                                readOnly: true,
                                text: 'أمر التشغيل',
                                controller: TextEditingController(
                                  text: widget.trip.fBus.fOperatingNo,
                                ),
                              ),
                            ),

                            /// عدد الحجاج
                            Expanded(
                              child: CustomTextFieldWithLabel(
                                enabled: false,
                                readOnly: true,
                                text: 'عدد الحجاج',
                                controller: TextEditingController(
                                  text: widget.trip.fPilgrimsAco,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// المسار
                        CustomTextFieldWithLabel(
                          enabled: false,
                          text: 'المسار',
                          controller: TextEditingController(
                            text:
                                trackTrip.contains(selectedTrack)
                                    ? selectedTrack?.fTrackName
                                    : 'لم يتم تحديد مسار',
                          ),
                        ),

                        /// المرشد
                        CustomTextFieldWithLabel(
                          enabled: false,
                          text: 'المرشد',
                          controller: TextEditingController(
                            text:
                                guidesList
                                    .firstWhereOrNull(
                                      (guide) =>
                                          guide.fEmpNo == widget.trip.fEmpNo,
                                    )
                                    ?.employee
                                    ?.fEmpName ??
                                'لم يتم تحديد مرشد',
                          ),
                        ),
                        const H(h: 40),
                      ],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
