import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';
import 'package:mangabuzz/core/model/language/language_model.dart';
import 'package:mangabuzz/screen/ui/settings/cubit/settings_screen_cubit.dart';
import 'package:mangabuzz/screen/widget/drawer/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    context.bloc<SettingsScreenCubit>().getSelectedIndex();
    super.initState();
  }

  _lauchUrl() async {
    const url = 'https://github.com/FlawLessx/mangabuzz/releases';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _lauchEmail() {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'yanuarbimantoro@gmail.com',
        queryParameters: {'subject': 'Mangabuzz App'});

    launch(_emailLaunchUri.toString());
  }

  void _changeLanguage(Language language) async {
    await setLocale(language.locale.languageCode);
    context.locale = language.locale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(
          selectedIndex: 5,
        ),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              tooltip: "Back",
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            "settingsName".tr(),
            style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold"),
          ),
        ),
        body: BlocBuilder<SettingsScreenCubit, SettingsScreenState>(
          builder: (context, state) {
            if (state is SettingsScreenLoaded) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "langguange".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins-SemiBold",
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              Container(
                                child: Center(
                                  child: CupertinoSegmentedControl<int>(
                                      children: {
                                        0: Text(
                                            Language
                                                .languageList[0].langguangeName,
                                            style: TextStyle(
                                                color: state.selectedIndex == 0
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor)),
                                        1: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenUtil().setHeight(20),
                                              horizontal:
                                                  ScreenUtil().setWidth(120)),
                                          child: Text(
                                              Language.languageList[1]
                                                  .langguangeName,
                                              style: TextStyle(
                                                  color:
                                                      state.selectedIndex == 1
                                                          ? Colors.white
                                                          : Theme.of(context)
                                                              .primaryColor)),
                                        )
                                      },
                                      groupValue: state.selectedIndex,
                                      onValueChanged: (int index) {
                                        setState(() {
                                          _changeLanguage(
                                              Language.languageList[index]);
                                          context
                                              .bloc<SettingsScreenCubit>()
                                              .getSelectedIndex();
                                        });
                                      },
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                      borderColor:
                                          Theme.of(context).primaryColor,
                                      pressedColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                      unselectedColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "miscellaneous".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins-SemiBold",
                                    fontSize: 16),
                              ),
                              ListTile(
                                onTap: () {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.warning,
                                    text: "infoCache".tr(),
                                    confirmBtnText: "confirmClearBtnText".tr(),
                                    confirmBtnColor: Colors.red,
                                    onConfirmBtnTap: () {
                                      context
                                          .bloc<SettingsScreenCubit>()
                                          .clearCache();
                                      Navigator.pop(context);
                                    },
                                    cancelBtnText: "cancelClearBtnText".tr(),
                                    showCancelBtn: true,
                                  );
                                },
                                title: Text(
                                  "clearCache".tr(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Icon(Icons.chevron_right),
                              ),
                              Divider(
                                thickness: 2,
                                height: 0,
                              ),
                              ListTile(
                                onTap: () {
                                  _lauchEmail();
                                },
                                title: Text(
                                  "contactMe".tr(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Icon(Icons.chevron_right),
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                              ),
                              ListTile(
                                onTap: () {
                                  _lauchUrl();
                                },
                                title: Text(
                                  "checkNewRelease".tr(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Icon(Icons.chevron_right),
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          "Mangabuzz App v1.0.2",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins-Medium",
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
