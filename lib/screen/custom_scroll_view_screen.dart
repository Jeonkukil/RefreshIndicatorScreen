import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // slivers 는 List형태의 위젯을 전부 사용가능하다.
        slivers: [
          SliverAppBar(
            title: Text('CustomScrollViewScreen'),
          ),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }




  // GridViewBuilder와 비슷함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }



  // GridView.count 유사함

  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // 기본형태
  SliverList renderChildSliverList() {
    return SliverList(
      // delegate 어떤 형태로 List를 만들지 정한다.
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList()),
    );
  }

  // 기본형태에서 builder

  SliverList renderChildSliverListBuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  // 이러한 형태가 필요할떄 customScrollView를 사용한다.
  Widget customadd() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: rainbowColors
                .map(
                  (e) => renderContainer(
                    color: e,
                    index: 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
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
