import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_theme.dart';
import 'package:todo_app/moduls/settings/widgets/language_bottom_sheet_settings.dart';
import 'package:todo_app/moduls/settings/widgets/theme_bottom_sheet_settings.dart';

import '../../settings_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var applocal = AppLocalizations.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 40, left: 20),
            width: mediaQuery.width,
            height: mediaQuery.height * 0.15,
            color: AppTheme.lightPrimary,
            child: Text(
              "Settings",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  applocal!.language,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: !provider.isDark() ? Colors.black : Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showLanguageBottomSheet(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.CurrentLanguage == "ar" ? "عربي" : "English",
                          style: theme.textTheme.bodyMedium,
                        ),
                        Icon(Icons.arrow_drop_down_sharp,
                            color: theme.primaryColor),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  applocal!.theme,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: !provider.isDark() ? Colors.black : Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showThemeBottomSheet(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider.isDark() ? "Dark" : "Light",
                          style: theme.textTheme.bodyMedium,
                        ),
                        Icon(Icons.arrow_drop_down_sharp,
                            color: theme.primaryColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => languageBottomSheetSettings(),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => themeBottonSheetSettings(),
    );
  }
}
