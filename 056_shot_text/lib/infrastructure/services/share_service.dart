import 'package:share_plus/share_plus.dart';
import 'package:shot_text/domain/services/share_service.dart';

class ShareService implements IShareService {
  @override
  Future<void> share(String text) async {
    await Share.share(text);
  }
}
