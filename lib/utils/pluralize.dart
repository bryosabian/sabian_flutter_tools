import 'package:collection/collection.dart';
import 'package:pluralize/pluralize.dart';

enum Plurality { Singular, Plural }

extension StringPluralization on String {
  String pluralize({Plurality plurality = Plurality.Singular}) {
    final pluralizer = Pluralize();
    if (plurality == Plurality.Plural) {
      return pluralizer.singular(this);
    }
    return pluralizer.plural(this);
  }

  String pluralizeNative({Plurality plurality = Plurality.Singular}) {
    if (plurality == Plurality.Plural) return this;
    if (plurality == Plurality.Singular) return _pluralizer;
    if (singularizer != this &&
        singularizer + "s" != this &&
        singularizer._pluralizer == this &&
        _pluralizer != this) {
      return this;
    }

    return _pluralizer;
  }

  String singularize({Plurality plurality = Plurality.Plural}) {
    if (plurality == Plurality.Singular) return this;

    if (plurality == Plurality.Plural) return singularizer;

    if (_pluralizer != this &&
        this + "s" != _pluralizer &&
        _pluralizer.singularize() == this &&
        singularizer != this) {
      return this;
    }

    return singularizer;
  }

  String pluralizeWithCount(int count) {
    return count > 1 ? pluralize() : singularize();
  }

  String singularizeWithCount(int count) {
    return count > 1
        ? singularize(plurality: Plurality.Plural)
        : singularize(plurality: Plurality.Singular);
  }

  String get _pluralizer {
    if (uncountable.contains(toLowerCase())) return this;
    final rule = pluralizeRules.lastWhereOrNull(
        (rule) => RegExp(rule.key, caseSensitive: false).hasMatch(this));
    if (rule == null) return this;
    var found = replaceAllMapped(
        RegExp(rule.key, caseSensitive: false), (match) => rule.value);
    final _endsWith = exceptions.firstWhereOrNull((pair) => endsWith(pair.key));
    if (_endsWith != null) found = replaceAll(_endsWith.key, _endsWith.value);
    final exception =
        exceptions.firstWhereOrNull((pair) => equalsIgnoreCase(pair.key));
    if (exception != null) found = exception.value;
    return found;
  }

  String get singularizer {
    if (uncountable.contains(toLowerCase())) {
      return this;
    }
    final _exceptions =
        exceptions.firstWhereOrNull((pair) => equalsIgnoreCase(pair.value));

    if (_exceptions != null) {
      return _exceptions.key;
    }
    final _endsWith =
        exceptions.firstWhereOrNull((pair) => endsWith(pair.value));

    if (_endsWith != null) return replaceAll(_endsWith.value, _endsWith.key);

    try {
      if (singularizeRules
          .where(
              (rule) => RegExp(rule.key, caseSensitive: false).hasMatch(this))
          .isEmpty) {
        return this;
      }
      final rule = singularizeRules.lastWhere(
          (rule) => RegExp(rule.key, caseSensitive: false).hasMatch(this));
      return replaceAllMapped(
          RegExp(rule.key, caseSensitive: false), (match) => rule.value);
    } on ArgumentError {
      throw Exception(
          "Can't singularize this word, could not find a rule to match.");
    }
  }

  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();
}

List<String> get uncountable {
  return [
    "equipment",
    "information",
    "rice",
    "money",
    "species",
    "series",
    "fish",
    "sheep",
    "aircraft",
    "bison",
    "flounder",
    "pliers",
    "bream",
    "gallows",
    "proceedings",
    "breeches",
    "graffiti",
    "rabies",
    "britches",
    "headquarters",
    "salmon",
    "carp",
    "herpes",
    "scissors",
    "chassis",
    "high-jinks",
    "sea-bass",
    "clippers",
    "homework",
    "cod",
    "innings",
    "shears",
    "contretemps",
    "jackanapes",
    "corps",
    "mackerel",
    "swine",
    "debris",
    "measles",
    "trout",
    "diabetes",
    "mews",
    "tuna",
    "djinn",
    "mumps",
    "whiting",
    "eland",
    "news",
    "wildebeest",
    "elk",
    "pincers",
    "sugar"
  ];
}

List<MapEntry<String, String>> get exceptions {
  return [
    const MapEntry("person", "people"),
    const MapEntry("man", "men"),
    const MapEntry("goose", "geese"),
    const MapEntry("child", "children"),
    const MapEntry("sex", "sexes"),
    const MapEntry("move", "moves"),
    const MapEntry("stadium", "stadiums"),
    const MapEntry("deer", "deer"),
    const MapEntry("codex", "codices"),
    const MapEntry("murex", "murices"),
    const MapEntry("silex", "silices"),
    const MapEntry("radix", "radices"),
    const MapEntry("helix", "helices"),
    const MapEntry("alumna", "alumnae"),
    const MapEntry("alga", "algae"),
    const MapEntry("vertebra", "vertebrae"),
    const MapEntry("persona", "personae"),
    const MapEntry("stamen", "stamina"),
    const MapEntry("foramen", "foramina"),
    const MapEntry("lumen", "lumina"),
    const MapEntry("afreet", "afreeti"),
    const MapEntry("afrit", "afriti"),
    const MapEntry("efreet", "efreeti"),
    const MapEntry("cherub", "cherubim"),
    const MapEntry("goy", "goyim"),
    const MapEntry("human", "humans"),
    const MapEntry("lumen", "lumina"),
    const MapEntry("seraph", "seraphim"),
    const MapEntry("Alabaman", "Alabamans"),
    const MapEntry("Bahaman", "Bahamans"),
    const MapEntry("Burman", "Burmans"),
    const MapEntry("German", "Germans"),
    const MapEntry("Hiroshiman", "Hiroshimans"),
    const MapEntry("Liman", "Limans"),
    const MapEntry("Nakayaman", "Nakayamans"),
    const MapEntry("Oklahoman", "Oklahomans"),
    const MapEntry("Panaman", "Panamans"),
    const MapEntry("Selman", "Selmans"),
    const MapEntry("Sonaman", "Sonamans"),
    const MapEntry("Tacoman", "Tacomans"),
    const MapEntry("Yakiman", "Yakimans"),
    const MapEntry("Yokohaman", "Yokohamans"),
    const MapEntry("Yuman", "Yumans"),
    const MapEntry("criterion", "criteria"),
    const MapEntry("perihelion", "perihelia"),
    const MapEntry("aphelion", "aphelia"),
    const MapEntry("phenomenon", "phenomena"),
    const MapEntry("prolegomenon", "prolegomena"),
    const MapEntry("noumenon", "noumena"),
    const MapEntry("organon", "organa"),
    const MapEntry("asyndeton", "asyndeta"),
    const MapEntry("hyperbaton", "hyperbata"),
    const MapEntry("foot", "feet")
  ];
}

List<MapEntry<String, String>> get pluralizeRules {
  return [
    const MapEntry(r"$", "s"),
    const MapEntry(r"s$", "s"),
    const MapEntry(r"o$", "oes"),
    const MapEntry(r"(ax|test)is$", r"$1es"),
    const MapEntry(r"us$", "i"),
    const MapEntry(r"(octop|vir)us$", r"$1i"),
    const MapEntry(r"(octop|vir)i$", r"$1i"),
    const MapEntry(r"(alias|status)$", r"$1es"),
    const MapEntry(r"(bu)s$", r"$1ses"),
    const MapEntry(r"(buffal|tomat)o$", r"$1oes"),
    const MapEntry(r"([ti])um$", r"$1a"),
    const MapEntry(r"([ti])a$", r"$1a"),
    const MapEntry(r"sis$", "ses"),
    const MapEntry(r"(,:([^f])fe|([lr])f)$", r"$1$2ves"),
    const MapEntry(r"(hive)$", r"$1s"),
    const MapEntry(r"([^aeiouy]|qu)y$", r"$1ies"),
    const MapEntry(r"(x|ch|ss|sh)$", r"$1es"),
    const MapEntry(r"(matr|vert|ind)ix|ex$", r"$1ices"),
    const MapEntry(r"([m|l])ouse$", r"$1ice"),
    const MapEntry(r"([m|l])ice$", r"$1ice"),
    const MapEntry(r"^(ox)$", r"$1en"),
    const MapEntry(r"(quiz)$", r"$1zes"),
    const MapEntry(r"f$", "ves"),
    const MapEntry(r"fe$", "ves"),
    const MapEntry(r"um$", "a"),
    const MapEntry(r"on$", "a"),
    const MapEntry("tion", "tions"),
    const MapEntry("sion", "sions")
  ];
}

List<MapEntry<String, String>> get singularizeRules {
  return [
    const MapEntry(r"s$", ""),
    const MapEntry(r"(s|si|u)s$", r"$1s"),
    const MapEntry(r"(n)ews$", r"$1ews"),
    const MapEntry(r"([ti])a$", r"$1um"),
    const MapEntry(
        r"((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$",
        r"$1$2sis"),
    const MapEntry(r"(^analy)ses$", r"$1sis"),
    const MapEntry(r"(^analy)sis$", r"$1sis"),
    const MapEntry(r"([^f])ves$", r"$1fe"),
    const MapEntry(r"(hive)s$", r"$1"),
    const MapEntry(r"(tive)s$", r"$1"),
    const MapEntry(r"([lr])ves$", r"$1f"),
    const MapEntry(r"([^aeiouy]|qu)ies$", r"$1y"),
    const MapEntry(r"(s)eries$", r"$1eries"),
    const MapEntry(r"(m)ovies$", r"$1ovie"),
    const MapEntry(r"(x|ch|ss|sh)es$", r"$1"),
    const MapEntry(r"([m|l])ice$", r"$1ouse"),
    const MapEntry(r"(bus)es$", r"$1"),
    const MapEntry(r"(o)es$", r"$1"),
    const MapEntry(r"(shoe)s$", r"$1"),
    const MapEntry(r"(cris|ax|test)is$", r"$1is"),
    const MapEntry(r"(cris|ax|test)es$", r"$1is"),
    const MapEntry(r"(octop|vir)i$", r"$1us"),
    const MapEntry(r"(octop|vir)us$", r"$1us"),
    const MapEntry(r"(alias|status)es$", r"$1"),
    const MapEntry(r"(alias|status)$", r"$1"),
    const MapEntry(r"^(ox)en", r"$1"),
    const MapEntry(r"(vert|ind)ices$", r"$1ex"),
    const MapEntry(r"(matr)ices$", r"$1ix"),
    const MapEntry(r"(quiz)zes$", r"$1"),
    const MapEntry(r"a$", "um"),
    const MapEntry(r"i$", "us"),
    const MapEntry(r"ae$", "a")
  ];
}
