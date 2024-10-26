import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import './widgets/index.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingInfo> _pages = OnboardingItems().items;
  final PageController _pageController = PageController();

  bool _isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  void _onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _isLastPage = _pages.length - 1 == index);
  }

  Future<void> _completeOnboarding() async {
    await context.read<OnboardingManager>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Page View
      body: PageView.builder(
        onPageChanged: _onPageChanged,
        itemCount: _pages.length,
        controller: _pageController,
        itemBuilder: (context, index) => OnboardingPage(_pages[index]),
      ),

      // Page Controller
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _isLastPage ? getStarted() : pageIndicator(),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _completeOnboarding,
        child: const Text("Get Started"),
      ),
    );
  }

  Widget pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip Button
        TextButton(
          onPressed: _onSkip,
          child: const Text("Skip"),
        ),

        // Indicator
        SmoothPageIndicator(
          controller: _pageController,
          count: _pages.length,
          onDotClicked: (index) => _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ),
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
        ),

        // Next Button
        TextButton(
          onPressed: _onNext,
          child: const Text("Next"),
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
    this.page, {
    super.key,
  });

  final OnboardingInfo page;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          page.svg,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
        const SizedBox(height: 15),
        Text(
          page.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Text(
          page.descriptions,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
