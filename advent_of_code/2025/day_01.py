import browser_cookie3
import requests

class Solution:
    BASE_URL = 'https://adventofcode.com/2025/day/1/input'

    def __init__(self, session_cookie):
        self._session_cookie = session_cookie

    def get_input(self):
        response = requests.get(self.BASE_URL, cookies=self._session_cookie)
        self._input = response.text

    def get_first_solution(self):
        current_position = 50
        total_zeroes = 0
        for instruction in self._input.strip().split("\n"):
            go_left = instruction[0] == "L"
            steps = int(instruction[1:])

            if go_left:
                current_position = (current_position - steps) % 100
            else:
                current_position = (current_position + steps) % 100
            
            if current_position == 0:
                total_zeroes += 1
        
        self.password = total_zeroes

    def get_second_solution(self):
        current_position = 50
        total_zeroes = 0
        for instruction in self._input.strip().split("\n"):
            go_left = instruction[0] == "L"
            steps = int(instruction[1:])

            for k in range(1, steps + 1):
                if go_left:
                    pos = (current_position - k) % 100
                else:
                    pos = (current_position + k) % 100
                if pos == 0:
                    total_zeroes += 1

            if go_left:
                current_position = (current_position - steps) % 100
            else:
                current_position = (current_position + steps) % 100

        self.password = total_zeroes

if __name__ == "__main__":
    # Grab cookies for the domain
    cj = browser_cookie3.chrome(domain_name="adventofcode.com")

    solution = Solution(cj)
    solution.get_input()
    # solution.get_first_solution()
    # print(solution.password)
    solution.get_second_solution()
    print(solution.password)
