using Statistics

x = [1,2,3,4]
y = [5,6,7,8]

@test sliding_window(x, y; f = mean, width = 2, step = 2) == ([2, 4], [5.5, 7.5])

x = [1,2,3,4,5,6,7,8,9]
y = [1,2,3,4,5,6,7,8,9]
expected_x = [2,3,4,5,6,7,8]
expected_y = [2,3,4,5,6,7,8]
@test sliding_window(x, y; f = mean, width = 3, step = 1) == (expected_x, expected_y)

x = [1,2,3,4]
y = [5,6,7,8]

@test npt_running_average(x, y; n = 3) == ([2, 3], [7.0, 8.0])

x = [1,2,3,4,5,6,7,8,9]
y = [1,2,3,4,5,6,7,8,9]

@test npt_running_average(x, y) == ([3, 4, 5, 6, 7], [3.0, 4.0, 5.0, 6.0, 7.0])