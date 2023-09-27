import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/moduls/settings/widgets/selected_item.dart';
import 'package:todo_app/moduls/settings/widgets/unSelected_item.dart';
import 'package:todo_app/settings_provider.dart';

class themeBottonSheetSettings extends StatelessWidget {
  const themeBottonSheetSettings({super.key});

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
              provider.enableDarkTheme();
            },
            child: provider.isDark()
                ? SelectedItem("Dark")
                : UnSelectedItem("Dark"),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              provider.enableLightTheme();
            },
            child: provider.isDark()
                ? UnSelectedItem('Light')
                : SelectedItem('Light'),
          ),
        ],
      ),
    );
  }
}
