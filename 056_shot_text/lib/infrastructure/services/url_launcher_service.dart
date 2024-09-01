import 'package:shot_text/domain/exceptions/url_not_launched_exception.dart';
import 'package:shot_text/domain/services/url_launcher_service.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncherService implements IUrlLauncherService {
  @override
  Future<void> launch(String url) async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw UrlNotLaunchedException();
    }
  }
}
