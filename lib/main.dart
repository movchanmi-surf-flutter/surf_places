import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/domain/geo/geo_service.dart';
import 'package:places/domain/model_theme.dart';
import 'package:places/generated/assets.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<bool>('darkTheme');
  if (Hive.box<bool>('darkTheme').isEmpty) {
    await Hive.box<bool>('darkTheme').put('darkTheme', false);
  }
  if (await Geolocator.isLocationServiceEnabled()) {
    await GeoService.checkPermissions();
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MainScreen();
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(builder: (context, themeNotifier, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate
          ],
          locale: const Locale('ru'),
          supportedLocales: AppLocalizations.supportedLocales,
          home: const _EntryScreen(),
          debugShowCheckedModeBanner: false,
          theme:
              themeNotifier.isDark ? AppThemes.darkTheme : AppThemes.lightTheme,
          title: 'Places',
        );
      }),
    );
  }
}

class _EntryScreen extends StatefulWidget {
  const _EntryScreen();

  @override
  State<StatefulWidget> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<_EntryScreen> {
  _EntryScreenState();

  static const List<Widget> screens = [
    SightListScreen(),
    Text(''),
    VisitingScreen(),
    SettingsScreen(),
  ];
  int currind = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currind,
        onTap: (newInd) =>
            newInd != currind ? setState(() => currind = newInd) : null,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.imagesList,
                color: theme.bottomNavigationBarTheme.unselectedItemColor),
            activeIcon: SvgPicture.asset(Assets.imagesList,
                color: theme.bottomNavigationBarTheme.selectedItemColor),
            label: 'list',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.imagesHeartFilled,
                color: theme.bottomNavigationBarTheme.unselectedItemColor),
            activeIcon: SvgPicture.asset(Assets.imagesHeartFilled,
                color: theme.bottomNavigationBarTheme.selectedItemColor),
            label: 'favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.imagesSettings,
                color: theme.bottomNavigationBarTheme.unselectedItemColor),
            activeIcon: SvgPicture.asset(Assets.imagesSettings,
                color: theme.bottomNavigationBarTheme.selectedItemColor),
            label: 'settings',
          ),
        ],
      ),
      body: screens[currind],
    );
  }
}
