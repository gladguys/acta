import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ATWaiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPouringHourglass(color: Colors.brown[800])
    );
  }
}
