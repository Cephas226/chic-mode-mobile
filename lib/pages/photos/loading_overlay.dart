import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    required this.isLoading,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SpinKitThreeBounce(
          color: Colors.redAccent,
          size: 50.0,
        )
      );
    }
    return child;
  }
}
