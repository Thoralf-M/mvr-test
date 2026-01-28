module ascii_vec::ascii_vec;

use ascii::ascii::is_ascii;
use std::string::String;

/// Check if all strings in a vector are ASCII.
public fun is_ascii_vec(strings: &vector<String>): bool {
    strings.all!(|s| is_ascii(s))
}

/// Check if all bytes in a vector are ASCII.
public fun is_ascii_byte_vec(bytes: &vector<vector<u8>>): bool {
    let len = bytes.length();
    let mut i = 0;
    while (i < len) {
        let b = &bytes[i];
        let blen = b.length();
        let mut j = 0;
        while (j < blen) {
            if (!(b[j] >= 32 && b[j] <= 126)) return false;
            j = j + 1;
        };
        i = i + 1;
    };
    true
}
