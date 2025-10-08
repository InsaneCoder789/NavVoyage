import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/activity_tile.dart';
import '../blocs/booking_event.dart';
import '../blocs/booking_bloc.dart';
import 'traveler_details_screen.dart';

class CustomizeItineraryScreen extends StatefulWidget {
  const CustomizeItineraryScreen({super.key});

  @override
  State<CustomizeItineraryScreen> createState() => _CustomizeItineraryScreenState();
}

class _CustomizeItineraryScreenState extends State<CustomizeItineraryScreen> {
  final List<String> activities = ['Hiking', 'Snorkeling', 'City Tour', 'Spa', 'Food Tasting', 'Museum Visit'];
  final List<String> selectedActivities = [];
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  bool get canProceed => selectedActivities.isNotEmpty && startDate != null && endDate != null && !endDate!.isBefore(startDate!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Itinerary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Text('Choose activities & dates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: activities
                  .map((a) => ActivityTile(
                        activity: a,
                        selected: selectedActivities.contains(a),
                        onTap: () {
                          setState(() {
                            if (selectedActivities.contains(a)) {
                              selectedActivities.remove(a);
                            } else {
                              selectedActivities.add(a);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Start Date', style: TextStyle(color: Colors.grey)),
                  Text(startDate == null ? 'Not set' : startDate!.toLocal().toString().split(' ')[0]),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('End Date', style: TextStyle(color: Colors.grey)),
                  Text(endDate == null ? 'Not set' : endDate!.toLocal().toString().split(' ')[0]),
                ]),
                IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () async {
                    await _pickDate(isStart: true);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    await _pickDate(isStart: false);
                  },
                ),
              ]),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: canProceed
                    ? () {
                        final itinerary = {
                          'activities': selectedActivities,
                          'startDate': startDate,
                          'endDate': endDate,
                        };
                        context.read<BookingBloc>().add(CustomizeItinerary(itinerary));
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const TravelerDetailsScreen()));
                      }
                    : null,
                child: const Text('Next'),
              ),
            ),
          ])
        ]),
      ),
    );
  }
}
