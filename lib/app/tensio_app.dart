import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tensio/core/design/tensio_theme.dart';
import 'package:tensio/features/shell/presentation/app_shell.dart';

class TensioApp extends StatelessWidget {
  const TensioApp({super.key});

  static const supportedLocales = <Locale>[
    Locale('tr'), Locale('en'), Locale('es'), Locale('pt', 'BR'), Locale('fr'),
    Locale('de'), Locale('ar'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale('ja'), Locale('ko'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tensio',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: TensioTheme.dark,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AppShell(),
    );
  }
}
