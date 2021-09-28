## Elevator Control Optimisation using Automated Planning

### About
A planning domain for the elevators of educational institutions implemented with PDDL. Using this domain a planner can find an efficient plan for the elevators to serve all the passengers with the minimum electrical power consumption. It also provides a new feature that offers nonstop travel to special users.

#### Actions:
`up-slow` Moves a slow elevator upwards. <br>
`down-slow` Moves a slow elevator downwards. <br>
`up-fast` Moves a fast elevator upwards. <br>
`down-down` Moves a fast elevator downwards. <br>
`load-teacher` Loads a teacher into an elevator. <br>
`unload-teacher` Unloads a teacher from an elevator. <br>
`load-special` Loads a special person into an elevator. <br>
`unload-special` Unloads a special person from an elevator. <br>
`load-general` Loads a general person into an elevator. <br>
`unload-general` Unloads a general person from an elevator. 

#### Predicates:
`(origin ?person - passenger ?floor - count)` Returns true if the origin of the `?person` is `?floor`.  <br>
`(dest ?person - passenger ?floor - count)` Returns true if the destination of the `?person` is `?floor`. <br>
`(boarded ?person - passenger ?lift - elevator)` Returns true if the `?person` has boarded the `?lift`. <br>
`(served ?person - passenger)` Returns true if the `?person` has been served by the elevator. <br>
`(is-special ?person - passenger)` Returns true the `?person` is special. <br>
`(lift-at ?lift - elevator ?floor - count)` Returns true if the `?lift` is currently located at `?floor`. <br>
`(reachable-floor ?lift - elevator ?floor - count)` Returns true if the `?lift`  stops at `?floor`. <br>
`(is-restricted ?lift - elevator)` Returns true if the `?lift` is only allocated for the teachers. <br>
`(contains-special ?lift - elevator)` Returns true if the `?lift` activates nonstop travel mode. <br>
`(passengers ?lift - elevator ?n - count)` Returns true if the number of passengers in the `?lift` is `?n`. <br>
`(can-hold ?lift - elevator ?n - count)` Returns true if the capacity of the `?lift` is `?n`. <br>
`(above ?floor1 - count ?floor2 - count)`Returns true if `?floor2` lies above the `?floor1`. <br>
`(next ?n1 - count ?n2 - count)` Returns true if `?n2` is the immediate next number of `?n1`.
 
### Problem 1
A building with 6 floors has 2 fast (accelerating) elevators that stop at all the floors. Furthermore, there are 2 slow elevators. One slow elevator stops only at the even floors and the other one stops only at the odd floors. Each elevator has a capacity of 5 persons. One fast elevator is allocated only for the teachers and the other elevators are allocated for the general users. The fast elevator that is allocated for the general users has a special feature that offers a passenger a nonstop trip to his destination. The cost associated with fast elevators is higher than slow elevators. Our planning problem is to find a plan that moves the elevators to passengers' destinations and minimizes total cost.

### Problem 2
A building with 9 floors has 2 fast (accelerating) elevators that stop at all the floors. Furthermore, there are 2 slow elevators. One slow elevator stops only at the even floors and the other one stops only at the odd floors. Each elevator has a capacity of 10 persons. One fast elevator is allocated only for the teachers and the other elevators are allocated for the general users. The fast elevator that is allocated for the general users has a special feature that offers a passenger a nonstop trip to his destination. The cost associated with fast elevators is higher than slow elevators. Our planning problem is to find a plan that moves the elevators to passengers' destinations and minimizes total cost.

### How to set up Fast-Downward Planner
##### Install Dependencies
> To obtain and build the planner, you will need the Git version control system, a C++11 compiler, CMake and GNU make. To run the planner, you will also need Python (>= 3.6) installed on your machine.
```
sudo apt install cmake g++ git make python3
```
##### Obtaining the code
```
git clone https://github.com/aibasel/downward.git downward
```

##### Compiling the planner
```
cd downward
./build.py
```
> This will create our default build release in the directory downward/builds. 

### Usage of Fast-Downward Planner
> To run Fast Downward, use the fast-downward.py driver script. At minimum, you need to specify the PDDL input files and search options. The driver script has many options to do things like running portfolios, running only the translation component of the planner, using a non-standard build, running a plan validator and various other things. To see the complete list of options, run
```
./fast-downward.py --help
```
#### Running the planner
>The search component of the planner accepts a host of different options with widely differing behaviour. At the very least, you will want to choose a search engine with one or more evaluator specifications.

##### A* Best First search
```
# landmark-cut heuristic
 ./fast-downward.py domain.pddl task.pddl --search "astar(lmcut())"

# iPDB heuristic with default settings
 ./fast-downward.py domain.pddl task.pddl --search "astar(ipdb())"

# blind heuristic
 ./fast-downward.py domain.pddl task.pddl --search "astar(blind())"
```
##### Greedy Best First search
```
# using FF heuristic and context-enhanced additive heuristic (previously: "fFyY")
 ./fast-downward.py domain.pddl task.pddl 
    --evaluator "hff=ff()" --evaluator "hcea=cea()" 
    --search "lazy_greedy([hff, hcea], preferred=[hff, hcea])" 
           

# using FF heuristic (previously: "fF")
 ./fast-downward.py domain.pddl task.pddl 
    --evaluator "hff=ff()" 
    --search "lazy_greedy([hff], preferred=[hff])" 
           

# using context-enhanced additive heuristic (previously: "yY")
 ./fast-downward.py domain.pddl task.pddl 
    --evaluator "hcea=cea()" 
    --search "lazy_greedy([hcea], preferred=[hcea])" 
```
##### Lama
```
./fast-downward.py --alias seq-sat-lama-2011 domain.pddl task.pddl
```
##### Exit Codes
> The driver exits with 0 if no errors are encountered. Otherwise, it returns the exit code of the first component that failed.

### Usage of Cloud Based Planner
`editor.planning.domains` is a fully featured PDDL editor. The functionality is continually changing, but currently it boasts features such as syntax highlighting, code folding, PDDL-specific auto-completion, multi-tab support, etc. Other less obvious features include:
Double-click on a tab to rename the file.
- `Ctrl+s` will save the file locally.
- `Ctrl+i` will open the import dialog.
- `Ctrl+Alt++` will open a new editor tab.
- `Ctrl+Alt+-` will close the current tab.

The major functionality, found in the toolbar at the top of the page, is as follows:

##### File:	
- (New) Create a new tab.
- (Close) Close the current tab.
- (Save) Saves the current tab locally.
- (Load) Loads a locally stored file.

##### Session:
- (Save) Save the current session remotely.
- (Load) Load a remotely stored session (either read or read/write).
- (Details) Displays details on the current session.
- (Offline) Open offline in VS Code

##### Import:
Allows you to browse api.planning.domains to find an existing domain or problem PDDL file to start working from.

##### Plugins:
Allows you to load a custom plugin given its URL. "Save Plugins" will create a meta plugin that saves the plugin state of the editor. 
