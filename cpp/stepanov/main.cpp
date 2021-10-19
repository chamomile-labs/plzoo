#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
/* rand(), srand(), time() */
#include <cstdlib>
#include <ctime>
#include <cstring> /* memset */

#include "singleton.h"
#include "pair.h"
#include "instrumented.h"

using std::endl;
using std::cout;
using std::string;
using std::vector;
using std::sort;

void singleton_test()
{
	cout << "---SINGLETON TEST---" << endl;
	singleton<int> s1(5);
	singleton<int> s2(10);
	singleton<int> s3(10);

	cout << "S1: " << s1 << endl;
	cout << "S2: " << s2 << endl;
	cout << "S3: " << s3 << endl;
	cout << "---" << endl;

	printf("S1 == S2: %d\n", s1 == s2);
	printf("S1 < S2: %d\n", s1 < s2);
	printf("S1 > S2: %d\n", s1 > s2);
	printf("S1 <= S2: %d\n", s1 <= s2);
	printf("S1 >= S2: %d\n", s1 >= s2);


	printf("S2 == S3: %d\n", s2 == s3);
}

void pair_test()
{
	cout << "--- PAIR TEST ---" << endl;
	pair<string, int> p1("Josh", 69);
	cout << "P1: " << p1 << endl;
	pair<string, int> p2("Kadin", 96);
	cout << "P2: " << p2 << endl;
	pair<string, int> p3("Kadin", 96);
	cout << "P3: " << p3 << endl;

	cout << "P1 == P2: " << (p1 == p2) << endl;
	cout << "P1 < P2: " << (p1 < p2) << endl;
	cout << "P1 > P2: " << (p1 > p2) << endl;
	cout << "P1 <= P2: " << (p1 <= p2) << endl;
	cout << "P1 >= P2: " << (p1 >= p2) << endl;

	cout << "P2 == P3: " << (p2 == p3) << endl;

}

template <typename T>
void bubblesort(vector<T> &items)
{
	for(int i = 0; i < items.size(); i++)
		for(int j = i; j < items.size(); j++)
			if(items[i] > items[j])
			{
				T temp = items[i];
				items[i] = items[j];
				items[j] = temp;
			}
}

#define STD_SORT 1
#define BUBBLE_SORT 2
#define STD_STABLE_SORT 3

template <typename T>
/* not passing in sort as func pointer cause different prototypes */
void instrumented_sort_test(vector<T> items, int sort_type)
{
	/* print sort type */
	switch(sort_type)
	{
		case STD_SORT:
			cout << "\t -- std::sort test --\n";
			std::sort(items.begin(), items.end());
			break;
		case BUBBLE_SORT:
			cout << "\n\t -- bubblesort test --\n";
			bubblesort(items);
			break;
		case STD_STABLE_SORT:
			cout << "\n\t -- std::stable_sort test --\n";
			std::stable_sort(items.begin(), items.end());
	}


	/* print out stats */
	int total_ops = 0;
	for(int i = 0; i < opcounts::NUM_COUNTS; i++)
	{
		cout << opcounts::op_type_str[i] << ": "
		     << opcounts::counts[i] << endl;

		total_ops += opcounts::counts[i];
	}
	cout << "Total ops: " << total_ops << endl;

	/* reset stats */
	memset(opcounts::counts, 0, sizeof opcounts::counts);
}

void instrumented_test()
{
	srand(time(NULL));

	cout << "--- INSTRUMENTED TEST ---" << endl;

	int N = 1000;
	cout << "N: " << N << endl;
	vector< instrumented<int> > nums;
	for(int i = 0; i < N; i++)
	{
		instrumented<int> inst;
		inst.value = rand() % 1000;
		nums.push_back(inst);
	}

	/* reset stats */
	memset(opcounts::counts, 0, sizeof opcounts::counts);

	instrumented_sort_test(nums, STD_SORT);
	instrumented_sort_test(nums, BUBBLE_SORT);
	instrumented_sort_test(nums, STD_STABLE_SORT);
}

int main()
{
	//singleton_test();
	//pair_test();
	instrumented_test();
}
