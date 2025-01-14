// import 'package:flutter/material.dart';
// import 'package:trial/services/loginapi.dart';
// import 'package:video_player/video_player.dart';

// class WorkoutDetailPage extends StatefulWidget {
//   final String title;
//   final String description;
//   final List<Map<String, String>> setsAndReps;
//   final String image;
//   final Function(bool) onCompletionUpdate; // Add this callback

//   WorkoutDetailPage({
//     required this.title,
//     required this.description,
//     required this.setsAndReps,
//     required this.image,
//     required this.onCompletionUpdate, // Pass the callback here
//   });

//   @override
//   State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
// }

// class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
//   late VideoPlayerController _controller;

  
// @override
// void initState() {
//   super.initState();
//   String videoUrl = '$baseUrl/${widget.image}';
//   print('Video URL: $videoUrl');

//   _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//     ..initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized
//       setState(() {});
//     }).catchError((error) {
//       print('Error initializing video: $error');
//     });

//   _controller.addListener(() {
//     if (_controller.value.isCompleted) setState(() {});
//   });
// }


//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isCompleted = false;

//     return Scaffold(
    
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               // video
//               InkWell(
                
//                 child: Stack(
//                   children: [
//                     InkWell(
//                       onTap: (){
//                                 setState(() {
//                                 _controller.value.isPlaying
//                                     ? _controller.pause()
//                                     : _controller.play();
//                               });
//                             },
//                       child: Container(
//                         height: 200,width: double.infinity,color: Colors.black12,
//                         child: Center(
//                           child: _controller.value.isInitialized
//                               ? AspectRatio(
//                                   aspectRatio: _controller.value.aspectRatio,
//                                   child: VideoPlayer(_controller),
//                                 )
//                               : Container(),
//                         ),
//                       ),
//                     ),
                  
//                     // Progress Indicator at the bottom
//                     Positioned(
//                       bottom: 0,
//                       left: 2,
//                       right: 2,
//                       child: _controller.value.isInitialized
//                           ? Row(
//                               children: [
//                                 IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         _controller.value.isPlaying
//                                             ? _controller.pause()
//                                             : _controller.play();
//                                       });
//                                     },
//                                     icon: Icon(
//                                       _controller.value.isPlaying
//                                           ? Icons.pause
//                                           : Icons.play_circle_outline_outlined,
//                                       size: 28,
//                                       color: Colors.white,
//                                     )),
//                                 Expanded(
//                                   child: VideoProgressIndicator(
//                                     _controller,
//                                     allowScrubbing:
//                                         true, // Allows user to scrub through video
//                                     colors: VideoProgressColors(
//                                       playedColor: Colors
//                                           .red, // Color of the played portion
//                                       backgroundColor: Colors
//                                           .grey, // Color of the background bar
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(_formatDuration(
//                                       _controller.value.duration)),
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                     ),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(widget.description),
//               ),
//               Column(
//                 children: widget.setsAndReps.map((set) {
//                   return ListTile(
//                     title: Text("${set['set']} - ${set['reps']} reps"),
//                   );
//                 }).toList(),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     isCompleted = !isCompleted;
//                     widget.onCompletionUpdate(
//                         isCompleted); // Call the callback to update completion status
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                       isCompleted ? 'Mark as Incomplete' : 'Mark as Completed'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:trial/homepage.dart';
import 'package:trial/services/loginapi.dart';
import 'package:video_player/video_player.dart';

List<String>viewedIndex=[];

class WorkoutDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, String>> setsAndReps;
  final String image;
  final Function(bool) onCompletionUpdate;
  final index;

  WorkoutDetailPage({
    required this.title,
    required this.description,
    required this.setsAndReps,
    required this.image,
    required this.onCompletionUpdate, this.index,
  });

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
          
              Container(width: double.infinity,
                height: 250,child: Image.network('$baseUrl/${widget.image}',fit: BoxFit.fill,),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),

              // Sets and Reps
              Column(
                children: widget.setsAndReps.map((set) {
                  return ListTile(
                    title: Text("${set['set']} - ${set['reps']} reps"),
                  );
                }).toList(),
              ),

              // Completion Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      viewedIndex.add(widget.index['name']);
                      isCompleted = !isCompleted;
                      workoutprogress.value=workoutprogress.value+0.2;
                      print(workoutprogress.value);
                    });
                    widget.onCompletionUpdate(isCompleted);
                    Navigator.pop(context);
                  },
                  child: Text(isCompleted ? 'Mark as Incomplete' : 'Mark as Completed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
