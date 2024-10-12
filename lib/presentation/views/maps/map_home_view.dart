import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app.dart';

class MapHomeView extends StatefulWidget {
  const MapHomeView({super.key, this.darkMapStyle});
  final String? darkMapStyle;

  @override
  State<MapHomeView> createState() => MapSampleState();
}

class MapSampleState extends State<MapHomeView> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late AnimationController _animationController;
  bool _isExpanded = true;
  String? _darkMapStyle; // Initialize as null
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(59.929702, 30.3596437),
    zoom: 13,
  );

  @override
  void initState() {
    super.initState();
    _loadMapStyles(); // Load the map styles
    _animationController =
        AnimationController(vsync: this, duration: 700.ms, reverseDuration: 500.ms);
    _animationController.addStatusListener((listener) {
      if (listener == AnimationStatus.dismissed) {
        _setExpandedFalse();
      } else {
        _setExpandedTrue();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(ImagePaths.darkModeMap);
    setState(() {
      // Trigger a rebuild with the loaded map style
    });
  }

  void _setExpandedFalse() {
    setState(() {
      _isExpanded = false;
    });
  }

  void _setExpandedTrue() {
    setState(() {
      _isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Google Map
          GoogleMap(
            mapType: MapType.normal,
            style: widget.darkMapStyle ?? _darkMapStyle, // Use dark style if available
            compassEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          // Extended FAB button in bottomRight
          const FabRight(),

          // Left icons in column
          Positioned(
            left: 30,
            bottom: context.sizeHeight(0.11),
            child: OverlayDialog(
              animationController: _animationController,
            ),
          ),

          // Search bar
          const SearchBarWidget(),

          // Markers
          ListOfMarkersWidget(
            isExpanded: _isExpanded,
          ),
        ],
      ),
    );
  }
}

