import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';
import 'package:semana_do_flutter_arquitetura/app/repositories/apiadvisor_repository.dart';
import 'package:semana_do_flutter_arquitetura/app/services/client_http_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/viewmodels/apiadvisor_viewmodel.dart';

// class ClientHttpMock implements IClientHttp {
//   @override
//   void addToken(String token) {}

//   @override
//   Future get(String url) async {
//     return [
//       ApiadvisorModel(country: "BR", date: "2020-05-30", text: "texto").toJson()
//     ];
//   }
// }

// class ClientHttpErrorMock implements IClientHttp {
//   @override
//   void addToken(String token) {}

//   @override
//   Future get(String url) async {
//     return [];
//   }
// }

class ClientHttpMockito extends Mock implements IClientHttp {}

// main() {
//   var mock = ClientHttpMockito();
//   final viewModel = ApiadvisorViewModel(ApiadvisorRepository(mock));

//   test("ApiAdvisorViewModel error", () async {
//     when(mock.get("http://...")).thenThrow(Exception("error"));

//     viewModel.fill();

//     expect(viewModel.apiadvisorModel.value.country, "");
//     expect(viewModel.apiadvisorModel.value.date, "");
//     expect(viewModel.apiadvisorModel.value.text, "");
//   });

//   test("ApiAdvisorViewModel success", () async {
//     when(mock.get("http://...")).thenAnswer((_) => Future.value([
//           ApiadvisorModel(country: "BR", date: "2020-05-30", text: "texto")
//               .toJson()
//         ]));

//     viewModel.fill();

//     expect(viewModel.apiadvisorModel.value, isA<ApiadvisorModel>());
//   });


//   // test("ApiAdvisorViewModel error", () async {
//   //   final viewModel = ApiadvisorViewModel(ApiadvisorRepository(ClientHttpErrorMock()));

//   //   viewModel.fill();

//   //   expect(viewModel.apiadvisorModel.value.country, "");
//   //   expect(viewModel.apiadvisorModel.value.date, "");
//   //   expect(viewModel.apiadvisorModel.value.text, "");
//   // });

//   // test("ApiAdvisorViewModel success", () async {
//   //   final viewModel = ApiadvisorViewModel(ApiadvisorRepository(ClientHttpMock()));

//   //   viewModel.fill();

//   //   expect(viewModel.apiadvisorModel.value, isA<ApiadvisorModel>());
//   // });
// }
