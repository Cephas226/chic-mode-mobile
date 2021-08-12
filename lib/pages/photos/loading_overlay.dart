import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    Key key,
    this.isLoading,
    @required this.child,
  })  : assert(child != null),
        super(key: key);
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
