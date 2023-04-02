import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      // 각각 유니크한 Key를 넣어야 한다.
      body: renderto(),
    );
  }



  Widget renderto() {
    return  ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        itemCount: numbers.length,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        });
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // oldIdex와 newIndex 모두
          // 이동이 되기 전에 산정한다.
          // [red, orange, yellow]
          // [0, 1, 2]
          // 만약 red를 yellow 다음으로 옮기고 싶다.
          // red : 0 oldIndex -> 3 newIndex
          // [orange, yellow, red]
          // [red, orange, yellow]
          // yellow를 red 전으로 옮기고싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          // 특정 위치에 있는 값을 뺄 수 있다.
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      key: Key(index.toString()),
      // height == null ? 300 : height
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
