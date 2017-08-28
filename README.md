# Maya Archaeology
## Overview
Welcome to the Maya Archaeology project!  This is a project under UC San Diego's Engineers for Exploration research program.
Our goal is to develop a portable and accessible system for archaeologists to document excavations quickly and accurately by generating 3D computer models of them.  Currently we are experimenting with using mobile remote sensing technologies and different reconstruction algorithms, and testing with archaeologists studying ancient Maya temples in Guatemala.

## Background
//how archaeology is like in Maya temples in Guatemala

## Goals
Ideally this system would be:
1. Accurate
2. Portable
3. Gets real-time results
4. Affordable
5. Simple to use
6. Quick

The systems that we are using currently give us point clouds (set of 3d points), but eventually we will want to generate meshes from these (connecting these 3d points with faces) so that they can be easily viewed and worked with (especially for 3d printing/VR).

## Past work

### LIDAR

In previous years we have used a FARO LIDAR to get point clouds of Maya temples.  This generates a `.ptx` file which may be converted to other point cloud formats with FARO software.  Since these scans tend to give very dense point clouds, it's easier to work with them after downsampling (which is possible with Vidware).

### SfM

We are using Agisoft for SfM.

### Google Tango

### Cameras

#### Intel Realsense

#### Microsoft Kinect

### Portability (Ghostbusters backpack)

### 3D Printing

### Meshing/VR

## Summer 2017

### SLAM Algorithms

#### RTAB-MAP

#### RGBD-SLAM

#### ORB_SLAM2

#### InfiniTAM

#### Other

### Registration

#### Super4PCS

Super4PCS is an optimized version of the registration algorithm 4PCS.

Source: https://github.com/nmellado/Super4PCS

To run Super4PCS with Docker:
Prepare your workspace:
```
mkdir super4pcs-workspace
cd super4pcs-workspace
```

Grab the [Docker image from Docker Hub](https://hub.docker.com/r/proudh/super4pcs-script/):
```
docker pull proudh/super4pcs-script
```

Then prepare a folder in the workspace for input models, and copy over the models needed:
```
mkdir models
cp lidar1.ply models/.
cp slam1.ply models/.
```

Make an inputs text file. This info can also be found by running `./s4p-register.sh -h`:
Each line in the input .txt file is formatted like so:
```
<referenceRelativeFilepath1> <readingRelativeFilepath1> [outputRelativeFilepath1] [overlap] [delta] [time] [# of samples]
<referenceRelativeFilepath2> <readingRelativeFilepath2> [outputRelativeFilepath2] [overlap] [delta] [time] [# of samples]
...
```
  where `<referenceFilepath>` is the location of the .ply reference/source point cloud
    relative to the input root filepath,
  `<readingFilepath>` is the location of the .ply reading/target point cloud
    relative to the input root filepath,
  `[outputFilepath]` is the directory where the log file and aligned reading point cloud
    will be stored relative to the output root filepath,
    (default: `outputRootFilepath/<currentTime>`)
  and the rest are Super4PCS options.
  (default: overlap = 0.6, delta = 0.03, time = 10000, samples = 10000)
To omit an optional option and use defaults, enter `-`.

And run the Docker image with your desired parameters. For example:
```
docker run -v ~/super4pcs-workspace/:/s4p-docker/ -w=/s4p-docker/ proudh/super4pcs-script /e4e-maya/registration/s4p-register.sh /s4p-docker/inputs.txt -i /s4p-docker/models/ -o /s4p-docker/ -s /e4e-maya/general -v 
```

Usage for the Super4PCS script is as follows (info can also be found by running `./s4p-register.sh`):
```
USAGE: ./s4p-register.sh <input txt file> [-i input root filepath] [-o output root filepath] [-s = scripts filepath] [-d = create root folder with today's date] [-v = verbose] [-k = keep output]
where options are:
<input txt file>: .txt file specifying each Super4PCS registration run.
  Run ./s4p-register.sh -h for more details on how to format this file.
[-i input root filepath]: root directory where reading/reference point clouds will be read.
  (default: S4P_INPUT_ROOT)
[-o output root filepath]: root directory where outputted logs
  and aligned reading point clouds will be read.
  (default: S4P_OUTPUT_ROOT)
[-s scripts filepath]: directory where get_pcl_error.sh and pcl_convert.sh are stored
  (default: REG_SCRIPTS_PATH)
[-d]: create a folder in the output root filepath with today's date and store all output in this folder
  (default: do not create folder)
[-v]: verbose mode. Prints info during runtime
  (default: not verbose)
[-k]: keep outputted point clouds from registration and computing error, i.e. aligned reading models
  and reference models with error intensity colors, in pcd and ply. Note that this might take up a lot
  of memory if your models are huge!
  (default: don't keep)
```

To run Super4PCS manually:
```
Usage: ./Super4PCS -i input1 input2
	[ -o overlap (0.20) ]
	[ -d delta (5.00) ]
	[ -n n_points (200) ]
	[ -a norm_diff (90.000000) ]
	[ -c max_color_diff (150.000000) ]
	[ -t max_time_seconds (10) ]
	[ -r result_file_name (output.obj) ]
	[ -x (use 4pcs: false by default) ]
```

Note that 4PCS is also built-in to Super4PCS and can be run using the flag `-x`.


#### libpointmatcher

#### Go-ICP

Source: http://jlyang.org/go-icp/#code

	install GoICP
	install PCL
	
To install:
```
cd go-icp-script
mkdir build
cd build
cmake ..
make
```

To run (config.txt - adjust parameters for registration)
```
cd go-icp-script/scripts
python go-icp.py lidar.ply slam.ply
```
where lidar.ply and slam.ply are the reference and reading models, respectively

Model Files will be located in 
`go-icp-script/models/`
	-> lidar.ply (original reference file)
  
	-> mat.txt (transformation matrix file)
  
	-> slam-t.ply (transformed slam file)
  
	-> error-p2p.pcd (error file of point to point error)
  
	-> error-p2pl.pcd (error file of point to plane error)

#### NICP

#### CloudCompare

### Other work

#### Computing cloud error scripts

#### Comparing SfM vs. LIDAR

#### Literature review

### Viewing point clouds

#### CloudCompare

#### Meshlab

#### Vidware

#### pcl_viewer

### Notes

#### Tips

#### Other notes
