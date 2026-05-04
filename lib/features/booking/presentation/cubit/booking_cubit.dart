import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_property_details_usecase.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetPropertyDetailsUseCase _getProperty;
  final CreateOrderUseCase _createOrder;

  static const int _propertyId = 1;

  BookingCubit({
    required GetPropertyDetailsUseCase getPropertyDetailsUseCase,
    required CreateOrderUseCase createOrderUseCase,
  }) : _getProperty = getPropertyDetailsUseCase,
       _createOrder = createOrderUseCase,
       super(BookingState.initial());

  Future<void> loadProperty() async {
    emit(state.loadingState());

    final result = await _getProperty(_propertyId);

    result.fold(
      (f) => emit(state.errorState(f.message)),
      (property) => emit(state.propertyLoaded(property)),
    );
  }

  Future<void> createOrder() async {
    emit(state.loadingState());

    final result = await _createOrder(_propertyId);

    result.fold(
      (f) => emit(state.errorState(f.message)),
      (order) => emit(state.orderCreated(order)),
    );
  }
}
