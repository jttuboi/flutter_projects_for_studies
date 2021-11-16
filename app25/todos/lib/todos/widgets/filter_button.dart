import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    this.visible = false,
    Key? key,
  }) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        final button = _Button(
          onSelected: (filter) => context.read<FilteredTodosBloc>().add(FilterUpdated(filter)),
          currentFilter: state is FilteredTodosLoadSuccess ? state.currentFilter : VisibilityFilter.all,
          activeStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).colorScheme.secondary),
          defaultStyle: Theme.of(context).textTheme.bodyText2!,
        );
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          child: visible ? button : IgnorePointer(child: button),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onSelected,
    required this.currentFilter,
    required this.activeStyle,
    required this.defaultStyle,
    Key? key,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter currentFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: Keys.filterButton,
      icon: const Icon(Icons.filter_list),
      tooltip: 'Filter Todos',
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<VisibilityFilter>(
          key: Keys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            'Show All',
            style: currentFilter.isAll ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: Keys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            'Show Active',
            style: currentFilter.isActive ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: Keys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            'Show Completed',
            style: currentFilter.isCompleted ? activeStyle : defaultStyle,
          ),
        ),
      ],
    );
  }
}
