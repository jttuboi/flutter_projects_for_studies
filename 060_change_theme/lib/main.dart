import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:teste_tema_independente/themes/theme_styles.dart';
import 'package:teste_tema_independente/themes/theme_styles1.dart';
import 'package:teste_tema_independente/themes/theme_styles2.dart';
import 'package:teste_tema_independente/widgets/c_button.dart';
import 'package:teste_tema_independente/widgets/c_dialog.dart';

void main() {
  if (!GetIt.I.isRegistered<ThemeController>()) {
    // passa os dados iniciais do tema. esses dados podem ser dados vindos do banco de dados.
    // se não passar, irá pegar o tema default.
    GetIt.I.registerSingleton(ThemeController(
      initialThemeMode: ThemeMode.dark,
      initialThemeStyles: const ThemeStyles1(),
    ));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // utilizado provider + get_it apenas para facilitar a atualização do tema no MaterialApp
    return ChangeNotifierProvider(
      create: (_) => GetIt.I.get<ThemeController>(),
      child: Consumer<ThemeController>(
        builder: (_, themeController, __) {
          return MaterialApp(
            navigatorKey: GM.navigatorKey,
            theme: themeController.themeSelected,
            darkTheme: themeController.darkThemeSelected,
            themeMode: themeController.themeModeSelected,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('teste temas')),
      body: Column(
        children: [
          const SizedBox(height: 16),

          //
          Row(children: [
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeMode(ThemeMode.system), child: const Text('auto')),
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeMode(ThemeMode.light), child: const Text('light')),
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeMode(ThemeMode.dark), child: const Text('dark')),
          ]),

          const SizedBox(height: 16),

          Row(children: [
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeStyles(const ThemeStyles()), child: const Text('default')),
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeStyles(const ThemeStyles1()), child: const Text('tema 1')),
            TextButton(onPressed: () => GetIt.I.get<ThemeController>().selectThemeStyles(const ThemeStyles2()), child: const Text('tema 2')),
          ]),

          const SizedBox(height: 16),
          const Text('primary (ou CButtonStylePrimary default)'),

          //
          const Text('preenchido'),
          CButton(const CButtonData('texto'), onPressed: () {}),
          CButton(const CButtonData('texto disable'), isEnabled: false, onPressed: () {}),

          //
          const Text('inverso'),
          CButton(const CButtonData('texto'), style: const CButtonStylePrimary(isFilled: false), onPressed: () {}),
          CButton(const CButtonData('texto disable'), style: const CButtonStylePrimary(isFilled: false), isEnabled: false, onPressed: () {}),

          const SizedBox(height: 16),
          const Text('secondary (variação do CButtonStylePrimary q é o default)'),

          //
          const Text('preenchido'),
          CButton(const CButtonData('texto'), style: const CButtonStyleSecondary(), onPressed: () {}),
          CButton(const CButtonData('texto disable'), style: const CButtonStyleSecondary(), isEnabled: false, onPressed: () {}),

          //
          const Text('inverso'),
          CButton(const CButtonData('texto'), style: const CButtonStyleSecondary(isFilled: false), onPressed: () {}),
          CButton(const CButtonData('texto disable'), style: const CButtonStyleSecondary(isFilled: false), isEnabled: false, onPressed: () {}),

          const SizedBox(height: 16),
          const Text('tertiary (extendendo do CButtonStylePrimary)'),
          //
          CButton(const CButtonData('texto'), style: const CButtonStyleTertiary(), onPressed: () {}),

          //
          TextButton(
              onPressed: () {
                GM.showDialog(DialogData(), builder: (_) {
                  return CDialog(CDialogData(title: 'titulo', text: 'texto'));
                });
              },
              child: const Text('abre dialog sem context')),
        ],
      ),
    );
  }
}

class ThemeController extends ChangeNotifier {
  ThemeController({
    ThemeMode? initialThemeMode,
    ThemeStyles? initialThemeStyles,
  })  : _themeMode = initialThemeMode ?? ThemeMode.system,
        _themeStyles = initialThemeStyles ?? const ThemeStyles();

  ThemeMode _themeMode;
  ThemeStyles _themeStyles;

  ThemeMode get themeModeSelected => _themeMode;

  ThemeData get themeSelected => ThemeData.light(useMaterial3: false).copyWith(extensions: [
        _themeStyles.appColors,
        _themeStyles.appTextStyles,
      ]);

  ThemeData get darkThemeSelected => ThemeData.dark(useMaterial3: false).copyWith(extensions: [
        _themeStyles.appColorsDark,
        _themeStyles.appTextStylesDark,
      ]);

  void selectThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void selectThemeStyles(ThemeStyles themeStyles) {
    _themeStyles = themeStyles;
    notifyListeners();
  }
}
