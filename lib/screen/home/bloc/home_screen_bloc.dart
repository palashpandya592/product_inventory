import 'package:bloc/bloc.dart';
import 'package:product_app/screen/home/bloc/home_screen_event.dart';
import 'package:product_app/screen/home/bloc/home_screen_state.dart';
import 'package:product_app/repository/home_screen_api_repository.dart';
import 'package:product_app/model/home_screen_model.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  int? page;
  bool isFetching = false;
  List<Datum> listItem = [];

  HomeScreenBloc() : super(HomeScreenInitial()) {
    final HomeApiRepository _apiRepository = HomeApiRepository();

    on<GetProductList>((event, emit) async {
      try {
        emit(HomeScreenLoading(message: 'Loading Products'));
        HomeScreenModel? mList =
            await _apiRepository.fetchProductList(page: page);
        listItem.addAll(mList?.data?.data ?? []);
        emit(HomeScreenLoaded(listItem));
        if (mList!.error != null) {
          emit(HomeScreenError(mList.error));
        }
      } on HomeNetworkError {
        emit(HomeScreenError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
