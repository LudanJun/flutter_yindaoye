import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  //实例化图片选择器
  final ImagePicker _picker = ImagePicker();
  //定义全局获取的图片属性 来实现显示
  XFile? _pickedFile;
  //多个图片和视频
  late List<XFile> _mulpickedFile;
  //多个图片
  late List<XFile> _mulpickedImage;

  //拍照 拍摄一张图片
  _pickCamera() async {
    //获取拍的照片
    XFile? image = await _picker.pickImage(
        //指定选择图片的类型
        source: ImageSource.camera,
        //默认选择的图片很大 需要指定下宽高
        maxWidth: 800,
        maxHeight: 800);
    print(image);
    if (image != null) {
      print(image.path);
      setState(() {
        _pickedFile = image;
      });
    }
  }

  //相册选择 只能选择一张图片
  _pickGallery() async {
    //获取选择的照片
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        //默认选择的图片很大 需要指定下宽高
        maxWidth: 800,
        maxHeight: 800);
    print(image);
    if (image != null) {
      print(image.path);

      //选择完图片 开始上传
      _uploadFile(image.path);
      setState(() {
        _pickedFile = image;
      });
    }
  }

  //media 这个是视频和图片都可以选择 但是只能选择一张或一个视频
  _pickMedia() async {
    //获取选择的照片
    XFile? image = await _picker.pickMedia(maxWidth: 800, maxHeight: 800);
    print(image);
    if (image != null) {
      print("_pickMedia${image.path}");
    }
  }

  //选择多个图像和视频
  _mulpickGalleryAndVideo() async {
    //获取多张图片
    List<XFile> medias = await _picker.pickMultipleMedia(
      limit: 2,
    );
    if (medias.length != 0) {
      print(medias);
    }
  }

  //选择多个图片
  _mulpickGallery() async {
    //获取多张图片
    List<XFile> medias = await _picker.pickMultiImage(
      limit: 2,
    );
    if (medias.length != 0) {
      print(medias);
    }
  }

  //上传图片
  _uploadFile(imageDir) async {
    var formData = FormData.fromMap({
      'username': 'zhangsan',
      'age': 25,
      'file': await MultipartFile.fromFile(imageDir, filename: 'xxx.jpg')
    });

    var response =
        await Dio().post('https://jd.itying.com/imgupload', data: formData);
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _pickCamera, child: Text("拍照")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _pickGallery, child: Text("相册选择")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _mulpickGalleryAndVideo, child: Text("多图片和视频")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _mulpickGallery, child: Text("多图片")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _pickMedia, child: Text("media")),
            SizedBox(
              height: 20,
            ),
            _pickedFile == null
                ? Text("选择照片...")
                //需要用File文件来转换一下得到的图片数据
                : Image.file(File(_pickedFile!.path))
          ],
        ),
      ),
    );
  }
}
