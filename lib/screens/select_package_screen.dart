import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/booking_bloc.dart';
import '../blocs/booking_event.dart';
import '../models/package_model.dart';
import '../theme/app_theme.dart';
import 'customize_itinerary_screen.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({super.key});

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  bool _isLoading = true;
  final List<Package> _packages = [];

  // Updated images from Unsplash for reliable loading
  final List<Package> _mockPackages = [
    Package(
        id: 1,
        name: 'Parisian Dreams',
        destination: 'Paris, France',
        duration: 7,
        price: 1800,
        imageUrl:
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=600&q=80'),
    Package(
        id: 2,
        name: 'Roman Holiday',
        destination: 'Rome, Italy',
        duration: 5,
        price: 1550,
        imageUrl:
            'https://images.unsplash.com/photo-1526481280692-3f23a91c5e03?auto=format&fit=crop&w=600&q=80'),
    Package(
        id: 3,
        name: 'Tokyo Express',
        destination: 'Tokyo, Japan',
        duration: 10,
        price: 2500,
        imageUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=600&q=80'),
    Package(
        id: 4,
        name: 'Santorini Sunset',
        destination: 'Santorini, Greece',
        duration: 6,
        price: 2100,
        imageUrl:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=600&q=80'),
    Package(
        id: 5,
        name: 'Jungle Adventure',
        destination: 'Costa Rica',
        duration: 8,
        price: 1950,
        imageUrl:
            'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=600&q=80'),
    Package(
        id: 6,
        name: 'Alpine Escape',
        destination: 'Swiss Alps',
        duration: 7,
        price: 2800,
        imageUrl:
            'https://images.unsplash.com/photo-1501769214405-5e8e6dabe49b?auto=format&fit=crop&w=600&q=80'),
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

  void _navigateToCustomize(Package pkg) {
    context.read<BookingBloc>().add(SelectPackage(pkg));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CustomizeItineraryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore Trips',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=100&q=80'),
                          radius: 24,
                        ),
                      ],
                    ),
                  ),
                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Find the perfect adventure tailored just for you.',
                      style:
                          TextStyle(color: AppTheme.subtextColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Package List
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _packages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final pkg = _packages[index];
                        return PackageCard(
                          package: pkg,
                          onTap: () => _navigateToCustomize(pkg),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final Package package;
  final VoidCallback onTap;

  const PackageCard({super.key, required this.package, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          Stack(
            children: [
              // Network Image with loading/error fallback
              Image.network(
                package.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child:
                      const Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Chip(
                  label: Text('${package.duration} Days'),
                  backgroundColor: Colors.white.withOpacity(0.8),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryDarkColor),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(package.destination,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14)),
                    Text(package.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('From',
                        style: TextStyle(color: AppTheme.subtextColor)),
                    Text('\$${package.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                TextButton(
                  onPressed: onTap, // Fixed Details navigation
                  style: TextButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
                      foregroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10)),
                  child: const Text('Details',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
