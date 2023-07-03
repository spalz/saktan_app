import 'package:flutter/material.dart';

class TopProgressIndicator extends StatelessWidget {
  const TopProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: SizedBox(
        height: 10,
        child: Align(
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(90, 220, 190, 1),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(240, 244, 255, 1),
            ),
          ),
        ),
      ),
    );
  }
}
