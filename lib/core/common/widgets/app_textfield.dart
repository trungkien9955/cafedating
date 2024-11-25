import 'package:cafedating/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextfield extends StatefulWidget {
  final bool? autoFocus;
  final String? hintText;
  final int? maxLines;
  final Icon? prefixIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatters;
  final double? fontSize;
  final void Function(String value) onChanged;
  const AppTextfield(
      {super.key,
      this.autoFocus,
      this.hintText,
      this.maxLines,
      this.prefixIcon,
      this.textInputType,
      this.textInputFormatters,
      this.fontSize,
      required this.onChanged});

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: widget.autoFocus ?? false,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType ?? TextInputType.text,
      inputFormatters: widget.textInputFormatters ?? [],
      onChanged: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
        prefixIcon: widget.prefixIcon ?? const SizedBox.shrink(),
        suffixIcon: _controller.text.length > 0
            ? IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: const Icon(Icons.clear),
              )
            : const SizedBox.shrink(),
      ),
      style: TextStyle(fontSize: widget.fontSize ?? 12),
    );
  }
}
