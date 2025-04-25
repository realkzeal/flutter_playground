import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/slider/bloc/slider_event.dart';
import 'package:flutter_playground/features/slider/bloc/slider_state.dart';

import '../models/slide_model.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(SliderInitial()) {
    on<LoadSlides>(_onLoadSlides);
    on<ChangeSlide>(_onChangeSlide);
  }

  FutureOr<void> _onLoadSlides(LoadSlides event, Emitter<SliderState> emit) {
    final slides = [
      SlideModel(
        id: '1',
        imageUrl: 'assets/images/slide1.jpg',
        title: 'Slide 1',
        description: 'This is slide 1',
      ),
      SlideModel(
        id: '2',
        imageUrl: 'assets/images/slide2.jpg',
        title: 'Slide 2',
        description: 'This is slide 2',
      ),
      SlideModel(id: '3',
          imageUrl: 'assets/images/slide3.jpg',
          title: 'Slide 3', description: 'This is slide 3')
    ];
  }

  FutureOr<void> _onChangeSlide(ChangeSlide event, Emitter<SliderState> emit) {
    if(state is SliderLoaded){
      final currentState = state as SliderLoaded;
      emit(currentState.copyWith(currentIndex: event.index));
    }
  }
}
