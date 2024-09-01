import 'package:shelf/shelf.dart';

import '../entities/entities.dart';

final defaultHeaders = {
  'accept': '*/*', // default = '*/*'
  'content-type': 'application/json', // default = 'application/json'
};

Handler addBasePathUrl(Handler innerHandler) {
  return (request) async {
    request = request.change(path: 'v1'); // default = 'v1'
    return innerHandler(request);
  };
}

ResponseType responseTypeToShow = ResponseType.useDefinedInMethod; // default = ResponseType.xUseDefinedInMethod
