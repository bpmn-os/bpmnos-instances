> Source: http://people.brunel.ac.uk/~mastjjb/jeb/orlib/binpackinfo.html

# OR-Library

## [J E Beasley](http://people.brunel.ac.uk/~mastjjb/jeb/jeb.html)

OR-Library is a collection of test data sets for a variety of OR problems.

A full list of the test data sets available in OR-Library can be found [here](http://people.brunel.ac.uk/~mastjjb/jeb/info.html).

- - -

## Bin packing - one-dimensional

There are currently 8 data files.

These files contain the instances of the bin packing problem considered in
E.Falkenauer (1994) "A Hybrid Grouping Genetic Algorithm for Bin Packing"
Working paper CRIF Industrial Management and Automation, CP 106 - P4, 50
av. F.D.Roosevelt, B-1050 Brussels, Belgium, email: efalkena@ulb.ac.be.

These data files are `binpack1`, `binpack2`, ..., `binpack8` and were
contributed by E. Falkenauer.

The format of these data files is as follows:
```
Number of test problems (P)
For each test problem (p=1,...,P) in turn:
   Problem identifier
   Bin capacity, Number of items (n), Number of bins in the current
                                      best known solution
   For each item i (i=1,...,n): size of the item
```
There are 2 classes of bin packing instances. The first class, files
`binpack1` to `binpack4` (problem identifiers beginning with 'u') consists of
items of sizes uniformly distributed in (20,100) to be packed into bins of
size 150.

The second class, files `binpack5` to `binpack8` (problem identifiers beginning
with 't') consists of 'triplets' of items from (25,50) to be packed into
bins of size 100.

For the 'uniform' class, the value for "Number of bins in the current best
known solution" is the one found by algorithm in the above-referenced
paper. Except for problems `u120_08`, `u120_19`, `u250_07`, `u250_12` and `u250_13`,
this is also the smallest number of bins capable of accommodating all the
items, so the value is the proven optimum.

For the 'triplets' class, the instances were constructed with a known
global optimum of n/3 bins, i.e. the guaranteed optimal solution has
exactly three items per bin.

Acknowledgement: Although the procedure of generating 'triplets' of a known
optimum is due to Falkenauer, Andre van Vliet from the Econometric
Institute, Erasmus University Rotterdam, has first suggested the idea of
instances of that nature.

The largest file is `binpack4` of size 60Kb (approximately).
The entire set of files is of size 200Kb (approximately).

Click [here](http://people.brunel.ac.uk/~mastjjb/jeb/orlib/files) to access these files

OTHER SOURCES

Other bin packing test problems can be found [here](https://www2.wiwi.uni-jena.de/Entscheidung/binpp/index.htm) see also [here](http://paginas.fe.up.pt/~esicup/tiki-index.php?page_ref_id=1)
