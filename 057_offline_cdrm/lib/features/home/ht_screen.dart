import 'package:flutter/material.dart';

import '../../utils/route_name.dart';
import 'screen_with_menu_and_tab.dart';

class HtScreen extends StatelessWidget {
  const HtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenWithMenuAndTab(RouteName.ht, tabs: ['H', 'NH']);
  }
}
