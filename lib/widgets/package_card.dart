import 'package:flutter/material.dart';
import '../models/package_model.dart';

class PackageCard extends StatelessWidget {
  final Package package;
  final VoidCallback onSelect;

  const PackageCard({super.key, required this.package, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageHeader(),
          _buildCardContent(context),
        ],
      ),
    );
  }

  Widget _buildImageHeader() {
    return Stack(
      children: [
        Image.network(
          package.imageUrl,
          height: 160,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
          errorBuilder: (context, error, st) =>
              const SizedBox(height: 160, child: Center(child: Icon(Icons.broken_image, color: Colors.grey))),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Chip(
            backgroundColor: Colors.blue,
            label: Text('${package.duration} Days',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(package.destination.toUpperCase(),
            style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(package.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('From', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('\$${package.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ]),
          ElevatedButton(
            onPressed: onSelect,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Select', style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ])
      ]),
    );
  }
}
