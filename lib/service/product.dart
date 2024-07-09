import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_cashe_storge_bloc/core/config/hive_config.dart';
import 'package:hive_cashe_storge_bloc/core/model/handling.dart';
import 'package:hive_cashe_storge_bloc/core/model/product_model.dart';
import 'package:hive_cashe_storge_bloc/service/core.dart';

abstract class ProductService extends CoreService {
  String basUrl = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/Animal";
  Future<ResultModel> getAllProduct();
}

List<ProductModel> productModel = [];
List getFromBox = [];
List putInBox = [];

Connectivity connectivity = Connectivity();
ConnectivityResult? connectivityResult;

class ProductServiceImp extends ProductService {
  late List<ConnectivityResult> result;
  @override
  Future<ResultModel> getAllProduct() async {
    print("ola");

    result = await connectivity.checkConnectivity();
    print("lololo");

    print(result);
    try {
      print(response.statusCode);
      response = await dio.get(basUrl);
      print(response.statusCode);
      if (connectivityResult != ConnectivityResult.none ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          productModel = List.generate(productModel.length,
              (index) => ProductModel.fromMap(response.data[index]));
          print(productModel);
          putInBox.addAll(productModel);
          mybox!.delete("products");
          mybox!.put("products", putInBox);
          print(mybox!.get("products"));
          return ListOf(data: productModel);
        } else {
          return ErrorModel();
        }
      } else {
        print("from storage");
        getFromBox = mybox!.get("products");
        if (getFromBox != []) {
          return ListOf(data: getFromBox);
        } else {
          return ExceptionModel(message: "there is not storage");
        }
      }
    } on DioException catch (e) {
      print(e.message);
      return ExceptionModel(message: e.message);
    }
  }
}
