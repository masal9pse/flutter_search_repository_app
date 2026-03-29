part of '../repo_detail_screen.dart';

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final int value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final inner = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: onPressed != null
          ? InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(12),
              child: inner,
            )
          : inner,
    );
  }
}
