import 'SabianSnackListItem.dart';

class SabianSnackListController {
  late List<SabianSnackListItem> items;
  void Function(List<SabianSnackListItem>)? onChanged;

  ///Should be called from the widget
  void init(List<SabianSnackListItem> items,
      {void Function(List<SabianSnackListItem>)? onChanged}) {
    this.items = items;
    this.onChanged = onChanged;
  }

  void append(SabianSnackListItem item) {
    items.insert(0, item);
    onChanged?.call(items);
  }

  void appendAll(List<SabianSnackListItem> items) {
    this.items.addAll(items);
    onChanged?.call(items);
  }

  void setAll(List<SabianSnackListItem> items) {
    this.items = items;
    onChanged?.call(items);
  }

  void update(SabianSnackListItem item, {bool addIfNotFound = true}) {
    final index = items.indexOf(item);
    if (index <= -1) {
      if (addIfNotFound) {
        append(item);
      }
      return;
    }
    items[index] = item;
    onChanged?.call(items);
  }

  void delete(SabianSnackListItem item) {
    final index = items.indexOf(item);
    if (index > -1) {
      items.removeAt(index);
      onChanged?.call(items);
      return;
    }
  }
}
