import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
List <CameraDescription> cameras = [];
class CameraPAge extends StatefulWidget {
  const CameraPAge({super.key});

  @override
  State<CameraPAge> createState() => _CameraPAgeState();
}

class _CameraPAgeState extends State<CameraPAge> {
  int index = 0;
  CameraController? _cameraController;
  var cameraValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[index], ResolutionPreset.high);
    cameraValue = _cameraController?.initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder(future: cameraValue, builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done){
            return CameraPreview(_cameraController!);
          }
          return Center(child: CircularProgressIndicator());
        },),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.insert_photo),
                Icon(Icons.panorama_fish_eye),
                InkWell(
                  onTap: () {
                    setState(() {
                      index = (index == 0)? 1 : 0;
                      _cameraController = CameraController(cameras[index], ResolutionPreset.high);
                      cameraValue = _cameraController?.initialize();
                    });
                  },
                  child: Icon(Icons.switch_camera_sharp))
              ],
            ),
          ),
        ),
      ],
    );
  }
}