import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/traveler_form.dart';
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
  void dispose() {
    for (var ctrls in controllers) {
      ctrls['name']!.dispose();
      ctrls['age']!.dispose();
    }
    super.dispose();
  }

  void _addTraveler() {
    setState(() {
      controllers.add({'name': TextEditingController(), 'age': TextEditingController()});
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
      if (int.tryParse(c['age']!.text) == null || int.parse(c['age']!.text) <= 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookingBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Traveler Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return Stack(children: [
                  TravelerForm(nameController: controllers[index]['name']!, ageController: controllers[index]['age']!),
                  if (index > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _removeTraveler(index),
                      ),
                    )
                ]);
              },
            ),
          ),
          Row(children: [
            OutlinedButton.icon(
              onPressed: _addTraveler,
              icon: const Icon(Icons.add),
              label: const Text('Add Traveler'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: hasValidTraveler
                  ? () {
                      final travelers = controllers
                          .map((c) => {'name': c['name']!.text.trim(), 'age': int.tryParse(c['age']!.text) ?? 0})
                          .toList();
                      bloc.add(AddTravelers(travelers));
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewConfirmScreen()));
                    }
                  : null,
              child: const Text('Next'),
            ),
          ])
        ]),
      ),
    );
  }
}
