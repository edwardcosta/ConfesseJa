import 'package:flutter/material.dart';

import '../../res/strings.dart';

class HomeContet extends StatelessWidget {
  const HomeContet();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Index 0: Home',
        style: AppStrings.TITLE_STYLE,
      ),
    );
  }

}