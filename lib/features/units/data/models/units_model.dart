import 'package:qrone/features/units/domain/entities/unit.dart';

class UnitModel extends Units {
  UnitModel({super.id, required super.unit});
  Map<String, dynamic> toJson() {
    return {
      'unit_title': unit,
    };
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      unit: json['unit_title'],
    );
  }
}
