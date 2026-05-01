class PropertyImageModel {
  final int id;
  final String url;
  final int sortOrder;

  const PropertyImageModel({
    required this.id,
    required this.url,
    required this.sortOrder,
  });

  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(
      id: json['id'] as int,
      url: json['url'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }
}

class PropertyCategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int sortOrder;

  const PropertyCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.sortOrder = 0,
  });

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }
}

class AgentUserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;
  final String createdAt;

  const AgentUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.phone,
    required this.createdAt,
  });

  factory AgentUserModel.fromJson(Map<String, dynamic> json) {
    return AgentUserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String,
    );
  }
}

class PropertyAgentModel {
  final int id;
  final String title;
  final String bio;
  final String? licenseNumber;
  final String company;
  final AgentUserModel? user;

  const PropertyAgentModel({
    required this.id,
    required this.title,
    required this.bio,
    this.licenseNumber,
    required this.company,
    this.user,
  });

  factory PropertyAgentModel.fromJson(Map<String, dynamic> json) {
    return PropertyAgentModel(
      id: json['id'] as int,
      title: json['title'] as String,
      bio: json['bio'] as String,
      licenseNumber: json['license_number'] as String?,
      company: json['company'] as String,
      user: json['user'] != null
          ? AgentUserModel.fromJson(json['user'])
          : null,
    );
  }
}

class PropertyModel {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String address;
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
  final PropertyCategoryModel? category;
  final List<PropertyImageModel> images;
  final PropertyAgentModel? agent;

  const PropertyModel({
    required this.id,
    required this.title,
    this.slug = '',
    this.description = '',
    required this.address,
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
    required this.images,
    this.agent,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String,
      price: double.parse(json['price'].toString()),
      rating: json['rate'] != null
          ? double.tryParse(json['rate'].toString())
          : null,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      kitchens: json['kitchens'] as int?,
      listingType: json['listing_type'] as String? ?? 'sale',
      status: json['status'] as String? ?? 'published',
      isFeatured: json['is_featured'] as bool? ?? false,
      salesCount: json['sales_count'] as int?,
      latitude: json['latitude'] as double? ?? json['lat'] as double?,
      longitude: json['longitude'] as double? ?? json['lng'] as double?,
      distanceKm: json['distance_km'] as String? ?? json['distance'] as String?,
      category: json['category'] != null
          ? PropertyCategoryModel.fromJson(json['category'])
          : null,
      images: (json['images'] as List)
          .map((e) => PropertyImageModel.fromJson(e))
          .toList(),
      agent: json['agent'] != null
          ? PropertyAgentModel.fromJson(json['agent'])
          : null,
    );
  }
}