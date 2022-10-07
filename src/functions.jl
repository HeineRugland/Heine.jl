using DataFrames
export npt_running_average
"""
    npt_running_average(x, y, n = 5, x_name = "x", y_name = "y")
    
Calculates an `n`-point running average for vectors `x` and `y`.

Returns a two-column DataFrame containing the running average values. `x_name` and `y_name` 
are the names for each column.
"""
function npt_running_average(x::AbstractVector{X}, y::AbstractVector{T}; 
        n::Int = 5; 
        x_name::AbstractString = "x"; 
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