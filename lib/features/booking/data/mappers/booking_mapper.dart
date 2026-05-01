import '../../domain/entities/order_entity.dart';
import '../../domain/entities/property_entity.dart';
import '../models/order_model.dart';
import '../models/property_model.dart';

class BookingMapper {
  static PropertyEntity toPropertyEntity(PropertyModel model) => PropertyEntity(
    id: model.id,
    title: model.title,
    slug: model.slug,
    description: model.description,
    address: model.address,
    imageUrls: model.images.map((e) => e.url).toList(),
    price: model.price,
    rating: model.rating,
    bedrooms: model.bedrooms,
    bathrooms: model.bathrooms,
    kitchens: model.kitchens,
    listingType: model.listingType,
    status: model.status,
    isFeatured: model.isFeatured,
    salesCount: model.salesCount,
    latitude: model.latitude,
    longitude: model.longitude,
    distanceKm: model.distanceKm,
    category: model.category != null
        ? PropertyCategory(
            id: model.category!.id,
            name: model.category!.name,
            slug: model.category!.slug,
            description: model.category!.description,
            sortOrder: model.category!.sortOrder,
          )
        : null,
    agent: model.agent != null
        ? PropertyAgent(
            id: model.agent!.id,
            title: model.agent!.title,
            bio: model.agent!.bio,
            licenseNumber: model.agent!.licenseNumber,
            company: model.agent!.company,
            user: model.agent!.user != null
                ? AgentUser(
                    id: model.agent!.user!.id,
                    name: model.agent!.user!.name,
                    email: model.agent!.user!.email,
                    role: model.agent!.user!.role,
                    location: model.agent!.user!.location,
                    phone: model.agent!.user!.phone,
                    createdAt: model.agent!.user!.createdAt,
                  )
                : null,
          )
        : null,
  );

  static OrderEntity toOrderEntity(OrderModel model) => OrderEntity(
    id: model.id,
    amount: model.amount,
    currency: model.currency,
    status: model.status,
    stripeSessionId: model.stripeSessionId,
    createdAt: model.createdAt,
    paymentUrl: model.paymentUrl,
    propertyId: model.propertyId,
  );
}
