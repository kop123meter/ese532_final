#include <iostream>
#include <string>

class RollingHash {
private:
	const unsigned long long base = 3; //256
	const unsigned long long mod = 256; //10^9 + 7
	unsigned long long hash = 0;
	unsigned long long highest_base = 1;
	std::string text;
	int window_size;
	int window_start = 0;

public:
	RollingHash(const std::string& text, int size) : text(text), window_size(size) {
    	// Compute the initial hash value
    	for (int i = 0; i < window_size; ++i) {
        	hash = (hash * base + text[i]) % mod;
    	}

    	// Compute the highest power of base used.
    	for (int i = 1; i < window_size; ++i) {
        	highest_base = (highest_base * base) % mod;
    	}
	}

	void move_window() {
    	if (window_start + window_size < text.length()) {
        	// Remove the leftmost character value from the hash
        	hash = (hash + mod - (text[window_start] * highest_base) % mod) % mod;
       	 
        	// Move the window
        	window_start++;

        	// Add the new character value to the hash
        	hash = (hash * base + text[window_start + window_size - 1]) % mod;
    	}
	}

	unsigned long long get_hash() const {
    	return hash;
	}
};
