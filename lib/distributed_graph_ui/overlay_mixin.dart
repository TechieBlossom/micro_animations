import 'package:flutter/material.dart';

mixin OverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  bool get isOverlayShown => _overlayEntry != null;

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _dismissibleOverlay(Widget child, Offset? offset) => Positioned(
        left: offset?.dx,
        top: offset?.dy,
        child: GestureDetector(
          onTap: removeOverlay,
          child: child,
        ),
      );

  void _insertOverlay(Widget child, Offset? offset) {
    _overlayEntry = OverlayEntry(
      builder: (_) => _dismissibleOverlay(child, offset),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void toggleOverlay(Widget child, Offset? offset) =>
      isOverlayShown ? removeOverlay() : _insertOverlay(child, offset);

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }
}
