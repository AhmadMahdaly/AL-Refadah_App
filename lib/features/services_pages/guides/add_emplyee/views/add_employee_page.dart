import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/guides/add_emplyee/widgets/add_employee_body.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'إضافة موظف جديد'),
      ),
      body: const AddEmployeeBody(),
    );
  }
}
