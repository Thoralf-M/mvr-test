#[test_only]
module asciivec3::asciivec3_tests;

use asciivec3::asciivec3::is_ascii_vec;
use std::string::String;

#[test]
fun test_is_ascii_vec_all_ascii() {
    let strings = vector[
        b"Hello".to_string(),
        b"World".to_string(),
        b"Test123".to_string(),
    ];
    assert!(is_ascii_vec(&strings), 0);
}

#[test]
fun test_is_ascii_vec_empty() {
    let strings: vector<String> = vector[];
    assert!(is_ascii_vec(&strings), 0);
}

#[test]
fun test_is_ascii_vec_with_non_ascii() {
    let strings = vector[
        b"Hello".to_string(),
        b"\x01\x02".to_string(),  // control characters (non-printable ASCII)
    ];
    // This should return false since control chars < 32 are not in range 32-127
    assert!(!is_ascii_vec(&strings), 0);
}
