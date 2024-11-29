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

class Offer {
  Offer({
    required this.oilType,
    required this.oilQuantity,
    required this.oilPrice,
    required this.arrivalDate,
    required this.orderStatus,
    required this.orderID,
    required this.location,
    required this.customerInfo,
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

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'Latitude: $latitude - Longitude: $longitude)';
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'].toDouble(),
      longitude: map['longitude'].toDouble(),
    );
  }
}

class CustomerInfo {
  final String name;
  final String companyName;
  final String phoneNumber;
  final String image;
  final String providerEmail;
  final String seekerEmail;

  CustomerInfo({
    required this.name,
    required this.companyName,
    required this.phoneNumber,
    required this.image,
    required this.providerEmail,
    required this.seekerEmail,
  });
}

class ProfileInfo {
  final String name;
  final String companyName;
  final String phoneNumber;
  final String image;
  final String email;

  ProfileInfo({
    required this.name,
    required this.companyName,
    required this.phoneNumber,
    required this.image,
    required this.email,
  });
}
