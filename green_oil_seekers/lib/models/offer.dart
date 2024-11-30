// Enums to define constants for Oil Type and Order Status.
enum OilType {
  motorOil,
  cookingOil,
  lubricating,
}

enum OrderStatus {
  pending,
  accepted,
  pickupScheduled,
  completed,
  cancelled,
}

// A class to represent an offer in the system.
class Offer {
  // Constructor to initialize an Offer object with all necessary fields.
  Offer({
    required this.oilType, // Type of oil for the offer.
    required this.oilQuantity, // Quantity of oil in the offer.
    required this.oilPrice, // Price per unit of oil.
    required this.arrivalDate, // Expected date of arrival for the oil.
    required this.orderStatus, // Current status of the order.
    required this.orderID, // Unique identifier for the order.
    required this.location, // Location associated with the offer.
    required this.customerInfo, // Customer information for contact and details.
  });

  final String orderID;
  final OilType oilType;
  final double oilQuantity;
  final double oilPrice;
  final DateTime arrivalDate;
  final OrderStatus orderStatus;
  final Location location;
  final CustomerInfo customerInfo;
}

// A class to encapsulate the geographical location.
class Location {
  final double latitude;
  final double longitude;

  // Constructor to create a Location instance.
  Location({
    required this.latitude, // Latitude part of the location.
    required this.longitude, // Longitude part of the location.
  });

  @override
  String toString() {
    // Custom string representation of the location.
    return 'Latitude: $latitude - Longitude: $longitude';
  }

  // Factory constructor to create a Location from a map.
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'].toDouble(), // Parses latitude from the map.
      longitude: map['longitude'].toDouble(), // Parses longitude from the map.
    );
  }
}

// A class to hold customer-related information.
class CustomerInfo {
  final String name;
  final String companyName;
  final String phoneNumber;
  final String image;
  final String providerEmail;
  final String seekerEmail;

  // Constructor to initialize all properties of CustomerInfo.
  CustomerInfo({
    required this.name, // Name of the customer.
    required this.companyName, // Name of the company.
    required this.phoneNumber, // Contact phone number.
    required this.image, // Image URL or path for the customer's image.
    required this.providerEmail, // Email address of the provider.
    required this.seekerEmail, // Email address of the seeker.
  });
}
