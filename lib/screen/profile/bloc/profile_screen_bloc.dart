import 'package:bloc/bloc.dart';
import 'package:product_app/screen/profile/bloc/profile_screen_event.dart';
import 'package:product_app/screen/profile/bloc/profile_screen_state.dart';
import 'package:product_app/repository/profile_screen_api_repository.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ProfileScreenBloc() : super(ProfileScreenInitial()) {
    final ProfileApiRepository _profileApiRepository = ProfileApiRepository();

    on<GetUser>((event, emit) async {
      try {
        emit(ProfileScreenLoading());
        final mList = await _profileApiRepository.fetchUserList();
        emit(ProfileScreenLoaded(mList));
        if (mList!.error != null) {
          emit(ProfileScreenError(mList.error));
        }
      } on NetworkError {
        emit(ProfileScreenError(
            "Failed to fetch user data. is your device online?"));
      }
    });
  }
}
