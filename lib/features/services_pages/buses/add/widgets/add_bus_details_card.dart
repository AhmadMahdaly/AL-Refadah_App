import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_form_data.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusDetailsCard extends StatefulWidget {
  const AddBusDetailsCard({required this.index, super.key});
  final int index;
  @override
  State<AddBusDetailsCard> createState() => _AddBusDetailsCardState();
}

class _AddBusDetailsCardState extends State<AddBusDetailsCard> {
  late AddBusFormData form;
  BusesGetAllTransportsModel? selectedTransport;
  @override
  void initState() {
    super.initState();
    final state = context.read<AddBusCubit>().state;
    form = state.busForms[widget.index];
    selectedTransport = form.selectedTransport;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddBusCubit>().state;
    final transports = state.transports;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 20,
            offset: Offset(4, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        spacing: 10.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<AddBusCubit>().removeBusForm(widget.index);
                },
              ),
            ],
          ),
          DropdownButtonFormField<BusesGetAllTransportsModel>(
            borderRadius: BorderRadius.circular(10.r),
            isExpanded: true,
            dropdownColor: kScaffoldBackgroundColor,

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
                transports.map((trans) {
                  return DropdownMenuItem(
                    value: trans,
                    child: Text(trans.fTransportName),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTransport = value;
                form.selectedTransport = value;
              });
            },
            value: selectedTransport,
          ),
          SizedBox(
            height: 55.h,
            child: Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CustomNumberTextformfield(
                    maxLength: 8,
                    controller: form.busNoController,
                    onChanged: (String value) {
                      form.busNoController.text = value;
                    },
                    labelText: 'رقم الحافلة',
                  ),
                ),
                Expanded(
                  child: CustomNumberTextformfield(
                    maxLength: 4,
                    controller: form.pilgrimsQtyController,
                    labelText: 'عدد الحجاج',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55.h,
            child: Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CustomNumberTextformfield(
                    maxLength: 3,
                    controller: form.tripsQtyController,
                    labelText: 'عدد الردود',
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(10.r),
                    dropdownColor: kScaffoldBackgroundColor,

                    decoration: InputDecoration(
                      label: Text(
                        'حالة الحافلة',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFFA2A2A2),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      fillColor: kScaffoldBackgroundColor,
                      filled: true,
                      border: textfieldBorderRadius(kMainColorLightColor),
                      focusedBorder: textfieldBorderRadius(
                        kMainColorLightColor,
                      ),
                      enabledBorder: textfieldBorderRadius(
                        kMainColorLightColor,
                      ),
                      focusedErrorBorder: textfieldBorderRadius(Colors.red),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 15.sp,
                      fontFamily: 'GE SS Two',
                      fontWeight: FontWeight.w300,
                      height: 1.43.h,
                    ),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('لدى التسليم')),
                    ],
                    onChanged: null,
                    value: '1',
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 15.sp,
              color: const Color(0xFF494949),
              fontWeight: FontWeight.w300,
              fontFamily: 'FF Shamel Family',
            ),
            cursorWidth: 1.sp,
            cursorColor: kMainColor,
            minLines: 1,
            maxLines: 2,
            controller: form.notesController,
            autovalidateMode: AutovalidateMode.onUnfocus,
            decoration: InputDecoration(
              labelText: 'الملاحظات',
              labelStyle: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFA2A2A2),
                fontWeight: FontWeight.w300,
              ),
              border: textfieldBorderRadius(const Color(0xFFD6D6D6)),
              focusedBorder: textfieldBorderRadius(kMainColor),
              enabledBorder: textfieldBorderRadius(const Color(0xFFD6D6D6)),
              focusedErrorBorder: textfieldBorderRadius(Colors.red),
            ),
          ),
          H(h: 10.w),
        ],
      ),
    );
  }
}
