package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"strings"
)

const baseURL = "https://adventofcode.com/2025/day/1/input"

type Solution struct {
	HTTPClient *http.Client
	Session    string
	Input      string
	Password   int
}

func NewSolution(session string) *Solution {
	return &Solution{
		HTTPClient: http.DefaultClient,
		Session:    session,
	}
}

func (s *Solution) GetInput() error {
	req, err := http.NewRequest(http.MethodGet, baseURL, nil)
	if err != nil {
		return err
	}
	req.AddCookie(&http.Cookie{Name: "session", Value: s.Session})
	resp, err := s.HTTPClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}
	s.Input = string(body)
	return nil
}

func mod100(x int) int {
	m := x % 100
	if m < 0 {
		m += 100
	}
	return m
}

func (s *Solution) GetFirstSolution() {
	current := 50
	total := 0
	for line := range strings.SplitSeq(strings.TrimSpace(s.Input), "\n") {
		if line == "" {
			continue
		}
		goLeft := line[0] == 'L'
		steps, _ := strconv.Atoi(line[1:])
		if goLeft {
			current = mod100(current - steps)
		} else {
			current = mod100(current + steps)
		}
		if current == 0 {
			total++
		}
	}
	s.Password = total
}

func (s *Solution) GetSecondSolution() {
	current := 50
	total := 0
	for line := range strings.SplitSeq(strings.TrimSpace(s.Input), "\n") {
		if line == "" {
			continue
		}
		goLeft := line[0] == 'L'
		steps, _ := strconv.Atoi(line[1:])
		for k := 1; k <= steps; k++ {
			var pos int
			if goLeft {
				pos = mod100(current - k)
			} else {
				pos = mod100(current + k)
			}
			if pos == 0 {
				total++
			}
		}
		if goLeft {
			current = mod100(current - steps)
		} else {
			current = mod100(current + steps)
		}
	}
	s.Password = total
}

func main() {
	session := os.Getenv("AOC_SESSION")
	if session == "" {
		fmt.Fprintln(os.Stderr, "set AOC_SESSION to your adventofcode.com session cookie value")
		os.Exit(1)
	}
	solution := NewSolution(session)
	if err := solution.GetInput(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	// solution.GetFirstSolution()
	// fmt.Println(solution.Password)
	solution.GetSecondSolution()
	fmt.Println(solution.Password)
}
