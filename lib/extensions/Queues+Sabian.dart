import 'dart:collection';

extension QueuesExtension<E> on ListQueue<E> {
  ///Pops first item from the queue
  E? pop() {
    if (isEmpty) {
      return null;
    }
    return removeFirst();
  }
}
