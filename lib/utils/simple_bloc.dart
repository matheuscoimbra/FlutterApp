import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fisc/utils/progress_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SimpleBloc<T> extends BlocBase {
  final progress = ProgressBloc();

  // stream
  final _controller = BehaviorSubject<T>();
  get stream => _controller.stream;

  get add => _controller.sink.add;

  get addError => _controller.sink.addError;

  @override
  void dispose() {
    super.dispose();

    _controller.close();

    progress.close();
  }

}
