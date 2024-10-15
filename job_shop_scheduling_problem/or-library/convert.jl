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

# Read instances
open(fullpath, "r") do input
  line = ""
  while true
    # Get instance name
    while !startswith(line, "instance")
      line = strip( readline(input) )
      if occursin("EOF", line)
        exit()
      end
    end
    name = strip( split(line)[2] )
    
    # Skip 3 lines
    readline(input)
    readline(input)
    readline(input)
    # Get number of orders and machines
    line = strip( readline(input) )
    parts = split(line)
    orders = parse(Int, parts[1])
    machines = parse(Int, parts[2])
    jobs = [0 for _ in 1:machines]

    # Get machine requests and durations
    requests = []
    for o in 1:orders
      line = strip( readline(input) )
      parts = split(line)
      push!(requests, [] )
      for i in 1:2:length(parts)
        request = parse(Int, parts[i])+1 => parse(Float64, parts[i+1] )
        push!(requests[o], request )
        jobs[ request.first ] += 1
      end
    end

    # Create directory for instance
    if ( !isdir(name) )
      mkpath(name)
    end

    # Create instance file
    open(name * "/instance.csv", "w") do output
      println(output, "PROCESS_ID; INSTANCE_ID; ATTRIBUTE_ID; VALUE")
      for m in 1:machines
        println(output, "MachineProcess;Machine$(m);Jobs;$(jobs[m])")
      end
      for o in 1:orders
        print(output, "OrderProcess;Order$(o);Machines;[")
        for request in requests[o]
          if request != requests[o][1]
            print(output, ",")
          end
          print(output, "\"Machine$(request.first)\"")
        end
        println(output, "]")

        print(output, "OrderProcess;Order$(o);Durations;[")
        for request in requests[o]
          if request != requests[o][1]
            print(output, ",")
          end
          print(output, "$(request.second)")
        end
        println(output, "]")
      end
    end
  end
end
