import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/slider/bloc/slider_bloc.dart';
import 'package:flutter_playground/features/slider/models/slide_model.dart';

import '../bloc/slider_event.dart';
import '../bloc/slider_state.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<SliderBloc>().add(LoadSlides());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderState>(
        builder: (context, state) {
          if(state is SliderInitial || state is SliderLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is SliderLoaded){
            return _buildSlider(state.slides, state.currentIndex);
          } else if(state is SliderError){
            return Center(child: Text(state.message),);
          } else {
            return const Center(child: Text('Something went wrong'),);
          }
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSlider(List<SlideModel> slides, int currentIndex) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (index){
              context.read<SliderBloc>().add(ChangeSlide(index: index));
            },
            itemBuilder: (context, index) {
              return _buildSlide(slides[index]);
            },
          ),
        )
      ],
    );
  }

  Widget _buildSlide(SlideModel slide) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                child: Image.network(
                    slide.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress == null){
                      return child;
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                      print(error.toString());
                    return Center(child: Container(
                      height: 200,
                      width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Text('Error loading image')),);
                  },
                ),
            ),
            const SizedBox(height: 24,),
            Text(slide.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            const SizedBox(height: 12,),
            Text(slide.description, style: TextStyle(fontSize: 16, color: Colors.grey.shade700), textAlign: TextAlign.center,),
          ],
        )
    );
  }
}
