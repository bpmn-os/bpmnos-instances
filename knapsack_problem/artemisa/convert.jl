#!/usr/bin/env julia

# Check if the correct number of arguments is passed
if length(ARGS) != 1
  scriptname = basename(PROGRAM_FILE)
  println("Usage: julia $scriptname <file_name>")
  exit()
end

# Get the file path from the command line argument
fullpath = ARGS[1]
     
if ( !isfile(fullpath) )
  println("File $fullpath not found!")
  exit()
end

# Get the instance name
name = split( basename(fullpath), "." )[1]

# Create directory for instance
if ( !isdir(name) )
  mkpath(name)
end

# Initialize variables
capacity = 0
n = 0
items = []
# Read instance data
open(fullpath, "r") do input
  header = split( readline(input) )
  global n = parse(Int, header[1])
  global capacity = parse(Float64, header[2])
  for i in 1:n
    value, weight = [parse(Float64, x) for x in split( readline(input) )]
    push!(items, [value, weight])
  end
end

# Create instance file
open(name * "/instance.csv", "w") do output
  println(output, "PROCESS_ID; INSTANCE_ID; ATTRIBUTE_ID; VALUE")
  println(output, "KnapsackProcess;Knapsack1;Items;$(n)")
  println(output, "KnapsackProcess;Knapsack1;Capacity;$(capacity)")
  for i in 1:n
    println(output, "ItemProcess;Item$(i);Value;$(items[i][1])")
    println(output, "ItemProcess;Item$(i);Weight;$(items[i][2])")
  end
end

