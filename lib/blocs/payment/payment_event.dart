import 'package:equatable/equatable.dart';

import '../../model/payment_method_model.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethod extends PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  final PaymentMethod paymentMethod;

  const SelectPaymentMethod({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}