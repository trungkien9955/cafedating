import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Color? color;
  const AppLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? color != null
            ? CircularProgressIndicator(color: color)
            : const CircularProgressIndicator()
        : color != null
            ? CupertinoActivityIndicator(color: color)
            : const CupertinoActivityIndicator();
  }
}
