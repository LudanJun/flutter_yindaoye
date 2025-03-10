import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_yindaoye/cart/cart_view.dart';
import 'package:flutter_yindaoye/cart/provider.dart';
import 'package:flutter_yindaoye/chewie_video_player.dart';
import 'package:flutter_yindaoye/choese/choese_danxuan.dart';
import 'package:flutter_yindaoye/dropdownMenu.dart';
import 'package:flutter_yindaoye/imagePicker.dart';
import 'package:flutter_yindaoye/choeseFood/left_right_menu.dart';
import 'package:flutter_yindaoye/list_menu.dart';
import 'package:flutter_yindaoye/lunbo_photo_video/lunbo_photo_video_page.dart';
import 'package:flutter_yindaoye/medit_kit/medit_kit_page.dart';
import 'package:flutter_yindaoye/nestedScrollow/ScrollorHeadGuDing.dart';
import 'package:flutter_yindaoye/nestedScrollow/nested.dart';
import 'package:flutter_yindaoye/nestedScrollow/nested_head_gundong.dart';
import 'package:flutter_yindaoye/nestedScrollow/nested_head_pull.dart';
import 'package:flutter_yindaoye/nestedScrollow/scroll_to_top.dart';
import 'package:flutter_yindaoye/nine_photo/nine_pic_page.dart';
import 'package:flutter_yindaoye/pageView/pageviewpage.dart';
import 'package:flutter_yindaoye/pages/newpage.dart';
import 'package:flutter_yindaoye/segment.dart';
import 'package:flutter_yindaoye/nestedScrollow/sliver_page.dart';
import 'package:flutter_yindaoye/testMenuPage.dart';
// import 'package:flutter_yindaoye/textfield/textField.dart';
import 'package:flutter_yindaoye/videoplayer.dart';
import 'package:flutter_yindaoye/videoPicker.dart';
import 'package:flutter_yindaoye/voice/voice_page.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartVProvider>(create: (_) => CartVProvider()),
      ],
      child: MaterialApp(
        title: '开场动画',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),

        //配置国际化
        localizationsDelegates: const [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          //此处
          Locale('zh', 'CH'),
          Locale('en', 'US'),
        ],
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        // home: homePage(),
        // home: VideoPage(),
        // home: ChewieVideoPage(),
        // home: ImagePickerPage(),
        // home: VideoPickerPage(),
        // home: TestMenuPage(),
        // home: ListMenuPage(),
        // home: LeftRightMenuPage(),

        initialRoute: '/homePage',
        routes: <String, WidgetBuilder>{
          '/homePage': (BuildContext context) => homePage(),
          '/newPage': (BuildContext context) => newPage(), //NewPage就是自己写的一个页面
          '/videoplayer': (BuildContext context) => VideoPage(),
          '/chewie_video_player': (BuildContext context) => ChewieVideoPage(),
          '/imagePicker': (BuildContext context) => ImagePickerPage(),
          '/testMenuPage': (BuildContext context) => TestMenuPage(),
          '/list_menu': (BuildContext context) => ListMenuPage(),
          '/LeftRightMenuPage': (BuildContext context) => LeftRightMenuPage(),
          '/DropdownMenuPage': (BuildContext context) => DropdownMenuPage(),
          '/SegmentPage': (BuildContext context) => SegmentPage(),
          '/CartViewPage': (BuildContext context) => CartViewPage(),
          '/SliverPage': (BuildContext context) => SliverPage(),
          '/NestedScrollPage': (BuildContext context) => NestedScrollPage(),
          '/NinePicPage': (BuildContext context) => NinePicPage(),
          '/VoicePage': (BuildContext context) => VoicePage(),
          '/NestedHeadGundongPage': (BuildContext context) =>
              NestedHeadGundongPage(),
          '/NestedHeadPullPage': (BuildContext context) => NestedHeadPullPage(),
          '/ScrollorheadgudingPage': (BuildContext context) =>
              ScrollorheadgudingPage(),
          '/ScrollToTopPage': (BuildContext context) => ScrollToTopPage(),
          // '/TextfieldPage': (BuildContext context) => TextfieldPage(),
          '/MeditKitPage': (BuildContext context) => MeditKitPage(),
          '/ChoeseDanxuanPage': (BuildContext context) => ChoeseDanxuanPage(),
          '/Pageviewpage': (BuildContext context) => Pageviewpage(),
          '/LunboPhotoVideoPage': (BuildContext context) =>
              LunboPhotoVideoPage(),
        },
      ),
    );
  }
}

class homePage extends StatelessWidget {
  homePage({super.key});
  final pages = [
    PageViewModel(
      pageColor: Colors.blueAccent,
      mainImage: Image.asset('images/1.jpg'),
      title: Text("第一页"),
      body: Text("海浪里的哈偶"),
    ),
    PageViewModel(
      pageColor: Colors.blueAccent,
      mainImage: Image.asset('images/1.jpg'),
      title: Text("第二页"),
      body: Text("海浪里的哈偶"),
    ),
    PageViewModel(
      pageColor: Colors.blueAccent,
      mainImage: Image.asset('images/1.jpg'),
      title: Text("第三页"),
      body: Text("海浪里的哈偶"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          //路由跳转
          Navigator.of(context).pushReplacementNamed('/newPage');
        },
        showSkipButton: true,
        skipText: Text('跳过'),
        doneText: Text('完成'),
        pageButtonTextStyles: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }
}
