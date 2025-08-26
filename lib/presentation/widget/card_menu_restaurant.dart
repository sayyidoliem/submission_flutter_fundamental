import 'package:flutter/material.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/menu.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/food.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/drink.dart';

class MenusSection extends StatelessWidget {
  final Menu? menus;
  const MenusSection({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    final foods = menus?.foods ?? const <Food>[];
    final drinks = menus?.drinks ?? const <Drink>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Menus',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        _Subheading(text: 'Foods :'),
        foods.isEmpty
            ? const _EmptyText('Food list not avaible')
            : _ScrollableChips(labels: foods.map((f) => f.name).toList()),
        const SizedBox(height: 12),
        _Subheading(text: 'Drinks :'),
        drinks.isEmpty
            ? const _EmptyText('Drink list not avaible')
            : _ScrollableChips(labels: drinks.map((d) => d.name).toList()),

        const SizedBox(height: 8),
      ],
    );
  }
}

class _Subheading extends StatelessWidget {
  final String text;
  const _Subheading({required this.text});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    ),
  );
}

class _EmptyText extends StatelessWidget {
  final String text;
  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(text, style: const TextStyle(color: Colors.grey)),
  );
}

class _ScrollableChips extends StatelessWidget {
  final List<String> labels;
  const _ScrollableChips({required this.labels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final text = labels[index];
          return Container(
            constraints: const BoxConstraints(minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
