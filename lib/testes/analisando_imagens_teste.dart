// return Scaffold(
//       body: _isLoading
//           ? Container(
//               alignment: Alignment.center,
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   _image == null
//                       ? Container(
//                           child: Text('Sem IMAGEM'),
//                         )
//                       : Image.file(_image),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   _output == null
//                       ? Text('SEM LABEL')
//                       : Container(
//                           child: Column(
//                           children: <Widget>[
//                             Text('${_output[0]['label']}'),
//                             Text('${_output[0]['confidence']}')
//                           ],
//                         ))
//                 ],
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         child: Icon(
//           Icons.image,
//         ),
//         onPressed: () {
//           chooseImage();
//         },
//       ),
//     );


//  chooseImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//     if (image == null) {
//       return null;
//     }
//     setState(() {
//       _isLoading = true;
//       _image = image;
//     });
//     runModelOnImage(image);
//   }

//   runModelOnImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       imageMean: 127.5,
//       imageStd: 0.5,
//     );
//     print('OUTPUT: ${output}');
//     setState(() {
//       _isLoading = false;
//       _output = output;
//     });
//   }