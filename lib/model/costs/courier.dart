import 'package:equatable/equatable.dart';
import 'package:flutter_mvvm/model/costs/costs.dart';

class Courier extends Equatable {
  final String? code;
  final String? name;
  final List<Costs>? costs;

  const Courier({this.code, this.name, this.costs});

  // Factory constructor to create a Courier object from JSON
  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        code: json['code'] as String?,
        name: json['name'] as String?,
        costs: (json['costs'] as List<dynamic>?)
            ?.map((e) => Costs.fromJson(e as Map<String, dynamic>))
            .toList(), // Ensure Cost.fromJson is called for each element
      );

  // Method to convert the Courier object back to JSON
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toJson()).toList(), // Map Cost to JSON
      };

  @override
  List<Object?> get props => [code, name, costs];
}
