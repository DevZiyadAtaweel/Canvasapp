import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_son_state.dart';

class AddSonCubit extends Cubit<AddSonState> {
  AddSonCubit() : super(AddSonInitial());
}
