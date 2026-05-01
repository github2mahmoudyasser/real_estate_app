// features/booking/presentation/bloc/booking_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/addon_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/insurance_type.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/resident_data_entity.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_property_details_usecase.dart';
import 'booking_state.dart';

const int _kStaticPropertyId = 1;

class BookingCubit extends Cubit<BookingState> {
  final GetPropertyDetailsUseCase _getPropertyDetailsUseCase;
  final CreateOrderUseCase _createOrderUseCase;

  OrderEntity? _currentOrder;

  BookingCubit({
    required GetPropertyDetailsUseCase getPropertyDetailsUseCase,
    required CreateOrderUseCase createOrderUseCase,
  })  : _getPropertyDetailsUseCase = getPropertyDetailsUseCase,
        _createOrderUseCase = createOrderUseCase,
        super(const BookingInitial());

  BookingEntity get _currentBooking {
    final state = this.state;
    if (state is BookingPropertyLoaded) return state.booking;
    if (state is BookingStepUpdated) return state.booking;
    if (state is BookingOrderCreated) return state.booking;
    if (state is BookingSuccess) return state.booking;
    return BookingEntity(
      propertyId: _kStaticPropertyId,
      addons: defaultAddons,
    );
  }

  Future<void> loadProperty() async {
    emit(const BookingLoading());

    final result = await _getPropertyDetailsUseCase(_kStaticPropertyId);

    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (property) => emit(
        BookingPropertyLoaded(
          property,
          BookingEntity(
            propertyId: _kStaticPropertyId,
            property: property,
            addons: defaultAddons,
          ),
        ),
      ),
    );
  }

  void updateResidentData(ResidentDataEntity data) {
    emit(BookingStepUpdated(_currentBooking.copyWith(residentData: data)));
  }

  void toggleAddon(String addonId) {
    final updatedAddons = _currentBooking.addons.map((addon) {
      if (addon.id == addonId) {
        return addon.copyWith(isSelected: !addon.isSelected);
      }
      return addon;
    }).toList();

    emit(BookingStepUpdated(_currentBooking.copyWith(addons: updatedAddons)));
  }

  void selectInsurance(InsuranceType type) {
    emit(BookingStepUpdated(_currentBooking.copyWith(insurance: type)));
  }

  void selectPaymentMethod(PaymentMethod method) {
    emit(BookingStepUpdated(_currentBooking.copyWith(paymentMethod: method)));
  }

  void updateCardData({
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) {
    emit(
      BookingStepUpdated(
        _currentBooking.copyWith(
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cvv: cvv,
        ),
      ),
    );
  }

  void toggleTerms(bool value) {
    emit(BookingStepUpdated(_currentBooking.copyWith(agreedToTerms: value)));
  }

  Future<void> createOrder() async {
    emit(const BookingLoading());

    final result = await _createOrderUseCase(_kStaticPropertyId);

    result.fold((failure) => emit(BookingError(failure.message)), (order) {
      _currentOrder = order;
      emit(BookingOrderCreated(order, _currentBooking));
    });
  }

  void markPaymentSuccess() {
    if (_currentOrder == null) return;
    emit(BookingSuccess(_currentOrder!, _currentBooking));
  }
}