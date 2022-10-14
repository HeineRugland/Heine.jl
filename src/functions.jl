using DataFrames
export npt_running_average
export sliding_window
"""
    npt_running_average(x, y; n = 5, x_name = "x", y_name = "y")
    
Calculates an `n`-point running average for vectors `x` (vector of any type) and 
`y` (numeric vector).

Returns a two-column `DataFrame` containing the running average values. `x_name` and `y_name` 
are the names for each column.
"""
function npt_running_average(x::AbstractVector{X}, y::AbstractVector{T}; 
        n::Int = 5, 
        x_name::AbstractString = "x", 
        y_name::AbstractString = "y"
        ) where {X, T <: Real}

    # `d` is the number of neighbours around the point being averaged.
    d = n ÷ 2
    
    # Defines vector containing final values
    x_final = x[(d + 1):(length(x) - (d + 1))]
    y_final = Float64[] 

    for (i, x) in enumerate(y)
        # Excludes iterations where the current number has insufficient neighbours.
        if (i ≤ d) | (i ≥ lenght(y) - d)
            continue
        else 
            npt = sum(y[(i - d):(i + d)]) / n
            push!(y_final, npt)
        end
    end
    
    df = DataFrame(x = x_final, y = y_final)
    rename!(df,:x => x_name)
    rename!(df,:y => y_name)
    
    return df
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