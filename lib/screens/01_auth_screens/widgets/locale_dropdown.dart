import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../resourses/colors_manager.dart';

// dropdown menu to set locale
class LocaleDropdown extends StatelessWidget {
  const LocaleDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var menuItems = <DropdownMenuItem>[];
    for (var locale in context.supportedLocales) {
      menuItems.add(
        DropdownMenuItem(
            value: {'locale': locale},
            child: CountryFlag.fromCountryCode(locale.countryCode!)),
      );
    }
    return DropdownButton(
      items: menuItems,
      onChanged: (value) {
        context.setLocale(value['locale']);
      },
      icon: Icon(
        Icons.language,
        color: ColorsManager.darkGreen,
      ),
    );
  }
}
