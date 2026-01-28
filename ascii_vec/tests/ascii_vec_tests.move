#[test_only]
module ascii_vec::ascii_vec_tests;

use ascii_vec::ascii_vec::{is_ascii_vec, is_ascii_byte_vec};
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

#[test]
fun test_is_ascii_byte_vec_all_ascii() {
    let bytes = vector[
        b"Hello",
        b"World",
        b"Test123",
    ];
    assert!(is_ascii_byte_vec(&bytes), 0);
}

#[test]
fun test_is_ascii_byte_vec_empty() {
    let bytes: vector<vector<u8>> = vector[];
    assert!(is_ascii_byte_vec(&bytes), 0);
}

#[test]
fun test_is_ascii_byte_vec_with_non_ascii() {
    let bytes = vector[
        b"Hello",
        b"\x01\x02",  // control characters (non-printable ASCII)
    ];
    // This should return false since control chars < 32 are not in range 32-126
    assert!(!is_ascii_byte_vec(&bytes), 0);
}
