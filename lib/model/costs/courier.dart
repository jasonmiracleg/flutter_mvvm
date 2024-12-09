import 'package:equatable/equatable.dart';

import 'cost.dart';

class Courier extends Equatable {
  final String? code;
  final String? name;
  final List<Cost>? costs;

  const Courier({this.code, this.name, this.costs});

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        code: json['code'] as String?,
        name: json['name'] as String?,
        costs: (json['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [code, name, costs];
}
