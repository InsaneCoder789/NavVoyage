import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
                (route) => route.isFirst,
              );
            } else if (state is BookingFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final pkg = bloc.selectedPackage;
            final itinerary = bloc.itinerary ?? {};
            final travelers = bloc.travelers;

            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(pkg?.name ?? '—', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(pkg?.destination ?? '', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text('Price', style: TextStyle(color: Colors.grey)),
                        Text('\$${pkg?.price ?? '-'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ]),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        const Text('Duration', style: TextStyle(color: Colors.grey)),
                        Text('${pkg?.duration ?? 0} days', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                    ])
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Itinerary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Activities: ${(itinerary['activities'] ?? []).join(', ')}'),
                    const SizedBox(height: 6),
                    Text('Dates: ${_formatDate(itinerary['startDate'])} - ${_formatDate(itinerary['endDate'])}'),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Travelers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...travelers.map((t) => Text('${t['name']} • ${t['age']} yrs')).toList(),
                  ]),
                ),
              ),
              const Spacer(),
              state is BookingLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Back'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<BookingBloc>().add(ConfirmBooking());
                          },
                          child: const Text('Confirm Booking'),
                        ),
                      ),
                    ])
            ]);
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
