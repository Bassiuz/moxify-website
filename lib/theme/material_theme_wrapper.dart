import 'package:MoxifyMTG/theme/color_schemes.g.dart';
import 'package:MoxifyMTG/theme/custom_color.g.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class MaterialThemeWrapper extends StatelessWidget {
  const MaterialThemeWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return MaterialApp(
          title: 'Moxify MTG - Collect - Scan - Track',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            extensions: [lightCustomColors],
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
            extensions: [darkCustomColors],
          ),
          themeMode: ThemeMode.dark,
          home: child,
        );
      },
    );
  }
}
