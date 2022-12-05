import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/payment/payment_event.dart';
import 'package:new_app/blocs/payment/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethod>(_onLoadPaymentMethod);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
  }

  void _onLoadPaymentMethod(
      LoadPaymentMethod event,
      Emitter<PaymentState> emit,
      ) {
    emit(
      PaymentLoaded(),
    );
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event,
      Emitter<PaymentState> emit,
      ) {
    emit(
      PaymentLoaded(paymentMethod: event.paymentMethod),
    );
  }
}