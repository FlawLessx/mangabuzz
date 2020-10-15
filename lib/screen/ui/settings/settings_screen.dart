import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangabuzz/core/localization/langguage_constants.dart';
import 'package:mangabuzz/core/model/language/language_model.dart';
import 'package:mangabuzz/screen/ui/settings/bloc/settings_screen_bloc.dart';
import 'package:mangabuzz/screen/widget/drawer/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedIndex = 0;

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
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
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
          getTranslated(context, "settingsName"),
          style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
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
                        getTranslated(context, "langguange"),
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
                                0: Text(Language.languageList[0].langguangeName,
                                    style: TextStyle(
                                        color: selectedIndex == 0
                                            ? Colors.white
                                            : Theme.of(context).primaryColor)),
                                1: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(120)),
                                  child: Text(
                                      Language.languageList[1].langguangeName,
                                      style: TextStyle(
                                          color: selectedIndex == 1
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .primaryColor)),
                                )
                              },
                              groupValue: selectedIndex,
                              onValueChanged: (int index) {
                                setState(() {
                                  selectedIndex = index;
                                  _changeLanguage(
                                      Language.languageList[selectedIndex]);
                                });
                              },
                              selectedColor: Theme.of(context).primaryColor,
                              borderColor: Theme.of(context).primaryColor,
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
                        getTranslated(context, "miscellaneous"),
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
                            text: getTranslated(context, "infoCache"),
                            confirmBtnText:
                                getTranslated(context, "confirmClearBtnText"),
                            confirmBtnColor: Colors.red,
                            onConfirmBtnTap: () {
                              BlocProvider.of<SettingsScreenBloc>(context)
                                  .add(ClearCache());
                              Navigator.pop(context);
                            },
                            cancelBtnText:
                                getTranslated(context, "cancelClearBtnText"),
                            showCancelBtn: true,
                          );
                        },
                        title: Text(
                          getTranslated(context, "clearCache"),
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
                          getTranslated(context, "contactMe"),
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
                          getTranslated(context, "checkNewRelease"),
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
                  "Mangabuzz App v1.0.0",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Poppins-Medium",
                      fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
