import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/add/models/add_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';

class GuideCard {
  GetGuidesModel? selectedEmployee;
}

class GuideSelectorBody extends StatefulWidget {
  const GuideSelectorBody({required this.center, super.key});
  final GetGuidesCenterModel center;

  @override
  State<GuideSelectorBody> createState() => _GuideSelectorBodyState();
}

class _GuideSelectorBodyState extends State<GuideSelectorBody> {
  @override
  void initState() {
    context.read<GuidesCubit>().fetchGuides();
    super.initState();
  }

  final List<GuideCard> selectedCards = [GuideCard()]; // أول كارت جاهز

  @override
  Widget build(BuildContext context) {
    final selectedEmpNos =
        selectedCards
            .where((c) => c.selectedEmployee != null)
            .map((c) => c.selectedEmployee!.empNo)
            .toSet();

    return BlocBuilder<GuidesCubit, GuidesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              '${widget.center.fCenterName} - رقم ${widget.center.fCenterNo}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kMainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                height: 1.20.h,
              ),
            ),
          ),
          body:
              state.isLoadingAddGuides
                  ? const AppIndicator()
                  : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ...selectedCards.map((card) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              color: kScaffoldBackgroundColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButton(
                                      isExpanded: true,
                                      hint: Text(
                                        'اختر المرشد',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kGrayColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: card.selectedEmployee,
                                      onChanged: (value) {
                                        setState(() {
                                          card.selectedEmployee = value;
                                        });
                                      },
                                      items:
                                          state.guides
                                              .where(
                                                (emp) =>
                                                    !selectedEmpNos.contains(
                                                      emp.empNo,
                                                    ) ||
                                                    emp ==
                                                        card.selectedEmployee,
                                              )
                                              .map(
                                                (emp) => DropdownMenuItem(
                                                  value: emp,
                                                  child: Text(emp.empName),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                    if (card.selectedEmployee != null) ...[
                                      const SizedBox(height: 10),
                                      Text(
                                        'رقم المرشد: ${card.selectedEmployee!.empNo}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'رقم الهوية: ${card.selectedEmployee!.idNo}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'رقم الجوال: ${card.selectedEmployee!.jawNo}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'البريد الإلكتروني: ${card.selectedEmployee!.email}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kDartTextColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedCards.add(GuideCard());
                            });
                          },
                          child: const Text('إضافة مرشد جديد'),
                        ),
                      ],
                    ),
                  ),
          bottomNavigationBar:
              state.isLoadingAddGuides
                  ? const SizedBox()
                  : Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: CustomButton(
                      text: 'حفظ',
                      onTap: () async {
                        try {
                          final models =
                              selectedCards
                                  .where(
                                    (card) => card.selectedEmployee != null,
                                  )
                                  .map((card) {
                                    final emp = card.selectedEmployee!;
                                    return AddGuideModel(
                                      fLastUpdate: DateTime.now(),
                                      fLastUpdateUser: 1,
                                      fLastUpdateSum: 0,
                                      fLastUpdateOper: 0,
                                      fCompanyId: companyId,
                                      fSeasonId: widget.center.fSeasonId,
                                      fCenterNo: widget.center.fCenterNo,
                                      fEmpNo: emp.empNo,
                                    );
                                  })
                                  .toList();

                          if (models.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'الرجاء اختيار موظف واحد على الأقل',
                                ),
                              ),
                            );
                            return;
                          }

                          final successfullyAdded = <AddGuideModel>[];
                          for (final model in models) {
                            try {
                              await BlocProvider.of<GuidesCubit>(
                                context,
                              ).addHajTransGuide([model]);
                              successfullyAdded.add(model);
                            } catch (e) {
                              final empNoMatch = RegExp(
                                r'\((\d+), (\d+)\)',
                              ).firstMatch(e.toString());
                              final duplicateEmpNo =
                                  empNoMatch != null
                                      ? int.parse(empNoMatch.group(2)!)
                                      : null;

                              if (duplicateEmpNo != null) {
                                continue;
                              } else {
                                log('خطأ غير متوقع: $e');
                              }
                            }
                          }

                          if (successfullyAdded.isNotEmpty) {
                            await BlocProvider.of<GuidesCubit>(
                              context,
                            ).fetchCenters();
                            await BlocProvider.of<GuidesCubit>(
                              context,
                            ).fetchSeasons();
                            showSuccessDialog(context);
                            Future.delayed(const Duration(seconds: 2), () {
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('كل الموظفين مضافين مسبقًا.'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$e حدث خطأ أثناء الحفظ')),
                          );
                        }
                      },
                    ),
                  ),
        );
      },
    );
  }
}
