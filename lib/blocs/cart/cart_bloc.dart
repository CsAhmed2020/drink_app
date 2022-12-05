
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/cart/Cart_state.dart';
import 'package:new_app/blocs/cart/cart_event.dart';
import 'package:new_app/model/cart_model.dart';

class CartBloc extends Bloc<CartEvent,CartState> {

  CartBloc() : super(CartLoading()){
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onLoadCart(event,Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
    emit(CartLoaded());
    } catch (_) {
    emit(CartError());
    }
  }
  void _onAddProduct(event,Emitter<CartState> emit)  {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
            cart: Cart(
            products: List.from(state.cart.products)
          ..add(event.product)
            )
        ));
    } catch (_) {
    emit(CartError());
    }
  }
  }
  void _onRemoveProduct(event,Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)
                  ..remove(event.product)
            )
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }
}