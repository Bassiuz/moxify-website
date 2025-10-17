import 'package:MoxifyMTG/app_router.dart';
import 'package:MoxifyMTG/theme/color_schemes.g.dart';
import 'package:MoxifyMTG/theme/custom_color.g.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialThemeWrapper extends StatelessWidget {
  const MaterialThemeWrapper({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    // Define the custom font family name
    final String fontName = GoogleFonts.sourceSerif4().fontFamily!;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        // Create a function to apply the custom font to a TextTheme
        TextTheme applyCustomFont(TextTheme baseTheme) {
          return baseTheme.copyWith(
            headlineLarge: baseTheme.headlineLarge
                ?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
            headlineMedium: baseTheme.headlineMedium
                ?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
            headlineSmall: baseTheme.headlineSmall
                ?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
            displayLarge:
                baseTheme.displayLarge?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
            displayMedium: baseTheme.displayMedium
                ?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
            displaySmall:
                baseTheme.displaySmall?.copyWith(fontFamily: fontName, fontStyle: FontStyle.italic),
          );
        }

        return MaterialApp.router(
          title: 'Moxify MTG - Collect - Scan - Track',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            extensions: [lightCustomColors],
            textTheme:
                applyCustomFont(ThemeData(colorScheme: lightScheme).textTheme), // Apply custom font
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
            extensions: [darkCustomColors],
            textTheme: applyCustomFont(
              ThemeData(colorScheme: darkScheme, brightness: Brightness.dark).textTheme,
            ), // Apply custom font
          ),
          themeMode: ThemeMode.dark,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
