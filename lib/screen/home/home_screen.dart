import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constant/app_colors.dart';
import 'package:product_app/constant/app_strings.dart';
import 'package:product_app/screen/add_product/add_product_screen.dart';
import 'package:product_app/screen/delete_product/bloc/delete_product_bloc.dart';
import 'package:product_app/screen/delete_product/bloc/delete_product_event.dart';
import 'package:product_app/screen/home/bloc/home_screen_bloc.dart';
import 'package:product_app/screen/home/bloc/home_screen_event.dart';
import 'package:product_app/screen/home/bloc/home_screen_state.dart';
import 'package:product_app/model/home_screen_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenBloc _productBloc = HomeScreenBloc();
  final controller = ScrollController();
  List<Datum>? listItem = [];

  @override
  void initState() {
    _productBloc.add(GetProductList());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyAccent,
      appBar: AppBar(title: Text(AppStrings.productList), centerTitle: true),
      body: _buildListProduct(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(
                    name: '',
                    mrp: '',
                    selling: '',
                    description: '',
                    image: '',
                    title: 'Add Product',
                  ),
                ));
          },
          child: Icon(Icons.add)),
    );
  }

  Widget _buildListProduct() {
    return BlocProvider(
      create: (_) => _productBloc,
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is HomeScreenLoading) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is HomeScreenLoaded && state.listItem!.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('No More Products')));
          } else if (state is HomeScreenError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
            context.read<HomeScreenBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, state) {
          if (state is HomeScreenInitial ||
              state is HomeScreenLoading && listItem!.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeScreenLoaded) {
            listItem?.addAll(state.listItem!.toList());
            context.read<HomeScreenBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (state is HomeScreenError && listItem!.isEmpty) {
            return Text(state.message!, textAlign: TextAlign.center);
          }
          return Center(
            child: SizedBox(
              width: 400,
              child: ListView.builder(
                itemCount: listItem?.length ?? 0,
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: controller
                  ..addListener(() {
                    if (controller.offset ==
                            controller.position.maxScrollExtent &&
                        !context.read<HomeScreenBloc>().isFetching) {
                      context.read<HomeScreenBloc>()
                        ..isFetching = true
                        ..add(GetProductList());
                    }
                  }),
                itemBuilder: (context, index) {
                  Datum item = listItem![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddProductPage(
                            name: item.name,
                            mrp: item.mrp,
                            selling: item.selling,
                            description: item.description,
                            image: item.image,
                            title: 'Update Product',
                            id: item.id,
                          );
                        },
                      )),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Image.network(
                                  "${item.img ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}",
                                  fit: BoxFit.contain,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                    child: Text("Name: ${item.name}"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text("Price: ${item.mrp}")),
                                        Expanded(
                                          child: Text(
                                            "Selling: ${item.selling}",
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                            "Description: ${item.description}"),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<DeleteProductBloc>(
                                                    context)
                                                .add(
                                              DeleteProductDataEvent(item.id),
                                            );
                                            setState(() {
                                              listItem = List.from(listItem!)
                                                ..removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
