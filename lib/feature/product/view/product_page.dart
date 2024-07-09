import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_cashe_storge_bloc/core/model/product_model.g.dart';
import 'package:hive_cashe_storge_bloc/feature/product/bloc/product_bloc.dart';
import 'package:hive_cashe_storge_bloc/feature/product/bloc/product_event.dart';
import 'package:hive_cashe_storge_bloc/feature/product/bloc/product_state.dart';
import 'package:hive_cashe_storge_bloc/service/product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // var path = Directory.current.path;
    // Hive
    //   ..init(path)
    //   ..registerAdapter(ProductAdapter());
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetAllProductEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is SuccessGetProduct) {
                return ListView.builder(
                    itemCount: state.productModels.data.length,
                    itemBuilder: (context, index) {
                      if ((index) == state.productModels.data.length) {
                        // if (connectivityResult == ConnectivityResult.none) {
                        return SizedBox(
                          height: 3,
                        );
                        // }
                      } else {
                        print(state.productModels.data[index].image);
                        ListTile(
                          leading: Image.network(
                              state.productModels.data[index].image),
                          title: Text(state.productModels.data[index].name),
                          subtitle: Text(state.productModels.data[index].brand),
                        );
                      }
                    });
              } else if (state is ErrorProducts) {
                return Text("There is no internet");
              } else {
                return Center(
                    child: CupertinoActivityIndicator(
                  color: Colors.black45,
                ));
              }
            },
          ),
        );
      }),
    );
  }
}
