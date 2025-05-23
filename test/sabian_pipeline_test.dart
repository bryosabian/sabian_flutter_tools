import 'package:sabian_tools/utils/pipeline/FunctionPipeHandler.dart';
import 'package:sabian_tools/utils/pipeline/SabianPipeline.dart';
import 'package:test/test.dart';

void main() {
  test('test_pipeline_works', () {
    const original = 100;

    // Create the pipeline using FunctionPipeHandler for concise handler definition
    final pipeline = SabianPipeline<int, int>(
      FunctionPipeHandler((int it) {
        final result = it + 1;
        // In Dart tests, assertions are typically done with expect() at the end,
        // but we can keep them here to closely match the Kotlin style for this specific conversion.
        // However, it's generally better to test the final output.
        assert(result == 101, "First handler output mismatch");
        return result;
      }),
    ).addHandler<int>(
      FunctionPipeHandler((int it) {
        final next = it + 1;
        assert(next == 102, "Second handler output mismatch");
        return next;
      }),
    ).addHandler<int>(
      FunctionPipeHandler((int it) {
        final next = it + 1;
        assert(next == 103, "Third handler output mismatch");
        return next;
      }),
    );

    final finalResult = pipeline.execute(original);

    // The primary assertion for the test
    expect(finalResult, equals(103));
  });
}
