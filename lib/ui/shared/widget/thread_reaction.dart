import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/enums.dart';
import '../../../models/reaction.dart';
import '../../../models/user.dart';
import '../widget/user_avatar.dart';
import '../utils/bottomsheetactions.dart';
import '../utils/reaction.dart';

class ThreadReaction extends StatefulWidget {
  const ThreadReaction(
    this.reactions, {
    super.key,
    required this.onReactionPressed,
  });

  final Map<ReactionType, List<Reaction>> reactions;
  final void Function(ReactionType) onReactionPressed;

  @override
  State<ThreadReaction> createState() => _ThreadReactionState();
}

class _ThreadReactionState extends State<ThreadReaction> {
  Map<ReactionType, bool> hasReactionMap = {};

  // TODO: User who is currently logged in
  final User user = User(
    id: '1',
    fullName: 'John Doe',
    userName: 'johndoe',
    avatarUrl: 'https://picsum.photos/300/300',
    email: 'john@gmail.com',
  );

  @override
  void initState() {
    super.initState();
    for (ReactionType type in reactionType.values) {
      hasReactionMap[type] = hasReaction(widget.reactions[type]!);
    }
  }

  bool hasReaction(List<Reaction> listReaction) {
    return listReaction.any((reaction) => reaction.creatorId == user.id);
  }

  void onOtherReactionPressed(context) {
    showModalBottomSheetActions(
      context: context,
      title: 'Thread Reactions',
      body: ListOtherReaction(
        onReactionPressed: onReactionPressed,
        hasReactionMap: hasReactionMap,
      ),
    );
  }

  void onReactionPressed(ReactionType type) {
    widget.onReactionPressed(type);
    hasReactionMap[type] = hasReaction(widget.reactions[type]!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Reactions
          for (ReactionType type in reactionType.values)
            if (widget.reactions[type] != null &&
                widget.reactions[type]!.isNotEmpty) ...[
              ReactionButton(
                type: type,
                reactions: widget.reactions[type]!,
                onPressed: () => onReactionPressed(type),
                hasReaction: hasReaction(widget.reactions[type]!),
              ),
              const SizedBox(width: 5.0),
            ],

          // Other reactions
          TextButton(
            onPressed: () => onOtherReactionPressed(context),
            child: const Icon(Icons.add_reaction),
          ),
        ],
      ),
    );
  }
}

class ListOtherReaction extends StatefulWidget {
  const ListOtherReaction({
    super.key,
    required this.onReactionPressed,
    required this.hasReactionMap,
  });

  final void Function(ReactionType) onReactionPressed;
  final Map<ReactionType, bool> hasReactionMap;

  @override
  State<ListOtherReaction> createState() => _ListOtherReactionState();
}

class _ListOtherReactionState extends State<ListOtherReaction> {
  void onReactionPressed(ReactionType type) {
    widget.onReactionPressed(type);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (ReactionType type in reactionType.values)
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                side: widget.hasReactionMap[type] ?? false
                    ? BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6))
                    : BorderSide.none,
              ),
              onPressed: () => onReactionPressed(type),
              icon: Text(
                getReactionEmoji(type),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
        ],
      ),
    );
  }
}

class ReactionButton extends StatelessWidget {
  const ReactionButton({
    super.key,
    required this.type,
    required this.reactions,
    required this.hasReaction,
    this.onPressed,
  });

  final ReactionType type;
  final List<Reaction> reactions;
  final bool hasReaction;
  final Function()? onPressed;

  void showListReaction(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      title: '${getReactionEmoji(type)} ${reactions.length}',
      body: ListReactionBottomSheet(
        type: type,
        reactions: reactions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: () => showListReaction(context),
      style: TextButton.styleFrom(
        side: hasReaction
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6))
            : BorderSide.none,
        backgroundColor:
            Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
      ),
      child: Text(
        '${getReactionEmoji(type)} ${reactions.length}',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: hasReaction ? FontWeight.bold : FontWeight.normal,
            ),
      ),
    );
  }
}

class ListReactionBottomSheet extends StatelessWidget {
  const ListReactionBottomSheet({
    super.key,
    required this.type,
    required this.reactions,
  });

  final ReactionType type;
  final List<Reaction> reactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        itemCount: reactions.length,
        itemBuilder: (context, index) => ListTile(
          leading: UserAvatar(reactions[index].creator, size: 40.0),
          title: Text(reactions[index].creator.fullName),
        ),
      ),
    );
  }
}
