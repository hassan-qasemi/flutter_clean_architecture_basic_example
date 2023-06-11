import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mobile/home_mobile_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(
      builder: (cts, cst) {
        return HomeMobileView(cst.maxHeight, cst.maxWidth);
      },
    );
  }
}
