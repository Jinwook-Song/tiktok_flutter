import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_flutter/common/widget/theme_configuration/theme_config.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/generated/l10n.dart';
import 'package:tiktok_flutter/router.dart';

void main() async {
  // App 실행전에 초기화하고 binding 해야한다
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

// 앱의 최상단에서 할 필요는 없고, 각 Screen마다 따로 설정할 수 있다
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    S.load(const Locale('en'));
    return ValueListenableBuilder(
      valueListenable: useDarkThemeConfig,
      builder: (context, value, child) => MaterialApp.router(
        themeMode: useDarkThemeConfig.value ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'TikTok Clone',
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ko'),
        ],
        theme: ThemeData(
            // useMaterial3: true,
            brightness: Brightness.light,
            textTheme: Typography.blackMountainView,
            primaryColor: const Color(0xFFE9435A),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFE9435A),
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.grey.shade50,
            ),
            splashColor: Colors.transparent, // tap color
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            listTileTheme: const ListTileThemeData(
              iconColor: Colors.black,
            )),
        darkTheme: ThemeData(
          // useMaterial3: true,
          brightness: Brightness.dark,
          textTheme: Typography.whiteMountainView,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}
