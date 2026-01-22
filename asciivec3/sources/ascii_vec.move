module asciivec3::asciivec3;

use ascii::ascii::is_ascii;
use std::string::String;

/// Check if all strings in a vector are ASCII.
public fun is_ascii_vec(strings: &vector<String>): bool {
    strings.all!(|s| is_ascii(s))
}
