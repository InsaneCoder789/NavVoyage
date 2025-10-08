import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../blocs/booking_bloc.dart';
import '../blocs/booking_state.dart';
import '../blocs/booking_event.dart';
import 'booking_success_screen.dart';

class ReviewConfirmScreen extends StatelessWidget {
  const ReviewConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookingBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Review & Confirm')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
                (route) => false,
              );
            } else if (state is BookingFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final pkg = bloc.selectedPackage;
            final itinerary = bloc.itinerary ?? {};
            final travelers = bloc.travelers;

            return ListView(
              children: [
                SummaryCard(
                  title: pkg?.name ?? '—',
                  children: [
                    Text(pkg?.destination ?? '', style: const TextStyle(color: AppTheme.subtextColor)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoColumn(
                          title: 'Price',
                          value: '\$${pkg?.price ?? '-'}',
                          isLarge: true,
                        ),
                        InfoColumn(
                          title: 'Duration',
                          value: '${pkg?.duration ?? 0} Days',
                        ),
                      ],
                    )
                  ],
                ),
                SummaryCard(
                  title: 'Itinerary',
                  children: [
                    ActivitiesDisplay(activities: (itinerary['activities'] ?? []).cast<String>()),
                    const SizedBox(height: 8),
                    InfoRow(
                      label: 'Dates:',
                      value:
                          '${_formatDate(itinerary['startDate'])} to ${_formatDate(itinerary['endDate'])}',
                    ),
                  ],
                ),
                SummaryCard(
                  title: 'Travelers',
                  children: travelers
                      .map<Widget>((t) =>
                          InfoRow(label: t['name'] ?? '-', value: '${t['age']} yrs'))
                      .toList(),
                ),
                const SizedBox(height: 16),
                state is BookingLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          context.read<BookingBloc>().add(ConfirmBooking());
                        },
                        child: const Text('Confirm Booking'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  static String _formatDate(dynamic d) {
    if (d == null) return '—';
    if (d is DateTime) return d.toLocal().toString().split(' ')[0];
    return d.toString();
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SummaryCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title, value;
  final bool isLarge;
  const InfoColumn({super.key, required this.title, required this.value, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: AppTheme.subtextColor, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: isLarge
              ? Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.primaryDarkColor)
              : const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label, value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label ', style: const TextStyle(color: AppTheme.subtextColor)),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

// NEW WIDGET for expandable activities
class ActivitiesDisplay extends StatefulWidget {
  final List<String> activities;
  const ActivitiesDisplay({super.key, required this.activities});

  @override
  State<ActivitiesDisplay> createState() => _ActivitiesDisplayState();
}

class _ActivitiesDisplayState extends State<ActivitiesDisplay> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final displayCount = _expanded ? widget.activities.length : 2;
    final remaining = widget.activities.length - displayCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: List.generate(displayCount, (index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(widget.activities[index],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            );
          }),
        ),
        if (!_expanded && remaining > 0)
          TextButton(
            onPressed: () => setState(() => _expanded = true),
            child: Text('+ $remaining more'),
          ),
        if (_expanded && widget.activities.length > 2)
          TextButton(
            onPressed: () => setState(() => _expanded = false),
            child: const Text('Show less'),
          ),
      ],
    );
  }
}
