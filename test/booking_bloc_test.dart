import 'package:flutter_test/flutter_test.dart';
import 'package:tourism_booking_app/repos/booking_repo.dart';
import 'package:tourism_booking_app/blocs/booking_bloc.dart';
import 'package:tourism_booking_app/blocs/booking_event.dart';
import 'package:tourism_booking_app/models/package_model.dart';

void main() {
  test('BookingBloc initial state is BookingInitial and can select package', () async {
    final repo = BookingRepository();
    final bloc = BookingBloc(bookingRepository: repo);

    // initial
    expect(bloc.state.runtimeType.toString(), 'BookingInitial');

    // select package
    final Package p = repo.mockPackages.first;
    bloc.add(SelectPackage(p));
    // wait a short while for event to be processed
    await Future.delayed(const Duration(milliseconds: 50));
    expect(bloc.selectedPackage, isNotNull);
    expect(bloc.selectedPackage!.id, p.id);

    await bloc.close();
  });
}
