import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:insta_wather/services/weather.dart';
import 'bottom_nav.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late VideoPlayerController _controller;

  String? valueText;
  String? cityName;

  @override
  void initState() {
    super.initState();

    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/images/loading_video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  void getData() async {
    WeatherModel weatherModel = WeatherModel();

    var weatherData = await weatherModel.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BottomNavControl(
        locationWeather: weatherData,
      );
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getData();
                  },
                  child: Text('Get current city weather'),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     _displayTextInputDialog(context);
                //   },
                //   child: Text('Get for another city'),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
