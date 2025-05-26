import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_form_data.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/dropdowns/transports_dropdown.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusDetailsCard extends StatefulWidget {
  const AddBusDetailsCard({
    required this.index,
    required this.formKey,
    super.key,
  });
  final int index;
  final GlobalKey<FormState> formKey;

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

      /// card form
      child: Form(
        key: widget.formKey,
        child: Column(
          spacing: 14.h,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// delete button
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 20.sp),
                  onPressed: () {
                    context.read<AddBusCubit>().removeBusForm(widget.index);
                  },
                ),
              ],
            ),

            /// transport dropdown
            TransportsDropdown(form: form),

            /// BusNo & Pilgrims qty
            Row(
              spacing: 12.w,
              children: [
                /// BusNo
                Expanded(
                  child: CustomNumberTextformfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الحافلة';
                      }
                      return null;
                    },
                    maxLength: 8,
                    controller: form.busNoController,
                    onChanged: (String value) {
                      form.busNoController.text = value;
                    },
                    labelText: 'رقم الحافلة',
                  ),
                ),

                /// Pilgrims qty
                Expanded(
                  child: CustomNumberTextformfield(
                    readOnly: true,
                    enabled: false,
                    controller: TextEditingController(text: '47'),
                    labelText: 'عدد الحجاج',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),

            /// Trips times & bus status
            Row(
              spacing: 12.w,
              children: [
                /// Trips times
                Expanded(
                  child: CustomNumberTextformfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال عدد الردود';
                      }
                      return null;
                    },
                    maxLength: 3,
                    controller: form.tripsQtyController,
                    labelText: 'عدد الردود',
                  ),
                ),

                /// bus status
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

            /// Notes
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
      ),
    );
  }
}
