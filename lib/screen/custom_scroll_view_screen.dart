import 'dart:html';

import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }
  //  Extent는 높이를 말한다.
  @override
  // 최대 높이
  double get maxExtent => maxHeight;

  @override
  // 최소 높이
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // oldDelegate - build가 실행이 됐을때 이전 Delegate
  // this - 새로운 Delegate
  // shouldRebuild - 새로우 build를 해야할지 말지 결정
  // false - build안함 true - 빌드 다시함
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
    oldDelegate.maxHeight != maxHeight ||
    oldDelegate.child != child;
  }

}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

        // slivers 는 List형태의 위젯을 전부 사용가능하다.
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderChildSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),

        ],
      ),
    );
  }



  SliverPersistentHeader renderHeader() {
    return  SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '신기하지~',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        minHeight: 75,
        maxHeight: 150,
      ),
    );
  }

    // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤 했을때 리스트의 중간에도 AppBar가 내려오게 할 수 있다.
      floating: true,
      // 완전고정
      pinned: false,
      // 자석 효과
      // floating true 에만 사용가능
      snap: true,
      // 맨 위에서 한계 이상으로 스크롤 했을떄
      // 남는 공간을 차지
      stretch: true,
      // Appbar의 높이
      expandedHeight: 200,
      // Appbar가 더 빠르게 밀려들어가는 구간 설정
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('asset/img/good.jpg',
        fit: BoxFit.cover,),
        title: Text('FlexibleSpace', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
      title: Text('CustomScrollViewScreen'),
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
