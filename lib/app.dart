import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/booking_bloc.dart';
import 'repos/booking_repo.dart';
import 'screens/select_package_screen.dart';

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism Booking App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RepositoryProvider(
        create: (context) => BookingRepository(),
        child: BlocProvider(
          create: (context) =>
              BookingBloc(bookingRepository: context.read<BookingRepository>()),
          child: const SelectPackageScreen(),
        ),
      ),
    );
  }
}
