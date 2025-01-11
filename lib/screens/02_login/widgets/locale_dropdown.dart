import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../resourses/colors_manager.dart';


// dropdown menu to set locale
class LocaleDropdown extends StatefulWidget {
  final Function(String languageCode, String? countryCode)? callback;
  const LocaleDropdown({super.key, required this.callback});

  @override
  State<LocaleDropdown> createState() => _LocaleDropdownState();
}

class _LocaleDropdownState extends State<LocaleDropdown> {
  @override
  Widget build(BuildContext context) {
    var menuItems = <DropdownMenuItem>[];
    for (var locale in context.supportedLocales) {
      menuItems.add(
        DropdownMenuItem(
            value: {'countryCode': locale.countryCode, 'languageCode': locale.languageCode},
            child: CountryFlag.fromCountryCode(locale.countryCode!)),
      );
    }
    return DropdownButton(
      items: menuItems,
      onChanged: (value) {
        setState(() {
           widget.callback?.call(value['languageCode'], value['countryCode']);
        });
       
      },
      icon: Icon(Icons.language , color: ColorsManager.darkGreen,),
    );
  }
}
