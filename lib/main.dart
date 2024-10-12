import 'package:flutter/material.dart';
import 'package:real_estate/presentation/views/BottomNavBar.dart';
import 'package:real_estate/presentation/views/home/home_view.dart';
import 'package:real_estate/presentation/views/maps/map_home_view.dart';
import 'package:real_estate/shared/themes/app_colors.dart';
import 'package:real_estate/shared/themes/theme_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isBorderVisible = false;
  late double _begin, _end;

  int _pageIndex = 2;

  @override
  void initState() {
    super.initState();
    _begin = 30;
    _end = 20;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _rippleAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hideBorder();
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _hideBorder() {
    setState(() {
      _isBorderVisible = false; // Update the state properly
    });
  }

  void _displayBorder() {
    setState(() {
      _isBorderVisible = true; // Update the state properly
    });
  }

  void _onTap() {
    _displayBorder();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.lightTheme,
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.bgGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            [
              const MapHomeView(),
              const SizedBox(),
              const HomeView(),
              const SizedBox(),
              const SizedBox(),
            ][_pageIndex],

            BottomNavBar(
              pageIndex: _pageIndex,
              rippleAnimation: _rippleAnimation,
              isBorderVisible: _isBorderVisible,
              onTap: (index) {
                _onTap();
                setState(() {
                  _pageIndex = index;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
