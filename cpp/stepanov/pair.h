#ifndef PAIR_H
#define PAIR_H

template <typename T1, typename T2>
struct pair
{
	T1 first;
	T2 second;

	/* make it semi-regular */

	pair(const pair& x) : first(x.first), second(x.second) {}
	pair(T1 fst, T2 snd) : first(fst), second(snd) {} /* my addition */
	pair() {}
	~pair() {}

	pair& operator=(const pair &x)
	{
		first = x.first;
		second = x.second;
		return *this;
	}

	/* make it regular */

	friend
	bool operator==(const pair &x, const pair &y) {
		return x.first == y.first
		&& x.second == y.second;
	}

	friend
	bool operator!=(const pair &x, const pair &y) {
		return !(x == y);
	}

	/* make it totally ordered */
	friend
	bool operator<(const pair &x, const pair &y) {
		return x.first < y.first
		&& x.second < y.second;
	}

	friend
	bool operator>(const pair &x, const pair &y) {
		return (y < x);
	}

	friend
	bool operator<=(const pair &x, const pair &y) {
		return !(y < x);
	}

	friend
	bool operator>=(const pair &x, const pair &y) {
		return !(x < y);
	}

	/* my addition */
	#include <iostream>
	friend
	std::ostream& operator<<(std::ostream &os, const pair &x) {
		os << "(" << x.first << ", " << x.second << ")";
		return os;
	}
};

#endif
