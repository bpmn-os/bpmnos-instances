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
costs = []
n = 0

if startswith(name, "assignp")
  # Read instance data
  open(fullpath, "r") do input
    global n = parse(Int,readline(input))
    # Read all remaining lines, split them into numbers, and store as a list of triples
    global costs = [ [parse(Int, x) for x in split(line)] for line in readlines(input) ]
  end
  # Create lookup table
  open(name * "/costs.csv", "w") do output
    println(output, "ClientId,ServerId,Costs")
    for value in costs
      println(output, "Client$(value[1]),Server$(value[2]),$(value[3])")
    end
  end
else
  # Read instance data
  open(fullpath, "r") do input
    global n = parse(Int,readline(input))
    for i in 1:n
      push!(costs, [])
      while ( length(costs[i]) < n )
        costs[i]  = vcat( costs[i], [parse(Int, x) for x in split( readline(input) )] )
      end
    end
  end

  # Create lookup table
  open(name * "/costs.csv", "w") do output
    println(output, "ClientId,ServerId,Costs")
    for i in 1:n
      for j in 1:n
        println(output, "Client$(i),Server$(j),$(costs[i][j])")
      end 
    end
  end
end

# Create instance file
open(name * "/instance.csv", "w") do output
  println(output, "PROCESS_ID; INSTANCE_ID; ATTRIBUTE_ID; VALUE")
  for i in 1:n
    println(output, "ClientProcess;Client$(i);;")
  end 
  for j in 1:n
    println(output, "ServerProcess;Server$(j);;")
  end
end

