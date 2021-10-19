#ifndef instrumented_H
#define instrumented_H

namespace opcounts
{
enum op_type {
	copy,
	default_constructor,
	assignment,
	equality,
	comparison,
	NUM_COUNTS /* make sure this is always last */
};

const char *op_type_str[] = {"copy", "default_constructor", "assignment",
	"equality", "comparison"};

int counts[NUM_COUNTS] = {0};
}

using namespace opcounts;

template <typename T>
struct instrumented
{
	T value;

	/* make it semi-regular */

	instrumented(const instrumented& x) : value(x.value) {
		counts[copy]++;
	}
	instrumented() {
		counts[default_constructor]++;
	}
	~instrumented() {}

	instrumented& operator=(const instrumented &x)
	{
		counts[assignment]++;
		value = x.value;
		return *this;
	}

	/* make it regular */

	friend
	bool operator==(const instrumented &x, const instrumented &y) {
		counts[equality]++;
		return x.value == y.value;
	}

	friend
	bool operator!=(const instrumented &x, const instrumented &y) {
		return !(x == y);
	}

	/* make it totally ordered */
	friend
	bool operator<(const instrumented &x, const instrumented &y) {
		counts[comparison]++;
		return x.value < y.value;
	}

	friend
	bool operator>(const instrumented &x, const instrumented &y) {
		return (y < x);
	}

	friend
	bool operator<=(const instrumented &x, const instrumented &y) {
		return !(y < x);
	}

	friend
	bool operator>=(const instrumented &x, const instrumented &y) {
		return !(x < y);
	}

	/* my addition */
	#include <iostream>
	friend
	std::ostream& operator<<(std::ostream &os, const instrumented &x) {
		os << x.value;
		return os;
	}
};

#endif
