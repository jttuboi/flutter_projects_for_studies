import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import '../../widgets/show_my_dialog.dart';
import '../init/authentication_change_notifier.dart';

class ScreenWithMenuAndTab extends StatefulWidget {
  const ScreenWithMenuAndTab(this.route, {required this.tabs, this.contentsTab1 = const [], super.key});

  final RouteName route;
  final List<String> tabs;
  final List<Widget> contentsTab1;

  @override
  State<ScreenWithMenuAndTab> createState() => _ScreenWithMenuAndTabState();
}

class _ScreenWithMenuAndTabState extends State<ScreenWithMenuAndTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.route.name), backgroundColor: widget.route.color),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Column(children: [
              const Text('menu'),
              Button.route(RouteName.hm, onTap: (widget.route == RouteName.hm) ? null : () => Modular.to.navigate(RouteName.hm.path)),
              Button.route(RouteName.pf, onTap: (widget.route == RouteName.pf) ? null : () => Modular.to.navigate(RouteName.pf.path)),
              Button.route(RouteName.pl,
                  onTap: (widget.route == RouteName.pl)
                      ? null
                      : () {
                          final userId = Modular.get<AuthenticationChangeNotifier>().userLogged;
                          Modular.to.navigate(RouteName.pl.path.replaceAll(':id', userId));
                        }),
              Button.route(RouteName.sd, onTap: (widget.route == RouteName.sd) ? null : () => Modular.to.navigate(RouteName.sd.path)),
              Button.route(RouteName.hp, onTap: (widget.route == RouteName.hp) ? null : () => Modular.to.navigate(RouteName.hp.path)),
              Button.route(RouteName.f, onTap: (widget.route == RouteName.f) ? null : () => Modular.to.navigate(RouteName.f.path)),
              Button.route(RouteName.sl, onTap: (widget.route == RouteName.sl) ? null : () => showMyDialog(context, RouteName.sl)),
              Button.route(RouteName.ht, onTap: (widget.route == RouteName.ht) ? null : () => Modular.to.navigate(RouteName.ht.path)),
              Button.route(RouteName.c, onTap: (widget.route == RouteName.c) ? null : () => Modular.to.navigate(RouteName.c.path)),
              const Text('menu bottom'),
              Button.route(RouteName.sair, onTap: () {
                Modular.get<AuthenticationChangeNotifier>().logout().whenComplete(() {
                  Modular.to.navigate(RouteName.l.path);
                });
              }),
              Button.route(RouteName.aj, onTap: () => showMyDialog(context, RouteName.aj)),
              Button.route(RouteName.tf, onTap: () => showMyDialog(context, RouteName.tf)),
            ]),
            Column(children: [
              SizedBox(
                width: 200,
                height: 50,
                child: TabBar(controller: _tabController, tabs: [
                  Tab(child: Tab(child: Text(widget.tabs[0]))),
                  Tab(child: Tab(child: Text(widget.tabs[1]))),
                ]),
              ),
              SizedBox(
                width: 200,
                height: 400,
                child: TabBarView(controller: _tabController, children: [
                  Center(
                      child: Container(
                          width: 200,
                          height: 400,
                          color: widget.route.color,
                          child: Column(children: [
                            Text('Tab ${widget.tabs[0]}'),
                            ...widget.contentsTab1,
                          ]))),
                  Center(child: Container(width: 200, height: 400, color: widget.route.color, child: Text('Tab ${widget.tabs[1]}'))),
                ]),
              ),
            ]),
          ],
        ),
        const Text('bottom bar'),
        Wrap(
          children: [
            Button.route(RouteName.hm, onTap: (widget.route == RouteName.hm) ? null : () => Modular.to.navigate(RouteName.hm.path)),
            Button.route(RouteName.hp, onTap: (widget.route == RouteName.hp) ? null : () => Modular.to.navigate(RouteName.hp.path)),
            Button.route(RouteName.tm, onTap: () => showMyDialog(context, RouteName.tm)),
            Button.route(RouteName.pl,
                onTap: (widget.route == RouteName.pl)
                    ? null
                    : () {
                        final userId = Modular.get<AuthenticationChangeNotifier>().userLogged;
                        Modular.to.navigate(RouteName.pl.path.replaceAll(':id', userId));
                      }),
            Button.route(RouteName.c, onTap: (widget.route == RouteName.c) ? null : () => Modular.to.navigate(RouteName.c.path)),
          ],
        ),
      ]),
    );
  }
}
