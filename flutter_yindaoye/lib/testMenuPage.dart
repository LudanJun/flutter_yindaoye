import 'package:flutter/material.dart';

class TestMenuPage extends StatefulWidget {
  const TestMenuPage({super.key});

  @override
  State<TestMenuPage> createState() => _TestMenuPageState();
}

class _TestMenuPageState extends State<TestMenuPage> {
  ScrollController barController = ScrollController();
  ScrollController leftBarController = ScrollController();
  ScrollController topController = ScrollController();
  ScrollController leftController = ScrollController();
  ScrollController rightController = ScrollController();
  ScrollController rightBarController = ScrollController();

  List<LeftData> leftList = [];

  int _leftIndex = 0;

  Map<int, List<int>> totalItem = {};

  late double height;

  @override
  void initState() {
    super.initState();

    leftList =
        List.generate(20, (index) => LeftData('$index组', index + 1)).toList();
  }

  @override
  Widget build(BuildContext context) {
    int length = 0;

    totalItem.forEach((key, value) {
      length += value.length;
    });

    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('测试菜单'),
        actions: [
          Container(
            width: 80,
            height: 50,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print('所有选中的项目: ${totalItem.toString()}');
                },
                child: const Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.min,

        children: [
          if (length != 0)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 36,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '已选择',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(
                              0xff282828,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            width: 8,
                          ),
                        ),
                        const TextSpan(
                          text: '擅长治疗疾病最多选择20个',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(
                              0xff989898,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 173,
                  ),
                  child: Scrollbar(
                    // controller: barController,
                    thickness: 2,
                    child: SingleChildScrollView(
                      // controller: topController,
                      key: UniqueKey(),
                      primary: true,
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        runSpacing: 13,
                        spacing: 13,
                        children: _grow(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xfff0f0f0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: double.infinity,
                    child: Scrollbar(
                      controller: leftBarController,
                      thickness: 2,
                      child: ListView.builder(
                        // controller: leftController,
                        primary: true,
                        key: UniqueKey(),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, index) {
                          LeftData l = leftList[index];

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                _leftIndex = index;
                              });

                              print('_leftIndex: $_leftIndex');
                            },
                            child: Container(
                              height: 44,
                              width: double.infinity,
                              color: _leftIndex == index
                                  ? Colors.white
                                  : const Color(0xfff2f2f2),
                              child: _leftIndex == index
                                  ? Stack(
                                      children: [
                                        Positioned(
                                          left: 20,
                                          top: 12,
                                          bottom: 12,
                                          child: Center(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Color(0xffc33b2a),
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              height: 15,
                                              width: 2,
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 32,
                                          top: 12,
                                          bottom: 12,
                                          child: Text(
                                            l.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff282828),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        Positioned(
                                          left: 32,
                                          top: 12,
                                          bottom: 12,
                                          child: Text(
                                            l.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff282828),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          );
                        },
                        itemCount: leftList.length,
                        itemExtent: 44,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Scrollbar(
                        // controller: rightBarController,
                        thickness: 2,
                        child: SingleChildScrollView(
                          // controller: rightController,
                          primary: true,
                          key: UniqueKey(),
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(
                                50,
                                (index) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        setState(() {
                                          if (length < 20) {
                                            if (totalItem[_leftIndex] == null) {
                                              totalItem[_leftIndex] = [];
                                            }
                                            List<int> list =
                                                totalItem[_leftIndex]!;
                                            if (!list.contains(index)) {
                                              list.add(index);
                                            } else {
                                              list.remove(index);
                                            }

                                            print(
                                                'totalItem: ${totalItem.toString()}');
                                          } else {
                                            print('最多只能选择20个');
                                          }
                                        });

                                        _grow();
                                      },
                                      child: totalItem[_leftIndex] != null &&
                                              totalItem[_leftIndex]!
                                                  .contains(index)
                                          ? Container(
                                              height: 32,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(2),
                                                ),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffc33b2a),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '$_leftIndex组$index项',
                                                  style: const TextStyle(
                                                    color: Color(0xffc33b2a),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 32,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(2),
                                                ),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffd0d0d0),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '$_leftIndex组$index项',
                                                  style: const TextStyle(
                                                    color: Color(0xff282828),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _grow() {
    List<Widget> list = [];

    totalItem.forEach((key, value) {
      list.addAll(value
          .map(
            (e) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print('delete: $e');

                setState(() {
                  totalItem[key]?.remove(e);
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      border: Border.all(
                        color: const Color(0xffc33b2a),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            '$key组$e项',
                            style: const TextStyle(
                              color: Color(0xffc33b2a),
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'x',
                            style: TextStyle(
                              color: Color(0xffc33b2a),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList());
    });

    return list;
  }
}

class LeftData {
  String name;

  int id;

  LeftData(this.name, this.id);
}
