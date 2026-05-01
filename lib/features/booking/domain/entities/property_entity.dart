import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String address;
  final List<String> imageUrls;
  final double price;
  final double? rating;
  final int? bedrooms;
  final int? bathrooms;
  final int? kitchens;
  final String listingType;
  final String status;
  final bool isFeatured;
  final int? salesCount;
  final double? latitude;
  final double? longitude;
  final String? distanceKm;
  final PropertyCategory? category;
  final PropertyAgent? agent;

  const PropertyEntity({
    required this.id,
    required this.title,
    this.slug = '',
    this.description = '',
    required this.address,
    required this.imageUrls,
    required this.price,
    this.rating,
    this.bedrooms,
    this.bathrooms,
    this.kitchens,
    this.listingType = 'sale',
    this.status = 'published',
    this.isFeatured = false,
    this.salesCount,
    this.latitude,
    this.longitude,
    this.distanceKm,
    this.category,
    this.agent,
  });

  String get firstImageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        description,
        address,
        imageUrls,
        price,
        rating,
        bedrooms,
        bathrooms,
        kitchens,
        listingType,
        status,
        isFeatured,
        salesCount,
        latitude,
        longitude,
        distanceKm,
        category,
        agent,
      ];
}

class PropertyCategory extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int sortOrder;

  const PropertyCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.sortOrder = 0,
  });

  @override
  List<Object?> get props => [id, name, slug, description, sortOrder];
}

class PropertyAgent extends Equatable {
  final int id;
  final String title;
  final String bio;
  final String? licenseNumber;
  final String company;
  final AgentUser? user;

  const PropertyAgent({
    required this.id,
    required this.title,
    required this.bio,
    this.licenseNumber,
    required this.company,
    this.user,
  });

  @override
  List<Object?> get props => [id, title, bio, licenseNumber, company, user];
}

class AgentUser extends Equatable {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;
  final String createdAt;

  const AgentUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.phone,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, role, location, phone, createdAt];
}