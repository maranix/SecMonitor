import 'package:flutter/material.dart';
import 'package:sec_monitor/src/app/ui/colors.dart';

ThemeData lightTheme(context) => ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.black,
            bodyColor: Colors.black,
          ),
      extensions: const [
        ColorsExtension(
          primaryColor: primaryColor,
          accentColor: accentColor,
          textColor: textColor,
          enabledColor: enabledColor,
          disabledColor: disabledColor,
        ),
      ],
    );

ThemeData darkTheme(context) => ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.white,
            bodyColor: Colors.white,
          ),
      extensions: const [
        ColorsExtension(
          primaryColor: primaryColor,
          accentColor: accentColor,
          textColor: textColor,
          enabledColor: enabledColor,
          disabledColor: disabledColor,
        ),
      ],
    );

class ColorsExtension extends ThemeExtension<ColorsExtension> {
  const ColorsExtension({
    required this.primaryColor,
    required this.accentColor,
    required this.textColor,
    required this.enabledColor,
    required this.disabledColor,
  });

  final Color? primaryColor;
  final Color? accentColor;
  final Color? textColor;
  final Color? enabledColor;
  final Color? disabledColor;

  @override
  ThemeExtension<ColorsExtension> copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? textColor,
    Color? enabledColor,
    Color? disabledColor,
  }) {
    return ColorsExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      textColor: textColor ?? this.textColor,
      enabledColor: enabledColor ?? this.enabledColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
      covariant ThemeExtension<ColorsExtension>? other, double t) {
    if (other is! ColorsExtension) {
      return this;
    }

    return ColorsExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      enabledColor: Color.lerp(enabledColor, other.enabledColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
    );
  }
}
