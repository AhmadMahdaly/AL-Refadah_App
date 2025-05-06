import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/presentation/app/shared_widgets/empty_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSeasonDropdown extends StatefulWidget {
  const HomeSeasonDropdown({super.key});

  @override
  State<HomeSeasonDropdown> createState() => _HomeSeasonDropdownState();
}

class _HomeSeasonDropdownState extends State<HomeSeasonDropdown> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    final cubit = BlocProvider.of<HomeCubit>(context)..getHomeSeasons();
    cubit.stream.listen((state) {
      if (state.seasons.isNotEmpty) {
        sessions
          ..clear()
          ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
        if (sessions.isNotEmpty) {
          cubit.selectedSeason = sessions.last;
          // ..getDashboardData();
        }
      }
    });
  }

  final List<String> sessions = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.seasons.isNotEmpty) {
          sessions
            ..clear()
            ..addAll(state.seasons.map((e) => e.fSeasonId.toString()));
          if (sessions.isNotEmpty) {
            BlocProvider.of<HomeCubit>(context).selectedSeason = sessions.last;
          }
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoadingSeasons) {
            return const EmptyDropdown(title: 'موسم حج');
          }

          if (state.seasons.isNotEmpty) {
            return SizedBox(
              height: 60.h,
              child: DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(10.r),
                isExpanded: true,
                dropdownColor: kScaffoldBackgroundColor,
                decoration: InputDecoration(
                  border: textfieldBorderRadius(kMainColorLightColor),
                  focusedBorder: textfieldBorderRadius(kMainColorLightColor),
                  enabledBorder: textfieldBorderRadius(kMainColorLightColor),
                  focusedErrorBorder: textfieldBorderRadius(kErrorColor),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: kMainColor,
                ),
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 14.sp,
                  fontFamily: 'GE SS Two',
                  fontWeight: FontWeight.w500,
                ),

                items:
                    state.seasons.map((name) {
                      return DropdownMenuItem<String>(
                        value: name.fSeasonId.toString(),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/kaaba 1.svg',
                              height: 16.h,
                              colorFilter: const ColorFilter.mode(
                                kMainColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              name.fSeasonName,
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.25.h,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                value:
                    BlocProvider.of<HomeCubit>(
                      context,
                    ).selectedSeason?.toString(),
                onChanged: (value) {
                  setState(() {
                    BlocProvider.of<HomeCubit>(context).selectedSeason = value;
                    BlocProvider.of<HomeCubit>(context).getDashboardData();
                  });
                },
              ),
            );
          }
          return const EmptyDropdown(title: 'موسم حج');
        },
      ),
    );
  }
}
