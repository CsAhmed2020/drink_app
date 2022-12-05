import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/model/wishlist_model.dart';


part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()){
    on<LoadWishlist>(_onLoadWishList);
    on<AddProductToWishlist>(_AddProductToWishlist);
    on<RemoveProductFromWishlist>(_RemoveProductFromWishlist);
  }

  void _onLoadWishList(event,Emitter<WishlistState> emit)async{
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded());
    } catch (_) {
      emit(WishlistError());
    }
  }
  void _AddProductToWishlist(event,Emitter<WishlistState> emit){
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishlist: Wishlist(
            products: List.from(state.wishlist.products)..add(event.product),
    ),
    ));
    } on Exception {
        emit(WishlistError());
      }
  }
  }
  void _RemoveProductFromWishlist(event,Emitter<WishlistState> emit){
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..remove(event.product),
          ),
        ));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }


}
