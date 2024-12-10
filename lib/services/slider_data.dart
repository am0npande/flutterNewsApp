import 'package:hlo/models/slider_model.dart';


List<SliderModel> getSliders(){
  List<SliderModel> sliderdata = [];

  SliderModel slider = new SliderModel();

  slider.name = "Bow to authority of silenforce";
  slider.image = "images/bussiness.jpg";
  sliderdata.add(slider);
  slider = new SliderModel();

  slider.name = "Bow to authority of silenforce";
  slider.image = "images/entertainment.jpg";
  sliderdata.add(slider);
  slider = new SliderModel();

  slider.name = "Bow to authority of silenforcel";
  slider.image = "images/general.jpg";
  sliderdata.add(slider);
  slider = new SliderModel();

  slider.name = "Bow to authority of silenforce";
  slider.image = "images/health.jpg";
  sliderdata.add(slider);
  slider = new SliderModel();

  slider.name = "Bow to authority of silenforce";
  slider.image = "images/sport.jpg";
  sliderdata.add(slider);
  slider = new SliderModel();

  return sliderdata;

}