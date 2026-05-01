import 'package:equatable/equatable.dart';

class AddonEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isSelected;

  const AddonEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isSelected = false,
  });

  AddonEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    bool? isSelected,
  }) {
    return AddonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, description, price, isSelected];
}

const List<AddonEntity> defaultAddons = [
  AddonEntity(
    id: 'cleaning',
    name: 'Cleaning Service',
    description: 'Professional cleaning before arrival',
    price: 50,
  ),
  AddonEntity(
    id: 'wifi',
    name: 'High-Speed WiFi',
    description: 'Premium internet package',
    price: 15,
  ),
  AddonEntity(
    id: 'parking',
    name: 'Private Parking',
    description: 'Secure parking space',
    price: 25,
  ),
  AddonEntity(
    id: 'airport',
    name: 'Airport Transfer',
    description: 'Pickup and drop-off service',
    price: 45,
  ),
];