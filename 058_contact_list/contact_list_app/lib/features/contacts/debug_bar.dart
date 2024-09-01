import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/contact_offline_datasource.dart';
import '../../widgets/c_snack_bar_mixin.dart';

class DebugBar extends StatelessWidget with CSnackBarMixin implements PreferredSizeWidget {
  const DebugBar({required this.height, this.child, super.key});

  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: Colors.blue.shade400,
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Text('Debug:', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue.shade600),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => _emptyCache(context),
                  child: const Text('Clear cache')),
              const SizedBox(width: 10),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue.shade600),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => _printContacts(),
                  child: const Text('Print contacts')),
              const SizedBox(width: 10),
            ],
          ),
        ),
        if (child != null) child!,
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);

  Future<void> _emptyCache(BuildContext context) async {
    await DefaultCacheManager().emptyCache().then((_) {
      showSnackBarForSuccess(context, text: 'Cache cleaned.');
    });
  }

  void _printContacts() {
    GetIt.I.get<IContactOfflineDataSource>().printContacts(isShort: true);
  }
}
