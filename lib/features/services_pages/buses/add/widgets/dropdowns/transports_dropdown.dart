import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_form_data.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportsDropdown extends StatefulWidget {
  const TransportsDropdown({required this.form, super.key});
  final AddBusFormData form;
  @override
  State<TransportsDropdown> createState() => _TransportsDropdownState();
}

class _TransportsDropdownState extends State<TransportsDropdown> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddBusCubit>().state;
    final transports = state.transports;
    return DropdownButtonFormField<BusesGetAllTransportsModel>(
      borderRadius: BorderRadius.circular(10.r),
      isExpanded: true,
      dropdownColor: kScaffoldBackgroundColor,
      validator: (value) {
        if (value == null) {
          return 'الرجاء اختر الشركة الناقلة';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(
          'الشركة الناقلة',
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFFA2A2A2),
            fontWeight: FontWeight.w300,
          ),
        ),
        fillColor: kScaffoldBackgroundColor,
        filled: true,
        border: textfieldBorderRadius(kMainColorLightColor),
        focusedBorder: textfieldBorderRadius(kMainColorLightColor),
        enabledBorder: textfieldBorderRadius(kMainColorLightColor),
        focusedErrorBorder: textfieldBorderRadius(Colors.red),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kMainColor),
      style: TextStyle(
        color: kMainColor,
        fontSize: 15.sp,
        fontFamily: 'GE SS Two',
        fontWeight: FontWeight.w300,
        height: 1.43.h,
      ),
      items:
          transports.map((trans) {
            return DropdownMenuItem(
              value: trans,
              child: Text(trans.fTransportName),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          widget.form.selectedTransport = value;
        });
      },
      value: widget.form.selectedTransport,
    );
  }
}
