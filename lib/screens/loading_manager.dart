import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager({Key? key, required this.isLoading, required this.child})
      : super(key: key);
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
                height: double.infinity,
                color: Colors.white,
              )
            : Container(),
        isLoading
            ? const Center(
                child: SpinKitWave(
                  color: Colors.black,
                ),
              )
            : Container(),
      ],
    );
  }
}
