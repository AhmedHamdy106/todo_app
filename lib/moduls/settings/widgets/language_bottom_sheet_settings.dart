import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/moduls/settings/widgets/selected_item.dart';
import 'package:todo_app/moduls/settings/widgets/unSelected_item.dart';
import 'package:todo_app/settings_provider.dart';

class languageBottomSheetSettings extends StatelessWidget {
  const languageBottomSheetSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.selectArabicLanguage();
            },
            child: provider.CurrentLanguage == "ar"
                ? SelectedItem("عربي")
                : UnSelectedItem("عربي"),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              provider.selectEnglishLanguage();
            },
            child: provider.CurrentLanguage == "en"
                ? SelectedItem('English')
                : UnSelectedItem('English'),
          ),
        ],
      ),
    );
  }
}
