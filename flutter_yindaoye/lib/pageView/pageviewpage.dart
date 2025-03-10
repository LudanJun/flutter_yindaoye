import 'package:flutter/material.dart';

class Pageviewpage extends StatefulWidget {
  const Pageviewpage({super.key});

  @override
  State<Pageviewpage> createState() => _PageviewpageState();
}

class _PageviewpageState extends State<Pageviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selectable Options in PageView'),
      ),
      body: PageView.builder(
        itemCount: 3, // 假设有3页
        itemBuilder: (context, pageIndex) {
          return ListView.builder(
            itemCount: 10, // 每页10个列表项，示例中固定为10个
            itemBuilder: (context, index) {
              // 创建列表项数据模型
              ListItem item = ListItem(title: 'Page $pageIndex Item $index');

              return ListTile(
                title: Text(item.title),
                leading: Radio(
                  value: index,
                  groupValue: pageIndex, // 每页的索引作为组值，确保单选
                  onChanged: (int? value) {
                    // 处理单选逻辑
                    print('Selected $value on page $pageIndex');
                    // 更新选中状态
                    item.toggleSelected();
                    // 通知Flutter框架重新构建UI
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ListItem {
  String title;
  bool isSelected;

  ListItem({required this.title, this.isSelected = false});

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
