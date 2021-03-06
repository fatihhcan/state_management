import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 0, isIncremented: false));

  void increment() => emit(CounterState(counter: state.counter + 1, isIncremented: state.isIncremented = true));
  void decrement() => emit(CounterState(counter: state.counter - 1, isIncremented: state.isIncremented = false));
  void reset() => emit(CounterState(counter: state.counter = 0, isIncremented: state.isIncremented = false));
}
