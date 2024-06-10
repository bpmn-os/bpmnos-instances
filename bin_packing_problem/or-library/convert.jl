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

# Initialize variables
m = 0

println("Instance, Solution")

# Read instance data
open(fullpath, "r") do input
  # Get number of instances
  global m = parse(Int, readline(input))
  
  for k in 1:m
    # Get the instance name
    name = strip( readline(input) )
    # Create directory for instance
    if ( !isdir(name) )
      mkpath(name)
    end
    values = split( readline(input) )
    capacity = parse(Float64, values[1])
    n = parse(Int, values[2])
    solution = parse(Int, values[3])
    println("$name, $solution")
    sizes = []
    for i in 1:n
      push!(sizes, parse(Float64, readline(input) ) )
    end

    # Create instance file
    open(name * "/instance.csv", "w") do output
      println(output, "PROCESS_ID; INSTANCE_ID; ATTRIBUTE_ID; VALUE")
      println(output, ";;Bins;$(n)")
      println(output, ";;Items;$(n)")
      for i in 1:n
        println(output, "BinProcess;Bin$(i);Capacity;$(capacity)")
      end
      for i in 1:n
        println(output, "ItemProcess;Item$(i);Size;$(sizes[i])")
      end
    end
  end
end
