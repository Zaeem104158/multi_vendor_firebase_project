import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/l10n/l10n.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/auth/customer/signup_customer_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SelectApplicationThemeAndLanguage extends StatelessWidget {
  const SelectApplicationThemeAndLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    final flag = L10n.getFlag(Localizations.localeOf(context).languageCode);
    final locale = uiProvider.locale;

    return SafeArea(
        child: Scaffold(
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextComponet(
                isClickAble: true,
                textTitle: uiProvider.themeMode == ThemeModeType.light
                    ? AppLocalizations.of(context)!.light
                    : AppLocalizations.of(context)!.dark,
                fontColor: blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              CustomTextComponet(
                isClickAble: true,
                textTitle: AppLocalizations.of(context)!.on,
                fontColor: blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ],
          ),
          trailing: Switch(
            value: uiProvider.themeMode == ThemeModeType.light,
            onChanged: (value) {
              ThemeModeType selectedThemeMode =
                  value ? ThemeModeType.light : ThemeModeType.dark;
              uiProvider.saveThemeMode(selectedThemeMode);
            },
          ),
        ),
      ),
      CustomDivider(
        withTextDivider: true,
        onlyDivider: false,
        width: double.infinity,
        thickness: 1,
        color: cyanColor,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: CustomTextComponet(
              isClickAble: true,
              textTitle: AppLocalizations.of(context)!.language,
              fontColor: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: locale,
                icon: Container(width: 12),
                items: L10n.all.map(
                  (locale) {
                    final flag = L10n.getFlag(locale.languageCode);

                    return DropdownMenuItem(
                      child: Center(
                        child: Text(
                          flag,
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      value: locale,
                      onTap: () {
                        final provider =
                            Provider.of<UiProvider>(context, listen: false);
                        provider.setLocale(locale);
                      },
                    );
                  },
                ).toList(),
                onChanged: (_) {},
              ),
            )),
      ),
      GestureDetector(
        onTap: () {
          Future.delayed(const Duration(milliseconds: 01), () {
            navigationPush(context,
                removeUntil: false, screenWidget: CustomerSignUpScreen());
          });
        },
        child: Container(
          height: 50.0,
          width: customHeightWidth(context, width: true) - 40.0,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
          child: Center(
            child: CustomTextComponet(
              textTitle: AppLocalizations.of(context)!.submit,
              isClickAble: true,
            ),
          ),
        ),
      ),
    ])));
  }
}

class LanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 72,
        child: Text(
          flag,
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}
