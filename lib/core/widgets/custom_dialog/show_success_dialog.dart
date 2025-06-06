import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSuccessDialog(
  BuildContext context, {
  String title = 'تم الحفظ بنجاح',
  int seconds = 2,
}) {
  showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false, // يمنع إغلاقه بالضغط خارج
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
            child: SuccessAnimationWidget(title: title),
          ),
        ),
      );
    },
  );

  // إغلاق تلقائي بعد 1.5 ثانية
  Future.delayed(Duration(seconds: seconds), () {
    Navigator.of(context).pop();
  });
}

class SuccessAnimationWidget extends StatefulWidget {
  const SuccessAnimationWidget({required this.title, super.key});
  final String title;

  @override
  State<SuccessAnimationWidget> createState() => _SuccessAnimationWidgetState();
}

class _SuccessAnimationWidgetState extends State<SuccessAnimationWidget>
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
          Icon(Icons.check_circle, size: 60.sp, color: Colors.green),
          SizedBox(height: 10.h),
          Text(
            '\n${widget.title}\n',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
