#ifndef SINGLETON_H
#define SINGLETON_H

template <typename T>
struct singleton
{
	T value;

	/* make it semi-regular */

	singleton(const singleton& x) : value(x.value) {}
	singleton(T v) : value(v) {} /* my addition */
	singleton() {}
	~singleton() {}

	singleton& operator=(const singleton &x)
	{
		value = x.value;
		return *this;
	}

	/* make it regular */

	friend
	bool operator==(const singleton &x, const singleton &y) {
		return x.value == y.value;
	}

	friend
	bool operator!=(const singleton &x, const singleton &y) {
		return !(x == y);
	}

	/* make it totally ordered */
	friend
	bool operator<(const singleton &x, const singleton &y) {
		return x.value < y.value;
	}

	friend
	bool operator>(const singleton &x, const singleton &y) {
		return (y < x);
	}

	friend
	bool operator<=(const singleton &x, const singleton &y) {
		return !(y < x);
	}

	friend
	bool operator>=(const singleton &x, const singleton &y) {
		return !(x < y);
	}

	/* my addition */
	#include <iostream>
	friend
	std::ostream& operator<<(std::ostream &os, const singleton &x) {
		os << x.value;
		return os;
	}
};

#endif
