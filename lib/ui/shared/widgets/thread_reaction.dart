import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/enums.dart';
import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../utils/index.dart';
import './index.dart';

class ThreadReaction extends StatefulWidget {
  const ThreadReaction(
    this.reactions, {
    super.key,
    required this.onReactionPressed,
  });

  final List<Reaction> reactions;
  final void Function(Reaction) onReactionPressed;

  @override
  State<ThreadReaction> createState() => _ThreadReactionState();
}

class _ThreadReactionState extends State<ThreadReaction> {
  Map<ReactionType, bool> hasReactionMap = {};
  Map<ReactionType, List<Reaction>> reactionsMap = {};

  @override
  void initState() {
    super.initState();
    _initReactions();
  }

  @override
  void didUpdateWidget(covariant ThreadReaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initReactions();
  }

  void _initReactions() {
    for (ReactionType type in reactionType.values) {
      reactionsMap[type] =
          widget.reactions.where((reaction) => reaction.type == type).toList();
      hasReactionMap[type] = _hasReaction(widget.reactions, type);
    }
  }

  bool _hasReaction(List<Reaction> listReaction, ReactionType type) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;
    return listReaction.any((reaction) =>
        reaction.creator!.id == loggedInUser!.id && reaction.type == type);
  }

  void _onOtherReactionPressed() {
    showModalBottomSheetActions(
      context: context,
      title: 'Thread Reactions',
      body: ListOtherReaction(
        onReactionPressed: _onReactionPressed,
        hasReactionMap: hasReactionMap,
      ),
    );
  }

  void _onReactionPressed(ReactionType type) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;
    Reaction reaction;

    if (hasReactionMap[type] ?? false) {
      reaction = reactionsMap[type]!
          .firstWhere((reaction) => reaction.creator!.id == loggedInUser!.id);
      hasReactionMap[type] = false;
      reactionsMap[type]!.remove(reaction);
    } else {
      reaction = Reaction(type: type);
      hasReactionMap[type] = true;
      reactionsMap[type]!.add(reaction);
    }
    widget.onReactionPressed(reaction);
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
            if (reactionsMap[type] != null &&
                reactionsMap[type]!.isNotEmpty) ...[
              ReactionButton(
                type: type,
                reactions: reactionsMap[type]!,
                onPressed: () => _onReactionPressed(type),
                hasReaction: hasReactionMap[type]!,
              ),
              const SizedBox(width: 5.0),
            ],

          // Other reactions
          TextButton(
            onPressed: _onOtherReactionPressed,
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
  void _onReactionPressed(ReactionType type) {
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
                    ? BorderSide(color: Theme.of(context).colorScheme.primary)
                    : BorderSide.none,
              ),
              onPressed: () => _onReactionPressed(type),
              icon: Text(getReactionEmoji(type)),
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
            ? BorderSide(color: Theme.of(context).colorScheme.primary)
            : BorderSide.none,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Text(
        '${getReactionEmoji(type)} ${reactions.length}',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
          leading: UserAvatar(reactions[index].creator!, size: 40.0),
          title: Text(reactions[index].creator!.fullname),
        ),
      ),
    );
  }
}
