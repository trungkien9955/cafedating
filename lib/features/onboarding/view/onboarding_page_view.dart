import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/onboarding/controller/notifiers/dot_index_notifier.dart';
import 'package:cafedating/features/onboarding/view/widgets/onboarding_screen.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageView extends ConsumerWidget {
  OnboardingPageView({super.key});
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(dotIndexProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            onPageChanged: (value) =>
                {ref.read(dotIndexProvider.notifier).changeIndex(value)},
            children: [
              OnboardingScreen(
                controller: _controller,
                imagePath: '${AppConstants.imageUrl}/earth-4.gif',
                title: 'Bản đồ',
                subTitle:
                    'Tìm đối tác hẹn hò gần bạn, hoặc gần địa điểm bạn yêu thích, trực tiếp trên bản đồ',
                index: 1,
                // context: context,
              ),
              OnboardingScreen(
                controller: _controller,
                imagePath: '${AppConstants.imageUrl}/coffee6.gif',
                title: 'Cafe',
                subTitle:
                    'Tìm cafe gần bạn, xem những ai đang hoặc dự định sẽ đến đó',
                index: 2,
                // context: context,
              ),
              OnboardingScreen(
                controller: _controller,
                imagePath: '${AppConstants.imageUrl}/holding-hands.png',
                title: 'Tìm người ấy',
                subTitle:
                    'Tìm và kết bạn với người ấy theo thành phố, quê quán, nghề nghiệp...',
                index: 3,
                // context: context,
              ),
            ],
          ),
          Positioned(
              bottom: 50,
              child: Column(children: [
                // DotsIndicator(
                //   position: index,
                //   dotsCount: 3,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   decorator: DotsDecorator(
                //       size: const Size.square(9.0),
                //       activeSize: const Size(24.0, 8.0),
                //       activeShape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5))),
                // ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  onDotClicked: (index) {
                    _controller.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  effect: const JumpingDotEffect(
                    spacing: 16,
                    dotColor: Colors.grey,
                    activeDotColor: AppTheme.primaryColor,
                    radius: 8.0,
                    dotWidth: 16.0,
                    dotHeight: 16.0,
                  ),
                )
              ]))
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class OnboardingPageView extends StatelessWidget {
//   const OnboardingPageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
