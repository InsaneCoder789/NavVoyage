import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../blocs/booking_bloc.dart';
import '../blocs/booking_event.dart';
import 'review_confirm_screen.dart';

class TravelerDetailsScreen extends StatefulWidget {
  const TravelerDetailsScreen({super.key});

  @override
  State<TravelerDetailsScreen> createState() => _TravelerDetailsScreenState();
}

class _TravelerDetailsScreenState extends State<TravelerDetailsScreen> {
  final List<Map<String, TextEditingController>> controllers = [
    {'name': TextEditingController(), 'age': TextEditingController()}
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to update the button
    for (var c in controllers) {
      c['name']!.addListener(_onFieldChanged);
      c['age']!.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    setState(() {}); // Trigger rebuild when user types
  }

  @override
  void dispose() {
    for (var ctrls in controllers) {
      ctrls['name']!.dispose();
      ctrls['age']!.dispose();
    }
    super.dispose();
  }

  void _addTraveler() {
    final newCtrl = {
      'name': TextEditingController(),
      'age': TextEditingController(),
    };
    newCtrl['name']!.addListener(_onFieldChanged);
    newCtrl['age']!.addListener(_onFieldChanged);

    setState(() {
      controllers.add(newCtrl);
    });
  }

  void _removeTraveler(int index) {
    setState(() {
      controllers[index]['name']!.dispose();
      controllers[index]['age']!.dispose();
      controllers.removeAt(index);
    });
  }

  bool get hasValidTraveler {
    for (var c in controllers) {
      if (c['name']!.text.trim().isEmpty) return false;
      if (int.tryParse(c['age']!.text) == null ||
          int.parse(c['age']!.text) <= 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookingBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Traveler Details')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ...controllers.asMap().entries.map((entry) {
            final index = entry.key;
            final c = entry.value;

            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Traveler ${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 16),
                      const Text('Full Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.subtextColor)),
                      const SizedBox(height: 8),
                      TextFormField(controller: c['name']),
                      const SizedBox(height: 16),
                      const Text('Age',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.subtextColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: c['age'],
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                if (index > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _removeTraveler(index),
                    ),
                  )
              ],
            );
          }).toList(),
          OutlinedButton.icon(
            onPressed: _addTraveler,
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Add Another Traveler'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryColor,
              side: const BorderSide(color: AppTheme.accentColor, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: hasValidTraveler
              ? () {
                  final travelers = controllers
                      .map((c) => {
                            'name': c['name']!.text.trim(),
                            'age': int.tryParse(c['age']!.text) ?? 0
                          })
                      .toList();
                  bloc.add(AddTravelers(travelers));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReviewConfirmScreen()));
                }
              : null,
          child: const Text('Next'),
        ),
      ),
    );
  }
}
