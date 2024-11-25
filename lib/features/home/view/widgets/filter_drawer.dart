import 'package:cafedating/core/common/widgets/app_filled_button.dart';
import 'package:cafedating/core/common/widgets/app_filled_button2.dart';
import 'package:cafedating/core/common/widgets/app_height_spacer.dart';
import 'package:cafedating/core/common/widgets/app_text.dart';
import 'package:cafedating/core/common/widgets/app_text_title_medium.dart';
import 'package:cafedating/core/common/widgets/app_textfield.dart';
import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/features/home/controller/home_controller.dart';
import 'package:cafedating/features/home/notifier/filter_notifier.dart';
import 'package:cafedating/features/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterDrawer extends ConsumerStatefulWidget {
  const FilterDrawer({super.key});

  @override
  ConsumerState<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends ConsumerState<FilterDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final filterData = ref.watch(filterNotifierProvider);
    print(filterData.radius);
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              child: Row(
            children: [
              Icon(Icons.filter_list),
              AppWidthSpacer(width: 8),
              AppTextTitleMedium(text: 'Bộ lọc')
            ],
          )),
          AppTextfield(
            onChanged: (value) => ref
                .watch(filterNotifierProvider.notifier)
                .updateFilterRadius(int.parse(value)),
            hintText: filterData.radius.toString(),
            textInputType: TextInputType.number,
            textInputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          AppHeightSpacer(height: 12),
          AppFilledButton2(label: 'OK', onPressed: () {}),
          AppHeightSpacer(height: 12),
          AppFilledButton2(
              label: 'Đăng xuất',
              onPressed: () {
                LoginController(ref: ref, context: context).handleLogout();
              })
        ],
      ),
    );
  }
}
