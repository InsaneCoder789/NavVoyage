import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/booking_bloc.dart';
import '../blocs/booking_event.dart';
import '../models/package_model.dart';
import 'customize_itinerary_screen.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({super.key});

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  bool _isLoading = true;
  final List<Package> _packages = [];

  final List<Package> _mockPackages = [
    Package(id: 1, name: 'Parisian Dreams', destination: 'Paris, France', duration: 7, price: 1800, imageUrl: 'https://placehold.co/600x400/3498db/ffffff?text=Eiffel+Tower'),
    Package(id: 2, name: 'Roman Holiday', destination: 'Rome, Italy', duration: 5, price: 1550, imageUrl: 'https://placehold.co/600x400/e74c3c/ffffff?text=Colosseum'),
    Package(id: 3, name: 'Tokyo Express', destination: 'Tokyo, Japan', duration: 10, price: 2500, imageUrl: 'https://placehold.co/600x400/2ecc71/ffffff?text=Tokyo+Skyline'),
    Package(id: 4, name: 'Santorini Sunset', destination: 'Santorini, Greece', duration: 6, price: 2100, imageUrl: 'https://placehold.co/600x400/9b59b6/ffffff?text=Santorini'),
    Package(id: 5, name: 'Jungle Adventure', destination: 'Costa Rica', duration: 8, price: 1950, imageUrl: 'https://placehold.co/600x400/1abc9c/ffffff?text=Rainforest'),
    Package(id: 6, name: 'Alpine Escape', destination: 'Swiss Alps', duration: 7, price: 2800, imageUrl: 'https://placehold.co/600x400/f1c40f/ffffff?text=Swiss+Alps'),
  ];

  @override
  void initState() {
    super.initState();
    _fetchPackages();
  }

  Future<void> _fetchPackages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _packages.addAll(_mockPackages);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Package'),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : _buildPackageList(context),
    );
  }

  Widget _buildPackageList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Find the perfect adventure tailored just for you. Each journey is a masterpiece waiting to be discovered.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 24),
        ..._packages.map((pkg) => _PackageCard(package: pkg)).toList(),
      ],
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;
  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildImageHeader(),
        _buildCardContent(context),
      ]),
    );
  }

  Widget _buildImageHeader() {
    return Stack(children: [
      Image.network(
        package.imageUrl,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
        errorBuilder: (context, error, st) => const SizedBox(height: 160, child: Center(child: Icon(Icons.broken_image))),
      ),
      Positioned(
        top: 8,
        right: 8,
        child: Chip(
          backgroundColor: Colors.blue,
          label: Text('${package.duration} Days', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        ),
      )
    ]);
  }

  Widget _buildCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(package.destination.toUpperCase(),
            style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(package.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('From', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('\$${package.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ]),
          ElevatedButton(
            onPressed: () {
              // Dispatch select package event and navigate
              context.read<BookingBloc>().add(SelectPackage(package));
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomizeItineraryScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Select', style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ])
      ]),
    );
  }
}
