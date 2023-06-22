import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:semana_do_flutter_testes_unitarios/person_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  final client = ClientMock();
  final repository = PersonRepository(client);

  test('deve pegar uma lista de person', () async {
    when(() => client.get(Uri.parse(
            'https://60f6ee22eb48e700179197f7.mockapi.io/api/v1/person')))
        .thenAnswer((_) async => http.Response(jsonReturn, 200));

    final list = await repository.getPerson();

    expect(list.isNotEmpty, equals(true));
    expect(list.first.name, equals('name 1'));
  });

  test('retorna uma exception se nao for statusCode 200', () {
    when(() => client.get(Uri.parse(
            'https://60f6ee22eb48e700179197f7.mockapi.io/api/v1/person')))
        .thenAnswer((_) async => http.Response(jsonReturn, 404));

    expect(() async => await repository.getPerson(), throwsException);
  });
}

const jsonReturn =
    '[{"name":"name 1","age":49,"height":55,"weight":43,"id":"1"},{"name":"name 2","age":77,"height":98,"weight":97,"id":"2"},{"name":"name 3","age":65,"height":81,"weight":52,"id":"3"},{"name":"name 4","age":15,"height":43,"weight":62,"id":"4"},{"name":"name 5","age":75,"height":6,"weight":27,"id":"5"},{"name":"name 6","age":3,"height":69,"weight":18,"id":"6"},{"name":"name 7","age":13,"height":19,"weight":44,"id":"7"},{"name":"name 8","age":5,"height":2,"weight":63,"id":"8"},{"name":"name 9","age":62,"height":36,"weight":13,"id":"9"},{"name":"name 10","age":61,"height":70,"weight":62,"id":"10"},{"name":"name 11","age":69,"height":57,"weight":42,"id":"11"},{"name":"name 12","age":0,"height":46,"weight":90,"id":"12"},{"name":"name 13","age":32,"height":42,"weight":45,"id":"13"},{"name":"name 14","age":6,"height":26,"weight":78,"id":"14"},{"name":"name 15","age":7,"height":67,"weight":65,"id":"15"},{"name":"name 16","age":81,"height":47,"weight":86,"id":"16"},{"name":"name 17","age":31,"height":90,"weight":23,"id":"17"},{"name":"name 18","age":96,"height":25,"weight":35,"id":"18"},{"name":"name 19","age":67,"height":77,"weight":25,"id":"19"},{"name":"name 20","age":58,"height":91,"weight":30,"id":"20"},{"name":"name 21","age":64,"height":19,"weight":67,"id":"21"},{"name":"name 22","age":72,"height":29,"weight":1,"id":"22"},{"name":"name 23","age":27,"height":24,"weight":4,"id":"23"},{"name":"name 24","age":42,"height":7,"weight":42,"id":"24"},{"name":"name 25","age":53,"height":75,"weight":78,"id":"25"},{"name":"name 26","age":94,"height":46,"weight":7,"id":"26"},{"name":"name 27","age":14,"height":41,"weight":5,"id":"27"},{"name":"name 28","age":93,"height":97,"weight":55,"id":"28"},{"name":"name 29","age":94,"height":84,"weight":36,"id":"29"},{"name":"name 30","age":65,"height":100,"weight":79,"id":"30"},{"name":"name 31","age":68,"height":80,"weight":13,"id":"31"},{"name":"name 32","age":2,"height":67,"weight":89,"id":"32"},{"name":"name 33","age":57,"height":91,"weight":2,"id":"33"},{"name":"name 34","age":17,"height":57,"weight":97,"id":"34"},{"name":"name 35","age":77,"height":44,"weight":68,"id":"35"},{"name":"name 36","age":86,"height":23,"weight":100,"id":"36"},{"name":"name 37","age":7,"height":27,"weight":80,"id":"37"},{"name":"name 38","age":66,"height":72,"weight":13,"id":"38"},{"name":"name 39","age":78,"height":66,"weight":41,"id":"39"},{"name":"name 40","age":30,"height":83,"weight":22,"id":"40"},{"name":"name 41","age":59,"height":55,"weight":3,"id":"41"},{"name":"name 42","age":23,"height":40,"weight":91,"id":"42"},{"name":"name 43","age":14,"height":16,"weight":70,"id":"43"},{"name":"name 44","age":76,"height":10,"weight":43,"id":"44"},{"name":"name 45","age":64,"height":4,"weight":83,"id":"45"},{"name":"name 46","age":43,"height":45,"weight":50,"id":"46"},{"name":"name 47","age":36,"height":13,"weight":55,"id":"47"},{"name":"name 48","age":12,"height":39,"weight":26,"id":"48"},{"name":"name 49","age":22,"height":28,"weight":85,"id":"49"},{"name":"name 50","age":91,"height":50,"weight":40,"id":"50"}]';
