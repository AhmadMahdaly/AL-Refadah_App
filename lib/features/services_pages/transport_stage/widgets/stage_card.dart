import 'package:alrefadah/core/themes/colors_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StageCardText(
                text: widget.stage.fStageNo.toString(),
                width: 40.w,
              ),
              StageCardText(
                text: widget.stage.fStageName,
                width: 120.w,
                align: TextAlign.start,
              ),
              StageCardText(
                text: widget.stage.fStageNameFrom,
                width: 60.w,
                align: TextAlign.center,
              ),
              StageCardText(
                text: widget.stage.fStageNameTo,
                width: 60.w,
                align: TextAlign.center,
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.8, // جرب 0.8 للتصغير أو 2.0 للتكبير
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
