import 'package:equatable/equatable.dart';

class Units extends Equatable {
  final int id;
  final String unit;
  Units({this.id = -1, required this.unit});
  Units copyWith({int? id, String? unit}) {
    return Units(
      id: id ?? this.id,
      unit: unit ?? this.unit,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, unit];
}
