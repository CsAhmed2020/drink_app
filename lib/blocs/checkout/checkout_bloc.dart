import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/cart/Cart_state.dart';
import 'package:new_app/blocs/payment/payment_state.dart';

import '../../repositories/checkout/checkout_repository.dart';
import '../cart/cart_bloc.dart';
import '../payment/payment_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,

}) : _cartBloc = cartBloc,_checkoutRepository = checkoutRepository, _paymentBloc = paymentBloc,
  super(cartBloc.state is CartLoaded
          ? CheckoutLoaded(
          products: (cartBloc.state as CartLoaded).cart.products,
  deliveryFee: (cartBloc.state as CartLoaded).cart.deliveryFeeString,
  subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
  total: (cartBloc.state as CartLoaded).cart.totalString
      ) : CheckoutLoading()){
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);
    _cartSubscription = cartBloc.stream.listen((state) {
      if(state is CartLoaded){
        add(UpdateCheckout(cart: state.cart));
      }
    });

    _paymentSubscription = _paymentBloc.stream.listen((state) {
      if(state is PaymentLoaded) {
        add(
          UpdateCheckout(paymentMethod: state.paymentMethod)
        );
      }
    });
  }



  void _onUpdateCheckout(
      UpdateCheckout event,
      Emitter<CheckoutState> emit
      ){
    final state = this.state;
    if(state is CheckoutLoaded){
      emit(CheckoutLoaded(
        email: event.email ?? state.email,
        fullName: event.fullName ?? state.fullName,
        products: event.cart?.products ?? state.products,
        deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
        subtotal: event.cart?.subtotalString ?? state.subtotal,
        total: event.cart?.totalString ?? state.total,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipCode: event.zipCode ?? state.zipCode,
        paymentMethod: event.paymentMethod ?? state.paymentMethod
      ));
    }
  }


  void _onConfirmCheckout(
      ConfirmCheckout event,
      Emitter<CheckoutState> emit
      ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded){
      try{
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        emit(CheckoutLoading());
      }catch (_){}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}