using DataFrames
"""
    npt_running_average(x_val, y_val, n = 5, x_name = "x", y_name = "y")
    
# Defines a running average function
#####################################################################################################
# Input:                                                                                            #
# x_val: x-values in the data-set which will be averaged.                                           #
# y_val: y-values in the data-set which will be averaged.                                           #
# n: Default 5. Defines how long the running average will be.                                       #
# x_name: Default "x". Defines the name of the x-value column in the output DataFrame.              #
# y_name: Default "y". Defines the name of the y-value column in the output DataFrame.              #
#                                                                                                   #
# Output:                                                                                           #
# df: DataFrame of the averaged y-values and respective x values with given or default column-names #
#####################################################################################################
"""
function npt_running_average(x_val, y_val, n = 5, x_name = "x", y_name = "y")
    y_temp = []                               # Defines a temporary y-value array where the averaged values will be inserted
    d = n ÷ 2                                 # Defines a variable "d" which is how many numbers in front or behind the current number which will be averaged
    
    x_fin = x_val[d+1:size(x_val)[1]-(d+1)]   # Defines the final selection of x-values which will be kept
    
    # Running the running average calculations:
    for (i, x) in enumerate(y_val)
        
        # Excludes itterations where the current number has insufficient neighbours to run calculations
        if (i ≤ d) | (i ≥ size(y_val)[1] - d)
            continue
            
        # Runs the calculation
        else
            npt = sum(y_val[i-d:i+d])/n
            push!(y_temp, npt)                # Stores the average in "y_temp"
        end
    end
    
    # Inserts the x- and y-values into df, DataFrame
    df = DataFrame(x = x_fin, y = y_temp)
    
    # Renames the columns
    rename!(df,:x => x_name)
    rename!(df,:y => y_name)
    
    # Returns the DataFrame
    return df
end