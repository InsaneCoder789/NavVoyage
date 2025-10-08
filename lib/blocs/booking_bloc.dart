import 'package:flutter_bloc/flutter_bloc.dart';
import '../repos/booking_repo.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import '../models/package_model.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  // Exposed current selections to be read from UI (convenience)
  Package? selectedPackage;
  Map<String, dynamic>? itinerary;
  List<Map<String, dynamic>> travelers = [];

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<SelectPackage>((event, emit) {
      selectedPackage = event.package;
      emit(PackageSelected(event.package));
    });

    on<CustomizeItinerary>((event, emit) {
      itinerary = event.itinerary;
      emit(ItineraryCustomized(event.itinerary));
    });

    on<AddTravelers>((event, emit) {
      travelers = event.travelers;
      emit(TravelersAdded(event.travelers));
    });

    on<ConfirmBooking>((event, emit) async {
      emit(BookingLoading());
      try {
        if (selectedPackage == null) {
          emit(BookingFailure('Please select a package.'));
          return;
        }
        if (itinerary == null) {
          emit(BookingFailure('Please customize itinerary.'));
          return;
        }
        if (travelers.isEmpty) {
          emit(BookingFailure('Please add at least one traveler.'));
          return;
        }

        await bookingRepository.bookPackage(
          package: selectedPackage!,
          itinerary: itinerary!,
          travelers: travelers,
        );

        emit(BookingSuccess());
      } catch (e) {
        emit(BookingFailure(e.toString()));
      }
    });
  }
}
