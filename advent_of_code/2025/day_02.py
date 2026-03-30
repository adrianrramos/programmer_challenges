import browser_cookie3
import requests

class Solution:
    BASE_URL = 'https://adventofcode.com/2025/day/2/input'

    def __init__(self, session_cookie):
        self._session_cookie = session_cookie

    def get_input(self):
        response = requests.get(self.BASE_URL, cookies=self._session_cookie)
        self._input = response.text.strip()

    def parse_ranges(self):
        self.ranges = []
        for range_str in self._input.split(','):
            start, end = map(int, range_str.split('-'))
            self.ranges.append((start, end))

    def is_invalid_id(self, num):
        s = str(num)
        length = len(s)
        if length % 2 != 0:
            return False
        half = length // 2
        return s[:half] == s[half:]

    def is_invalid_id_part2(self, num):
        s = str(num)
        length = len(s)
        
        # Try all possible sequence lengths from 1 to length//2
        for seq_len in range(1, length // 2 + 1):
            if length % seq_len != 0:
                continue
            
            # Get the potential repeating sequence
            sequence = s[:seq_len]
            
            # Check if the entire string is made of repetitions of this sequence
            repetitions = length // seq_len
            if sequence * repetitions == s:
                return True
        
        return False

    def get_first_solution(self):
        self.parse_ranges()
        total = 0
        for start, end in self.ranges:
            for num in range(start, end + 1):
                if self.is_invalid_id(num):
                    total += num
        self.password = total

    def get_second_solution(self):
        self.parse_ranges()
        total = 0
        for start, end in self.ranges:
            for num in range(start, end + 1):
                if self.is_invalid_id_part2(num):
                    total += num
        self.password = total

if __name__ == "__main__":
    cj = browser_cookie3.chrome(domain_name="adventofcode.com")

    solution = Solution(cj)
    solution.get_input()
    # solution.get_first_solution()
    # print(solution.password)
    solution.get_second_solution()
    print(solution.password)
