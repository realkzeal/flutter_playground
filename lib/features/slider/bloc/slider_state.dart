import 'package:equatable/equatable.dart';

import '../models/slide_model.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<SlideModel> slides;
  final int currentIndex;

  const SliderLoaded({required this.slides, this.currentIndex = 0});

  @override
  List<Object> get props => [slides, currentIndex];

  SliderLoaded copyWith({
    List<SlideModel>? slides,
    int? currentIndex,
  }) {
    return SliderLoaded(
      slides: slides ?? this.slides,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class SliderError extends SliderState {
  final String message;

  const SliderError(this.message);

  @override
  List<Object> get props => [message];
}
