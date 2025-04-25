import 'package:equatable/equatable.dart';

abstract class SliderEvent  extends Equatable {
  const SliderEvent();

  @override
  List<Object> get props => [];
}

class LoadSlides extends SliderEvent {}

class ChangeSlide extends SliderEvent {
  final int index;

  const ChangeSlide({required this.index});

  @override
  List<Object> get props => [index];
}