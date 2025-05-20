import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/widgets/stage_card_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StageCard extends StatefulWidget {
  const StageCard({required this.stage, super.key});
  final StageModel stage;

  @override
  State<StageCard> createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  late TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.stage.fStageTimeLimit.toString(),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// اسم المرحلة
              StageCardText(
                text: widget.stage.fStageName ?? '',
                width: 100.w,
                align: TextAlign.start,
              ),

              /// من
              StageCardText(
                text: widget.stage.fStageNameFrom ?? '',
                width: 60.w,
                align: TextAlign.center,
              ),

              /// إلى
              StageCardText(
                text: widget.stage.fStageNameTo ?? '',
                width: 60.w,
                align: TextAlign.center,
              ),
              W(w: 8.sp),

              /// الزمن المتوقع للرحلة
              SizedBox(
                width: 50.w,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  controller: controller,
                  onChanged: (value) {
                    controller.text = value;
                    if (value.isNotEmpty && int.tryParse(value) != null) {
                      widget.stage.fStageTimeLimit = int.parse(value);
                    } else {
                      widget.stage.fStageTimeLimit = 0;
                    }
                  },
                ),
              ),
              const Spacer(),

              /// الحالة
              Transform.scale(
                scale: 0.8, // استخدام 0.8 للتصغير أو 2.0 للتكبير
                child: Switch(
                  value: widget.stage.fStageStatus == 1,
                  activeColor: kSecondaryColor,
                  onChanged: (value) {
                    setState(() {
                      widget.stage.fStageStatus = value ? 1 : 2;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
