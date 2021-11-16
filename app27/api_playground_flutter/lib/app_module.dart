import 'package:api_playground_flutter/controllers/home_controller.dart';
import 'package:api_playground_flutter/services/dio_client.dart';
import 'package:api_playground_flutter/services/json_placeholder_service.dart';
import 'package:api_playground_flutter/services/uno_client.dart';
import 'package:api_playground_flutter/views/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //Bind.singleton((i) => DioClient()),
        Bind.singleton((i) => UnoClient()),
        Bind.singleton((i) => JsonPlaceholderService(i())),
        Bind.singleton((i) => HomeController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
      ];
}
