import 'dart:async';
import '../models/package_model.dart';

class BookingRepository {
  final List<Package> mockPackages = [
    Package(
      id: 1,
      name: 'Parisian Dreams',
      destination: 'Paris, France',
      duration: 7,
      price: 1800,
      imageUrl: 'https://placehold.co/600x400/3498db/ffffff?text=Eiffel+Tower',
    ),
    Package(
      id: 2,
      name: 'Roman Holiday',
      destination: 'Rome, Italy',
      duration: 5,
      price: 1550,
      imageUrl: 'https://placehold.co/600x400/e74c3c/ffffff?text=Colosseum',
    ),
    Package(
      id: 3,
      name: 'Tokyo Express',
      destination: 'Tokyo, Japan',
      duration: 10,
      price: 2500,
      imageUrl: 'https://placehold.co/600x400/2ecc71/ffffff?text=Tokyo+Skyline',
    ),
    Package(
      id: 4,
      name: 'Santorini Sunset',
      destination: 'Santorini, Greece',
      duration: 6,
      price: 2100,
      imageUrl: 'https://placehold.co/600x400/9b59b6/ffffff?text=Santorini',
    ),
    Package(
      id: 5,
      name: 'Jungle Adventure',
      destination: 'Costa Rica',
      duration: 8,
      price: 1950,
      imageUrl: 'https://placehold.co/600x400/1abc9c/ffffff?text=Rainforest',
    ),
    Package(
      id: 6,
      name: 'Alpine Escape',
      destination: 'Swiss Alps',
      duration: 7,
      price: 2800,
      imageUrl: 'https://placehold.co/600x400/f1c40f/ffffff?text=Swiss+Alps',
    ),
  ];

  Future<List<Package>> getPackages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return mockPackages;
  }

  Future<void> bookPackage({
    required Package package,
    required Map<String, dynamic> itinerary,
    required List<Map<String, dynamic>> travelers,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (travelers.isEmpty) throw Exception('No travelers provided');
    if (itinerary['startDate'] == null || itinerary['endDate'] == null) {
      throw Exception('Invalid itinerary dates');
    }
    return;
  }
}
