import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_cashe_storge_bloc/core/model/handling.dart';
import 'package:hive_cashe_storge_bloc/core/model/product_model.dart';
import 'package:hive_cashe_storge_bloc/feature/product/bloc/product_event.dart';
import 'package:hive_cashe_storge_bloc/feature/product/bloc/product_state.dart';
import 'package:hive_cashe_storge_bloc/service/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetAllProductEvent>((event, emit) async {
      emit(LoadingGetProduct());
      ResultModel result = await ProductServiceImp().getAllProduct();
      if (result is ListOf<ProductModel>) {
        emit(SuccessGetProduct(productModels: result));
      } else if (result is ErrorModel) {
        emit(ErrorProducts());
      }
    });
  }
}
