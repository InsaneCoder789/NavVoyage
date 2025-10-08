import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/theme_cubit.dart';
import 'screens/select_package_screen.dart'; // Start screen
import 'repos/booking_repo.dart';
import 'blocs/booking_bloc.dart';
import 'theme/app_theme.dart'; // Import the new AppTheme

void main() {
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => BookingBloc(bookingRepository: BookingRepository()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme, // Use the new AppTheme light theme
            darkTheme: AppTheme.darkTheme, // Use the new AppTheme dark theme
            home: const SelectPackageScreen(),
          );
        },
      ),
    );
  }
}
