import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBusBody extends StatefulWidget {
  const EditBusBody({required this.oldBus, super.key});
  final GetAllBusesModel oldBus;
  @override
  State<EditBusBody> createState() => _EditBusBodyState();
}

class _EditBusBodyState extends State<EditBusBody> {
  /// controllers
  late TextEditingController busNoController;
  late TextEditingController pilgrimsController;
  late TextEditingController tripsController;
  late TextEditingController notesController;
  late int selectedStageNo;
  late int selectedTransportNo;
  late String selectedOperating;
  late int selectedStatus;
  BusesGetAllTransportsModel? selectedTransport;

  @override
  void initState() {
    super.initState();
    initialDate();
  }

  void initialDate() {
    context.read<BusesCubit>().state;

    /// تحميل المراحل وأوامر التشغيل بناءً على المركز الجاهز
    busNoController = TextEditingController(text: widget.oldBus.fBusNo);
    pilgrimsController = TextEditingController(
      text: widget.oldBus.fPilgrimsAco.toString(),
    );
    tripsController = TextEditingController(
      text: widget.oldBus.fTripAco.toString(),
    );
    notesController = TextEditingController(text: widget.oldBus.fBusNote);
    selectedStageNo = widget.oldBus.fStageNo;
    selectedTransportNo = widget.oldBus.fTransportNo;
    selectedOperating = widget.oldBus.fOperatingNo;
    selectedStatus = widget.oldBus.fBusStatus;
  }

  @override
  void dispose() {
    busNoController.dispose();
    pilgrimsController.dispose();
    tripsController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesCubit, BusesState>(
      builder: (context, state) {
        return state.isLoadingEditTransportBus || state.isLoadingAllBuses
            ? const AppIndicator()
            : Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
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

                                  /// Centers dropdown
                                  DropdownButtonFormField<int>(
                                    borderRadius: BorderRadius.circular(10.r),
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
                                        'المركز',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: const Color(0xFFA2A2A2),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 15.sp,
                                      fontFamily: 'GE SS Two',
                                      fontWeight: FontWeight.w300,
                                      height: 1.43.h,
                                    ),
                                    value: widget.oldBus.fCenterNo,
                                    items: [
                                      DropdownMenuItem<int>(
                                        value: widget.oldBus.fCenterNo,
                                        child: Text(widget.oldBus.fCenterName),
                                      ),
                                    ],
                                    onChanged: null,
                                  ),

                                  /// Stages dropdown
                                  DropdownButtonFormField<int>(
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
                                        'المرحلة',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: const Color(0xFFA2A2A2),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 15.sp,
                                      fontFamily: 'GE SS Two',
                                      fontWeight: FontWeight.w300,
                                      height: 1.43.h,
                                    ),
                                    value: widget.oldBus.fStageNo,
                                    items: [
                                      DropdownMenuItem<int>(
                                        value: widget.oldBus.fStageNo,
                                        child: Text(widget.oldBus.fStageName),
                                      ),
                                    ],
                                    onChanged: null,
                                  ),

                                  /// Operating Command dropdown
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
                                    ),
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 15.sp,
                                      fontFamily: 'GE SS Two',
                                      fontWeight: FontWeight.w300,
                                      height: 1.43.h,
                                    ),
                                    value: widget.oldBus.fOperatingNo,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: widget.oldBus.fOperatingNo,
                                        child: Text(widget.oldBus.fOperatingNo),
                                      ),
                                    ],
                                    onChanged: null,
                                  ),
                                  H(h: 10.w),
                                ],
                              ),
                            ),

                            /// create Bus Card
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 5.h,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 0.50,
                                    color: Color(0xFFEEEEEE),
                                  ),
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
                                  H(h: 10.h),

                                  /// Transport Name
                                  DropdownButtonFormField<String>(
                                    borderRadius: BorderRadius.circular(10.r),
                                    dropdownColor: kScaffoldBackgroundColor,
                                    decoration: InputDecoration(
                                      labelText: 'الشركة الناقلة',
                                      labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color(0xFFA2A2A2),
                                        fontWeight: FontWeight.w300,
                                      ),
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
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 15.sp,
                                      fontFamily: 'GE SS Two',
                                      fontWeight: FontWeight.w300,
                                      height: 1.43.h,
                                    ),
                                    value: widget.oldBus.fTransportName,
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: widget.oldBus.fTransportName,
                                        child: Text(
                                          widget.oldBus.fTransportName,
                                        ),
                                      ),
                                    ],
                                    onChanged: null,
                                  ),

                                  /// Bus No
                                  SizedBox(
                                    height: 55.h,
                                    child: Row(
                                      spacing: 12.w,
                                      children: [
                                        Expanded(
                                          child: CustomNumberTextformfield(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'الرجاء إدخال رقم الحافلة';
                                              }
                                              return null;
                                            },
                                            maxLength: 8,
                                            controller: busNoController,
                                            onChanged: (value) {
                                              busNoController.text = value;
                                            },
                                            labelText: 'رقم الحافلة',
                                          ),
                                        ),

                                        /// Pilgrims qty
                                        Expanded(
                                          child: CustomNumberTextformfield(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'الرجاء إدخال عدد الحجاج';
                                              }
                                              return null;
                                            },
                                            maxLength: 4,
                                            controller: pilgrimsController,
                                            onChanged: (value) {
                                              pilgrimsController.text = value;
                                            },
                                            labelText: 'عدد الحجاج',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Trips times
                                  SizedBox(
                                    height: 55.h,
                                    child: Row(
                                      spacing: 12.w,
                                      children: [
                                        Expanded(
                                          child: CustomNumberTextformfield(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'الرجاء إدخال عدد الردود';
                                              }
                                              return null;
                                            },
                                            maxLength: 3,
                                            controller: tripsController,
                                            onChanged: (value) {
                                              tripsController.text = value;
                                            },
                                            labelText: 'عدد الردود',
                                          ),
                                        ),

                                        /// Bus Status
                                        Expanded(
                                          child: DropdownButtonFormField<
                                            String
                                          >(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            dropdownColor:
                                                kScaffoldBackgroundColor,
                                            decoration: InputDecoration(
                                              labelText: 'حالة الحافلة',
                                              labelStyle: TextStyle(
                                                fontSize: 13.sp,
                                                color: const Color(0xFFA2A2A2),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              fillColor:
                                                  kScaffoldBackgroundColor,
                                              filled: true,
                                              border: textfieldBorderRadius(
                                                kMainColorLightColor,
                                              ),
                                              focusedBorder:
                                                  textfieldBorderRadius(
                                                    kMainColorLightColor,
                                                  ),
                                              enabledBorder:
                                                  textfieldBorderRadius(
                                                    kMainColorLightColor,
                                                  ),
                                              focusedErrorBorder:
                                                  textfieldBorderRadius(
                                                    Colors.red,
                                                  ),
                                            ),
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                            ),
                                            style: TextStyle(
                                              color: kMainColor,
                                              fontSize: 15.sp,
                                              fontFamily: 'GE SS Two',
                                              fontWeight: FontWeight.w300,
                                              height: 1.43.h,
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: '1',
                                                child: Text('لدى التسليم'),
                                              ),
                                            ],
                                            onChanged: null,
                                            value: '1',
                                          ),
                                        ),
                                      ],
                                    ),
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
                                    controller: notesController,
                                    onChanged: (value) {
                                      notesController.text = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'الملاحظات',
                                      labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color(0xFFA2A2A2),
                                        fontWeight: FontWeight.w300,
                                      ),

                                      border: textfieldBorderRadius(
                                        const Color(0xFFD6D6D6),
                                      ),
                                      focusedBorder: textfieldBorderRadius(
                                        kMainColor,
                                      ),
                                      enabledBorder: textfieldBorderRadius(
                                        const Color(0xFFD6D6D6),
                                      ),
                                      focusedErrorBorder: textfieldBorderRadius(
                                        Colors.red,
                                      ),
                                    ),
                                  ),

                                  H(h: 10.h),
                                ],
                              ),
                            ),
                            H(h: MediaQuery.of(context).viewInsets.bottom + 80),
                          ],
                        ),
                      ),

                      /// Saved button
                      Positioned(
                        bottom: 16.h,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                            text: 'حفظ',
                            padding: 16,
                            onTap: _handleEdit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
      },
    );
  }

  Future<void> _handleEdit() async {
    try {
      final model = EditBusModel(
        fBusAco: widget.oldBus.fBusAco,
        fTransportName: widget.oldBus.fTransportName,
        fStageName: widget.oldBus.fStageName,
        fCenterName: widget.oldBus.fCenterName,
        fBusId: widget.oldBus.fBusId,
        fCompanyId: widget.oldBus.fCompanyId,
        fSeasonId: widget.oldBus.fSeasonId,
        fCenterNo: widget.oldBus.fCenterNo,
        fStageNo: widget.oldBus.fStageNo,
        fTransportNo: widget.oldBus.fTransportNo,
        fOperatingNo: widget.oldBus.fOperatingNo,
        fBusStatus: widget.oldBus.fBusStatus,
        fBusIdTrip: widget.oldBus.fBusIdTrip,

        ///
        fBusNo: busNoController.text,
        fPilgrimsAco: int.parse(pilgrimsController.text),
        fTripAco: int.parse(tripsController.text),
        fBusNote: notesController.text,
      );
      await context.read<BusesCubit>().editTransportBus([model]);
      showSuccessDialog(context);
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pop(context, context.read<BusesCubit>().getAllBuses());
        }
      });
    } catch (e) {
      showErrorDialog(
        isBack: true,
        context,
        message: 'هناك خطأ في تحديث البيانات',
      );
    }
  }
}
