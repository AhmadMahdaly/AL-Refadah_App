import 'dart:async';

import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_head_title.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/buses_popup_button.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_download_button.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BusesBody extends StatefulWidget {
  const BusesBody({super.key});
  @override
  State<BusesBody> createState() => _BusesBodyState();
}

class _BusesBodyState extends State<BusesBody> {
  @override
  void initState() {
    context.read<BusesCubit>().getAllBuses();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  // double posX = 20;
  // double posY = 20;

  final List<String> sessions = [];
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchText = _searchController.text.toLowerCase();
        });
      }
    });
  }

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _searchController.dispose();
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        H(h: 10.h),
        SizedBox(
          height: 46,
          child: Row(
            spacing: 12.w,
            children: [
              W(w: 4.w),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF494949),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'FF Shamel Family',
                  ),
                  cursorWidth: 1.sp,
                  cursorColor: kMainColor,
                  minLines: 1,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث هنا',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFA2A2A2),
                      fontWeight: FontWeight.w300,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    _searchText = '';
                                  });
                                }
                                _searchController.clear();
                              },
                            )
                            : null,
                    border: textfieldBorderRadius(const Color(0xFFD6D6D6)),
                    focusedBorder: textfieldBorderRadius(kMainColor),
                    enabledBorder: textfieldBorderRadius(
                      const Color(0xFFD6D6D6),
                    ),
                    focusedErrorBorder: textfieldBorderRadius(Colors.red),
                    prefixIcon: SvgPicture.asset(
                      'assets/svg/search.svg',
                      fit: BoxFit.none,
                      colorFilter: const ColorFilter.mode(
                        kMainColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 46.w,
                height: 46.h,
                padding: EdgeInsets.all(5.sp),
                decoration: ShapeDecoration(
                  color: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const CustomDownloadButton(),
              ),
              W(w: 4.w),
            ],
          ),
        ),
        const GetBusTableHeadTitle(),
        BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            if (state.isLoadingSeasons || state.isLoadingAllBuses) {
              return SizedBox(height: 250.h, child: const AppIndicator());
            } else if (state.allBuses != null) {
              final buses = state.allBuses;
              final filteredCenters =
                  _searchText.isEmpty
                      ? buses
                      : buses.where((bus) {
                        final operatingNo = bus.fOperatingNo.toLowerCase();
                        final busNo = bus.fBusNo;
                        final stageName = bus.fStageName;
                        final centerName = bus.fCenterName;
                        final arabicSearch = convertArabicToLatin(_searchText);
                        return operatingNo.contains(_searchText) ||
                            stageName.contains(_searchText) ||
                            centerName.contains(_searchText) ||
                            busNo.contains(_searchText) ||
                            operatingNo.contains(arabicSearch);
                      }).toList();
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 80.h,
                    top: 16.h,
                  ),
                  itemCount: filteredCenters.length,
                  itemBuilder: (context, index) {
                    final bus = filteredCenters[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionTile(
                          shape: Border.all(color: kScaffoldBackgroundColor),
                          minTileHeight: 20.h,
                          collapsedIconColor: kMainColor,
                          iconColor: kMainColor,
                          collapsedBackgroundColor: kScaffoldBackgroundColor,
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// center name
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  bus.fCenterName,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              /// stage name
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  bus.fStageName,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              /// bus no
                              SizedBox(
                                width: 75.w,
                                child: Text(
                                  bus.fBusNo,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              /// transport name
                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  bus.fTransportName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const W(w: 2),
                            ],
                          ),
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            'أمر التشغيل',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70.w,
                                          child: Text(
                                            'عدد الحجاج',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70.w,
                                          child: Text(
                                            'عدد الردود',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            'الحالة',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        /// operating no
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            bus.fOperatingNo,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: kDartTextColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// pilgrims count
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            bus.fPilgrimsAco.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: kDartTextColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// trip count
                                        SizedBox(
                                          width: 50.w,
                                          child: Text(
                                            bus.fTripAco.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kDartTextColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// bus status
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SvgPicture.asset(
                                              getStatusIcon(bus.fBusStatus),
                                            ),

                                            SizedBox(
                                              width: 70.w,

                                              child: Text(
                                                getStatusText(bus.fBusStatus),

                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  color: getStatusColor(
                                                    bus.fBusStatus,
                                                  ),
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    color: kMainExtrimeLightColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  child: showBusPopupMenuButton(context, bus),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(color: kMainColorLightColor),
                      ],
                    );
                  },
                ),
              );
            } else {
              return NoDataWidget(
                onPressed: () => context.read<BusesCubit>().getAllBuses(),
              );
            }
          },
        ),
      ],
    );
  }
}

String getStatusText(int status) {
  switch (status) {
    case 2:
      return 'مستلمة';
    case 3:
      return 'مستبدلة';
    default:
      return 'لدى التسليم';
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case 2:
      return const Color(0xFF46C469);
    case 3:
      return Colors.purple;
    default:
      return Colors.orangeAccent;
  }
}

String getStatusIcon(int status) {
  switch (status) {
    case 2:
      return 'assets/svg/bus_status/done.svg';
    case 3:
      return 'assets/svg/bus_status/swap.svg';
    default:
      return 'assets/svg/bus_status/waiting.svg';
  }
}
              //  ],
              //   ),
              //   Positioned(
              //     left: posX,
              //     bottom: posY,
              //     child: GestureDetector(
              //       onPanUpdate: (details) {
              //         setState(() {
              //           posX += details.delta.dx;
              //           posY += details.delta.dy;
              //         });
              //       },
              //       child: FloatingActionButton(
              //         heroTag: 'draggable_fab_bus',
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(320.r),
              //         ),
              //         backgroundColor: kMainColor,
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => const AddBusPage(),
              //             ),
              //           );
              //         },
              //         child: const Icon(Icons.add, color: kMainColorLightColor),
              //       ),
              //     ),
              //   ),
              