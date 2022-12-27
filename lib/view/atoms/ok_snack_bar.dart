import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';

class OkSnackBar{
  const OkSnackBar();
  
  static SnackBar getSnackBar({required String responseMessage}) {
    return SnackBar(
      key: AppKeyName.snackBar,
      content: Text(responseMessage),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {},
      ),
    );
  }
}
