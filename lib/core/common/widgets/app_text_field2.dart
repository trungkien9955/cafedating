import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField2 extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool? autoFocus;
  final String? hintText;
  final int? maxLines;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatters;
  // final void Function(String value)? onChanged;

  const AppTextField2({
    super.key,
    required this.textEditingController,
    this.autoFocus,
    this.hintText,
    this.maxLines,
    this.prefixIcon,
    this.textInputType,
    this.textInputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      autofocus: autoFocus ?? false,
      maxLines: maxLines,
      keyboardType: textInputType ?? TextInputType.text,
      inputFormatters: textInputFormatters ?? [],
      decoration: InputDecoration(
        hintText: hintText ?? '',
        prefixIcon: prefixIcon ?? const SizedBox.shrink(),
        suffixIcon: textEditingController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  textEditingController.clear();
                },
                icon: Icon(Icons.clear),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
