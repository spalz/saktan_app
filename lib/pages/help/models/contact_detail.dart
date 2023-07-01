import 'package:equatable/equatable.dart';

class ContactDetail extends Equatable {
  const ContactDetail({
    required this.id,
    required this.slug,
    required this.published,
    required this.titleRu,
    required this.titleKy,
    required this.addressRu,
    required this.addressKy,
    this.addressCoordinates,
    required this.descriptionRu,
    this.descriptionKy,
    required this.region,
    this.email,
    this.phones,
  });

  final int id;
  final String slug;
  final String published;
  final String titleRu;
  final String titleKy;
  final String addressRu;
  final String addressKy;
  final String? addressCoordinates;
  final String? descriptionRu;
  final String? descriptionKy;
  final String region;
  final String? email;
  final List<ContactPhone>? phones;

  @override
  List<Object?> get props => [
        id,
        slug,
        published,
        titleRu,
        titleKy,
        addressRu,
        addressKy,
        addressCoordinates,
        descriptionRu,
        descriptionKy,
        region,
        email,
        // phones,
      ];

  String getAddressCoordinatesOrDefault() {
    return addressCoordinates ?? '';
  }

  String getDescriptionRuOrDefault() {
    return descriptionRu ?? '';
  }

  String getDescriptionKyOrDefault() {
    return descriptionKy ?? '';
  }

  String getEmailOrDefault() {
    return email ?? '';
  }
}

class ContactPhone {
  const ContactPhone({
    required this.id,
    required this.phone,
    this.name,
  });

  final int id;
  final String phone;
  final String? name;
}
