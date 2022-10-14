export npt_running_average
export sliding_window
"""
    npt_running_average(x::AbstractVector{X}, y::AbstractVector{T}; 
        n::Int = 5,
        ) where {X, T <: Real}
    
Calculates an `n`-point running average for vectors `x` (vector of any type) and 
`y` (numeric vector).

Returns a tuple containing the running average values.

```jldoctext
julia> x = [1,2,3,4]
julia> y = [5,6,7,8]
julia>npt_running_average(x, y; n = 3)
([2, 3], [7.0, 8.0])
julia> x = [1,2,3,4,5,6,7,8,9]
julia> y = [1,2,3,4,5,6,7,8,9]
julia> npt_running_average(x, y)
([3, 4, 5, 6, 7], [3.0, 4.0, 5.0, 6.0, 7.0])
```
"""
function npt_running_average(x::AbstractVector{X}, y::AbstractVector{T}; 
        n::Int = 5,
        ) where {X, T <: Real}

    # `d` is the number of neighbours around the point being averaged.
    d = n ÷ 2
    
    # Defines vector containing final values
    x_final = x[(d + 1):(length(x) - (d))]
    y_final = Float64[] 

    for (i, x) in enumerate(y)
        # Excludes iterations where the current number has insufficient neighbours.
        if (i ≤ d) | (i > length(y) - d)
            continue
        else 
            npt = sum(y[(i - d):(i + d)]) / n
            push!(y_final, npt)
        end
    end
    
    return (x_final, y_final)
end

"""
    sliding_window(x::AbstractVector{X}, y::AbstractVector{Y};
        f::Function, 
        width::Int, 
        step::Int
        ) where {X, Y <: Real}

Calculates the function `f::Function` for input-vectors `x::AbstractVector` and 
`y::AbstractVector` in a "sliding window" of constant `width::Int` and 
jumps with `step::Int`.

Returns two vectors containing the calculated values.

# Examples

```jldoctest
julia> using Heine, Statistics
julia> sliding_window([1,2,3,4,5,6], [1,3,4,5,7,8], f = mean, width = 3, step = 3)
([2, 5], [2.6666666666666665, 6.666666666666667])
julia> sliding_window([1,2,3,4,5,6], [1,3,4,5,7,8], f = median, width = 3, step = 3)
([2, 5], [3.0, 7.0])
```

"""
function sliding_window(x::AbstractVector{X}, y::AbstractVector{Y};
        f::Function, 
        width::Int, 
        step::Int
        ) where {X, Y <: Real}
    
    return [x[i + width ÷ 2] for i in 1:step:length(x) - width + 1], 
        [f(window) for window in ((@view y[i:i + width - 1]) for
        i in 1:step:length(y) - width + 1)]
end