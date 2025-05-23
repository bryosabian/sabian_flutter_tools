import 'package:sabian_tools/utils/pipeline/FunctionPipeHandler.dart';
import 'package:sabian_tools/utils/pipeline/SabianAsyncPipeline.dart';
import 'package:test/test.dart';

void main() {
  test('test_async pipeline_works', () async {
    const original = 100;

    const delay = Duration(seconds: 2);

    // Create the pipeline using FunctionPipeHandler for concise handler definition
    final pipeline = SabianFuturePipeline<int, int>(
      FunctionAsyncPipeHandler((int it) async {
        final result = it + 1;

        await Future.delayed(delay);
        // In Dart tests, assertions are typically done with expect() at the end,
        // but we can keep them here to closely match the Kotlin style for this specific conversion.
        // However, it's generally better to test the final output.
        assert(result == 101, "First handler output mismatch");
        return result;
      }),
    ).addHandler<int>(
      FunctionAsyncPipeHandler((int it) async {
        final next = it + 1;
        await Future.delayed(delay);
        assert(next == 102, "Second handler output mismatch");
        return next;
      }),
    ).addHandler<int>(
      FunctionAsyncPipeHandler((int it) async {
        final next = it + 1;
        await Future.delayed(delay);
        assert(next == 103, "Third handler output mismatch");
        return next;
      }),
    );

    final finalResult = await pipeline.execute(original);

    // The primary assertion for the test
    expect(finalResult, equals(103));
  });
}
