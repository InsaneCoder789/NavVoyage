import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repos/booking_repo.dart';
import 'blocs/booking_bloc.dart';
import 'theme/theme_cubit.dart';
import 'screens/select_package_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => BookingRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookingBloc(
                bookingRepository: context.read<BookingRepository>()),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'VoyageCraft',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme, 
              themeMode: themeMode,
              home: const SelectPackageScreen(),
            );
          },
        ),
      ),
    );
  }
}
