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

name = ""
n = 0
distances = []

# Open the file
open(fullpath, "r") do input
  # Get instance name and number of locations
  while (line = strip( readline(input) ) ) != "EDGE_WEIGHT_SECTION"
    # Get the instance name
    if ':' in line
      parts = [ strip(s) for s in split( line, ":" ) ]
      if parts[1] == "NAME"
        global name = parts[2]
      elseif parts[1] == "DIMENSION"
        global n = parse(Int,parts[2])
      elseif parts[1] == "EDGE_WEIGHT_TYPE" && parts[2] != "EXPLICIT"
        println("Instance $name has unsupported edge weight type")
        exit()
      elseif parts[1] == "EDGE_WEIGHT_FORMAT" && parts[2] != "FULL_MATRIX"
        println("Instance $name has unsupported edge weight format")
        exit()
      end
    end
  end
 
  # Read all distances
  while ( length(distances) < n * n )
    global distances  = vcat( distances, [parse(Float64, x) for x in split( readline(input) )] )
  end
end

# Create directory for instance
if ( !isdir(name) )
  mkpath(name)
end

# Create lookup table
open(name * "/distances.csv", "w") do output
  println(output, "From,To,Distance")
  for i in 1:n
    for j in 1:n
      if i != j
        println(output, "Location$(i),Location$(j),$(distances[(i-1)*n+j])")
      end
    end 
  end
end

# Create instance file
open(name * "/instance.csv", "w") do output
  println(output, "PROCESS_ID; INSTANCE_ID; ATTRIBUTE_ID; VALUE")
  println(output, "TravellingSalesperson_Process;Instance1;Origin;Location1")
  print(output, "TravellingSalesperson_Process;Instance1;Locations;[")
  for i in 2:n
    if i > 2
      print(output, ", ")
    end
    print(output, "\"Location$(i)\"")
  end
  println(output, "]")
end

