import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/booking_bloc.dart';
import '../blocs/booking_event.dart';
import '../theme/app_theme.dart';
import 'traveler_details_screen.dart';

class CustomizeItineraryScreen extends StatefulWidget {
  const CustomizeItineraryScreen({super.key});

  @override
  State<CustomizeItineraryScreen> createState() =>
      _CustomizeItineraryScreenState();
}

class _CustomizeItineraryScreenState extends State<CustomizeItineraryScreen> {
  final List<String> activities = [
    'Hiking',
    'Snorkeling',
    'City Tour',
    'Spa',
    'Food Tasting',
    'Museum Visit'
  ];
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

  bool get canProceed =>
      selectedActivities.isNotEmpty &&
      startDate != null &&
      endDate != null &&
      !endDate!.isBefore(startDate!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Itinerary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose activities & dates',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.subtextColor),
            ),
            const SizedBox(height: 20),
            // Activities List
            Expanded(
              child: ListView.separated(
                itemCount: activities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  final isSelected = selectedActivities.contains(activity);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedActivities.remove(activity);
                        } else {
                          selectedActivities.add(activity);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.accentColor : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.grey.shade200),
                        boxShadow: [
                          if (!isSelected)
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppTheme.primaryDarkColor
                                  : AppTheme.textColor,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelected ? Icons.check : Icons.add,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.subtextColor,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Date Pickers
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DateDisplay(
                      label: 'Start Date',
                      date: startDate == null
                          ? 'Not set'
                          : '${startDate!.month}/${startDate!.day}/${startDate!.year}',
                      onTap: () => _pickDate(isStart: true)),
                  DateDisplay(
                      label: 'End Date',
                      date: endDate == null
                          ? 'Not set'
                          : '${endDate!.month}/${endDate!.day}/${endDate!.year}',
                      onTap: () => _pickDate(isStart: false)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: canProceed
              ? () {
                  final itinerary = {
                    'activities': selectedActivities,
                    'startDate': startDate,
                    'endDate': endDate,
                  };
                  context
                      .read<BookingBloc>()
                      .add(CustomizeItinerary(itinerary));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TravelerDetailsScreen()));
                }
              : null,
          child: const Text('Next'),
        ),
      ),
    );
  }
}

class DateDisplay extends StatelessWidget {
  final String label, date;
  final VoidCallback onTap;

  const DateDisplay(
      {super.key, required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(color: AppTheme.subtextColor, fontSize: 12)),
          const SizedBox(height: 4),
          Text(date,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
