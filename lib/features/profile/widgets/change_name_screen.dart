import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_text_field2.dart';
import 'package:cafedating/core/common/widgets/app_textfield.dart';
import 'package:cafedating/features/profile/controller/profile_controller.dart';
import 'package:cafedating/features/profile/controller/riverpod_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeNameScreen extends ConsumerStatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  ConsumerState<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends ConsumerState<ChangeNameScreen> {
  String newName = '';
  final TextEditingController textEditingController = TextEditingController();
  void initState() {
    super.initState();
    textEditingController.addListener(_listener);
  }

  void dispose() {
    textEditingController.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {
      newName = textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Đổi tên'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          AppTextField2(
            textEditingController: textEditingController,
          ),
          AppFilledButton2(
            label: 'OK',
            onPressed: () {
              ProfileController(buildContext: context, ref: ref)
                  .changeName(newName);
            },
          )
        ],
      )),
    );
  }
}
