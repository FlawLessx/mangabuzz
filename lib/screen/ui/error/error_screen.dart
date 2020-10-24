import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorPage extends StatelessWidget {
  final VoidCallback callback;

  const ErrorPage({@required this.callback, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                    "resources/img/error.png",
                    width: ScreenUtil().setWidth(600),
                    height: ScreenUtil().setWidth(600),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Text('refreshText'.tr()),
              FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    callback.call();
                  },
                  child: Text(
                    'refreshButton'.tr(),
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Poppins-SemiBold"),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
