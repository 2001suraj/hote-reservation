import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final chekcBoxValueProvider = StateProvider<bool>((ref) {
  return  false;
});


final currentPageIndexProvider = StateProvider<int>((ref) {
  return 0 ;
});

final searchTextProvider = StateProvider.autoDispose<String>((ref) {
  return '' ;
});
final showMoreProvider = StateProvider<bool>((ref) {
  return false;
});

final personNumberProvider = StateProvider<int>((ref) {
  return  1;
});

final checkInformattedDateProvider = StateProvider<String>((ref) {
  return DateFormat('MMM dd yyyy').format(DateTime.now());
});
final checkOutformattedDateProvider = StateProvider<String>((ref) {
  return DateFormat('MMM dd yyyy').format(DateTime.now());
});
final checkInDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final checkOutDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
