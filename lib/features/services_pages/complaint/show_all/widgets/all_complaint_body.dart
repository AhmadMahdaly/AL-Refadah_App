import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';

class AllComplaintBody extends StatefulWidget {
  const AllComplaintBody({super.key});

  @override
  State<AllComplaintBody> createState() => _AllComplaintBodyState();
}

class _AllComplaintBodyState extends State<AllComplaintBody> {
  @override
  void initState() {
    context.read<BusTravelCubit>().getComplaint(
      context.read<BusTravelCubit>().selectedCenter ?? '',
      '1',
    );
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

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
                child: CustomSearchBar(
                  controller: _searchController,
                  clearIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchText = '');
                    },
                  ),
                ),
              ),

              /// Download button
              const CustomDownloadButton(),
              W(w: 4.w),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
          height: 60.h,
          padding: EdgeInsets.all(10.sp),
          decoration: ShapeDecoration(
            color: kMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.w,

                child: Text(
                  'رقم البلاغ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              SizedBox(
                width: 110.w,
                child: Text(
                  'نوع البلاغ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 70.w,
                child: Text(
                  'المركز',
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.h,
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  'رقم الحافلة',
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.h,
                  ),
                ),
              ),
              W(w: 40.w),
            ],
          ),
        ),
        BlocBuilder<BusTravelCubit, BusesTravelState>(
          builder: (context, state) {
            if (state.isLoadingcomplaint) {
              return SizedBox(height: 350.h, child: const AppIndicator());
            } else if (state.complaint == null || state.complaint.isEmpty) {
              return SizedBox(
                height: 350.h,
                child: const Center(child: Text('لا يوجد بلاغات')),
              );
            } else if (state.complaint != null) {
              final complaints = state.complaint;
              final filteredComplaints =
                  _searchText.isEmpty
                      ? complaints
                      : complaints.where((complaint) {
                        final fBusId =
                            complaint.fBusId.toString().toLowerCase();
                        final fComplaintNo = complaint.fComplaintNo;
                        final fComplaintTypeName = complaint.fComplaintTypeName;

                        return fBusId.contains(_searchText) ||
                            fComplaintNo.toString().contains(_searchText) ||
                            fComplaintTypeName.contains(_searchText);
                      }).toList();
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 80.h,
                    top: 16.h,
                  ),
                  itemCount: filteredComplaints.length,
                  itemBuilder: (context, index) {
                    final complaint = filteredComplaints[index];
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
                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  complaint.fComplaintNo.toString(),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5.h,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 110.w,
                                child: Text(
                                  complaint.fComplaintTypeName,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5.h,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  complaint.fCenterNo.toString(),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5.h,
                                  ),
                                ),
                              ),

                              /// transport name
                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  complaint.fBusName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kDartTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5.h,
                                  ),
                                ),
                              ),
                              const W(w: 2),
                            ],
                          ),

                          children: [
                            H(h: 10.h),
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
                                          width: 100.w,
                                          child: Text(
                                            'التاريخ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            'الوصف',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kAnalysisMediumColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            'الحالة',
                                            textAlign: TextAlign.center,
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
                                            complaint.fComplaintDate != null
                                                ? '${complaint.fComplaintDate.year.toString().padLeft(4, '0')}-${complaint.fComplaintDate.month.toString().padLeft(2, '0')}-${complaint.fComplaintDate.day.toString().padLeft(2, '0')}'
                                                : '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kDartTextColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// pilgrims count
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            complaint
                                                    .fComplaintDescription
                                                    .isEmpty
                                                ? 'لا يوجد'
                                                : complaint
                                                    .fComplaintDescription,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: kDartTextColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// status
                                        SizedBox(
                                          width: 100.w,

                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                getStatusIcon(
                                                  complaint.fComplaintStatus,
                                                ),
                                              ),
                                              const W(w: 12),
                                              SizedBox(
                                                child: Text(
                                                  getStatusText(
                                                    complaint.fComplaintStatus,
                                                  ),

                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    color: getStatusColor(
                                                      complaint
                                                          .fComplaintStatus,
                                                    ),
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // const Spacer(),
                                // Container(
                                //   width: 40.w,
                                //   height: 40.h,
                                //   decoration: ShapeDecoration(
                                //     color: kMainExtrimeLightColor,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5.r),
                                //     ),
                                //   ),
                                //   child: showBusPopupMenuButton(context, complaint),
                                // ),
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
                onPressed:
                    () => context.read<BusTravelCubit>().getComplaint(
                      context.read<BusTravelCubit>().selectedCenter ?? '',
                      '1',
                    ),
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
      return 'مستلم';
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
