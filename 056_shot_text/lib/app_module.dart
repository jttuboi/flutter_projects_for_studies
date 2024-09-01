import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/domain/services/converter_image_to_text_service.dart';
import 'package:shot_text/domain/services/share_service.dart';
import 'package:shot_text/domain/services/url_launcher_service.dart';
import 'package:shot_text/infrastructure/services/converter_image_to_text_service.dart';
import 'package:shot_text/infrastructure/services/share_service.dart';
import 'package:shot_text/infrastructure/services/url_launcher_service.dart';
import 'package:shot_text/presentation/camera_shot/pages/camera_shot_page.dart';
import 'package:shot_text/presentation/camera_shot/pages/shot_result_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<IConverterImageToTextService>((i) => ConverterImageToTextService()),
        Bind.factory<IUrlLauncherService>((i) => UrlLauncherService()),
        Bind.factory<IShareService>((i) => ShareService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(CameraShotPage.routeName, child: (context, args) => const CameraShotPage()),
        ChildRoute(ShotResultPage.routeName, child: (context, args) => ShotResultPage(imagePath: args.data as String)),
      ];
}
