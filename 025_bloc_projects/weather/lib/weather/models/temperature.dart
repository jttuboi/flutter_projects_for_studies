import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsExtension on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

// esse método converte os valores de temperatura, mais especificamente qualquer número double.
// porém fica aqui, pois se trata de temperatura
// imagino que o correto é ficar dentro da Temperature, por mais que seja uma lógica,
// essa conversão pertence a Temperature.
extension DoubleExtension on double {
  double toFahrenheit() => ((this * 9 / 5) + 32);
  double toCelsius() => ((this - 32) * 5 / 9);
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) => _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}
