import 'package:flutter/material.dart';
import 'package:real_estate/app.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _numValue1 = 0;
  int _numValue2 = 0;
  bool _expandText = false;
  bool _hideCircleRow = false;

  @override
  void initState() {
    super.initState();
    _runAnimations();
  }

  // Combine all animations in one function
  void _runAnimations() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _expandText = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) { // Check if the widget is still mounted
        setState(() {
          _numValue1 = 1034;
          _numValue2 = 2212;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2600), () {
      setState(() {
        _hideCircleRow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // here gives is a summary of the agent's work
            HomeTopSection(
              expandText: _expandText,
              hideCircleRow: _hideCircleRow,
            ).padSymmetric(horizontal: 15, vertical: 10),
            // here contains the samples of estate by the agent
            HomeBottomSection(
              numValue1: _numValue1,
              numValue2: _numValue2,
              hideCircleRow: _hideCircleRow,
            ),
          ],
        ),
      ),
    );
  }
}
