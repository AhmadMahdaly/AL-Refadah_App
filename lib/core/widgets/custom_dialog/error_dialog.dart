import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showErrorDialog(
  BuildContext context, {
  required bool isBack,
  String message = 'هناك مشكلة في الحصول على البيانات\nاتصل بالدعم',
  IconData? icon,
  Color? color,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: kScaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: ErrorAnimationWidget(
              isBack: isBack,
              title: message,
              icon: icon ?? Icons.cloud_off_rounded,
              color: color ?? kAnalysisMediumColor,
            ),
          ),
        ),
      );
    },
  );
}

class ErrorAnimationWidget extends StatefulWidget {
  const ErrorAnimationWidget({
    required this.title,
    required this.isBack,
    this.icon,
    this.color,
    super.key,
  });
  final String title;
  final IconData? icon;
  final Color? color;
  final bool isBack;
  @override
  State<ErrorAnimationWidget> createState() => _ErrorAnimationWidgetState();
}

class _ErrorAnimationWidgetState extends State<ErrorAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 60.sp, color: widget.color),
          SizedBox(height: 10.h),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          if (widget.isBack) SizedBox(height: 10.h),
          if (widget.isBack)
            Center(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: kMainExtrimeLightColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: const Text(
                    'العودة',
                    style: TextStyle(color: kMainColor),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
