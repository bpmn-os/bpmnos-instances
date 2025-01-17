# Instances

This folder contains instance for selected optimisation problems modelled as business processes.

For each optimisation problem, a BPMNOS model and one or more folders containing relevant instance data is provided. Each of these folders contains:

- a `source` folder containing the original source of the instances,
- a script to convert the original instances into BPMNOS data format, and
- an `instances` folder containing the instance data in BPMNOS data format.

## Build instances

A single instance can be build by
```
cd <outputdir>
julia <scriptname> <source>
```

All instances of a source collection can be build by
```
cd <outputdir>
for input in <sourcepattern>; do
  julia <scriptname> $input
done
```


## License

- Content in each `source` folder is subject to the license conditions of the original source.
- All other content is under MIT license.
