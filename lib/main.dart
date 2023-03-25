import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_flutter/constants/sizes.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme: ThemeData(
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
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
          )),
      home: const LayoutBuilderCodeLab(),
    );
  }
}

class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              color: Colors.teal,
              child: Center(
                child: Text(
                  '${size.width} ${constraints.maxWidth}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
