import 'package:equatable/equatable.dart';

export 'location_data.dart';

abstract class BaseModel extends Equatable {
  const BaseModel();

  Map<String, dynamic> toJson();

  BaseModel copyWith();

  @override
  List<Object?> get props;
}
