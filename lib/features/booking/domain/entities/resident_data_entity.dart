import 'package:equatable/equatable.dart';

class ResidentDataEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String nationality;
  final String idNumber;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;

  const ResidentDataEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.nationality,
    required this.idNumber,
    this.checkInDate,
    this.checkOutDate,
  });

  String get fullName => '$firstName $lastName';

  ResidentDataEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? nationality,
    String? idNumber,
    DateTime? checkInDate,
    DateTime? checkOutDate,
  }) {
    return ResidentDataEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationality: nationality ?? this.nationality,
      idNumber: idNumber ?? this.idNumber,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        nationality,
        idNumber,
        checkInDate,
        checkOutDate,
      ];
}