import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/empty_dropdown.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetTrackDropdown extends StatefulWidget {
  const GetTrackDropdown({super.key});

  @override
  State<GetTrackDropdown> createState() => _GetTrackDropdownState();
}

class _GetTrackDropdownState extends State<GetTrackDropdown> {
  final List<String> tracks = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.tracks.isNotEmpty && state.tracks != null) {
          return SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<int>(
              isExpanded: true,

              dropdownColor: kScaffoldBackgroundColor,
              hint: _buildDropdownItem(
                BlocProvider.of<HomeCubit>(context).selectedTrack?.toString() ??
                    'لم يتم التحديد',
              ),
              decoration: InputDecoration(
                border: dropdownBorderRadius(kMainColorLightColor),
                focusedBorder: dropdownBorderRadius(kMainColorLightColor),
                enabledBorder: dropdownBorderRadius(kMainColorLightColor),
                focusedErrorBorder: dropdownBorderRadius(kErrorColor),
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
              items: _buildDropdownItems(state.tracks),
              value: BlocProvider.of<HomeCubit>(context).selectedTrack,
              onChanged: _onTrackChanged,
            ),
          );
        }

        return const EmptyDropdown(title: 'مسار');
      },
    );
  }

  Widget _buildDropdownItem(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: kMainColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.25.h,
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildDropdownItems(List<TrackModel> tracks) {
    return tracks
        .map(
          (track) => DropdownMenuItem<int>(
            value: track.fTrackNo,
            child: _buildDropdownItem(track.fTrackName ?? 'لم يتم التحديد'),
          ),
        )
        .toList();
  }

  void _onTrackChanged(int? value) {
    if (value != null) {
      setState(() {
        context.read<HomeCubit>().selectedTrack = value;
        context.read<HomeCubit>().getDashboardData();
      });
    }
  }
}
