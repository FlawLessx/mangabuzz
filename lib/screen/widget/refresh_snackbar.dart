import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget refreshSnackBar(Function function) {
  return SnackBar(
    duration: const Duration(minutes: 5),
    content: Text('refreshText'.tr()),
    action: SnackBarAction(label: 'refreshButton'.tr(), onPressed: function),
  );
}
