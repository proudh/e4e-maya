# Maya Archaeology
## Overview
Welcome to the Maya Archaeology project!  This is a project under UC San Diego's Engineers for Exploration research program.

Our goal is to develop a portable and accessible system for archaeologists to document excavations quickly and accurately by generating 3D computer models of them.  Currently we are experimenting with using mobile remote sensing technologies and different reconstruction algorithms, and testing with archaeologists studying ancient Maya temples in Guatemala.

Refer to the [Engineers for Exploration website](http://e4e.ucsd.edu/maya-archaeology) for general info about the history of the project.

## Goals
Ideally our proposed system would be:
1. Accurate
 - The 3d models we generate will be used for documentation.  Currently we are testing the accuracy of our data collection methods (refer to Summer 2017 work).
 
2. Portable
 - It is costly and inconvenient to bring large and heavy equipment to the field sites, but portability especially becomes a must for the Maya temple expeditions. Since archaeologists must excavate these temples to access them, and the resulting tunnels in the temples can get small and narrow (sometimes requiring crawling to get through!).  The tunnels are not suitable for wheeled robots and can get too small for small aircrafts, so the easiest alternative so far are humans.

3. Gets real-time results
 - Expeditions to the field site are not easily accessible, i.e. once a year; this gives rise to the possibility that while scanning a part of a Maya temple, there is not enough data to complete the model for it (i.e. we missed capturing a certain angle of a mask).  Real-time results would alert us of this situation and be able to complete the model on-site, instead of finding out there is a hole in the model a couple months later while processing the data, and having to wait until next year to try again.

4. Affordable
 - We want to eventually hand over this system for archaeologists to use, so expensive equipment should not be a barrier.

5. Simple to use
 - Ideally, archaeologists would be able to use this system on their own without too much technical knowledge or expertise.  Thus in the end, our system should be easy to setup and should have a user-friendly interface.

6. Quick
 - To limit the cost of an expedition and for the archaeologists' convenience, data collection should be as quick as possible while maintaining accuracy.

The systems that we are using currently give us point clouds (set of 3d points), but eventually we will want to generate meshes from these (connecting these 3d points with faces) so that they can be easily viewed and worked with (especially for 3d printing/VR).

## Past work

### LIDAR

In previous years we have used a FARO LIDAR to get point clouds of Maya temples.  This generates a `.ptx` file which may be converted to other point cloud formats with FARO software.  Since these scans tend to give very dense point clouds, it's easier to work with them after downsampling (which is possible with Vidware).

### Structure from Motion (SfM)

SfM takes in a set of still 2d images of a 3d object at different angles, and outputs a 3d computer reconstruction of that object.  This works by finding common features across these images, and based on how they appear in each image, calculating where the features are in 3d space to convert it to a 3d point. 

In past years we have tried to focus on optimizing SfM so that ideally it can run in real-time so that on the field, researchers can see if they've collected enough data.  We tried to parallelize the Bundle Adjustment step of an SfM toy library (at https://github.com/royshil/SfM-Toy-Library ) and tried to port it to a GPU using ArrayFire, but we only worked on the pre-processing step to the OpenCV call to Bundle Adjustment. 

More recently, we have been using the commercial software Agisoft for SfM.  You can access Agisoft from the desktop in the SEALab.  SfM still has the drawback of not getting us real-time results, but it can generate meshes, overlay texture from photos onto 3d models, and is faster and cheaper than using LIDAR.

### Google Tango/Simultaneous Localization and Mapping (SLAM)

Instead of trying to optimize SfM, we've also tried using Simultaneous Localization and Mapping (SLAM) to generate a 3d computer model.

SLAM is traditionally used for robot exploration.  A robot running SLAM in an unknown environment will generate a map of its surroundings using sensor data such as RGB images, depth maps, and location (position, heading, etc), and use this map to go around.  As the robot moves, it updates its own map, and uses that map to navigate.

SLAM is helpful because the map, which can be a 3d computer model, is generated in real-time.  But the results might not be that accurate, and it's easy for SLAM to lose track of where it is, i.e. if the camera recording moves too fast or is bumpy.

In past years we have run Kinfu as well as InfiniTAM on the Google Tango for scanning.  However for InfiniTAM, integrating motion estimation is not yet stable.

### Cameras

#### Intel Realsense

We have worked with the Intel Realsense R200, SR300, and ZR300 cameras.  These cameras work in RGBD (red, green, blue, and depth) and are lightweight and portable.  Also, the ZR300 has a built-in IMU. However, the video quality of these cameras is not as good as the Microsoft Kinect cameras.  Recently, we tested the SR300 and ZR300 cameras in Guatemala; the data looks noisier than that recorded by the Kinects.

There are corresponding Realsense ROS launch files for the various SLAM algorithms we are testing (i.e. to run RTAB-MAP with the Realsense, use `~/workspace/maya_archaeology/rtabmap/rtabmap_realsense.launch`).  Be sure to toggle the SR300 parameter as necessary.

#### Microsoft Kinect

We also are working with the Microsoft Kinect v1 and v2 cameras.  These do not have built in IMUs and are bulkier than the Intel Realsense cameras, but they have better video quality.

There are separate Kinect ROS launch files for the Kinect v1 and v2 (i.e. `~/workspace/maya_archaeology/rtabmap/rtabmap_kinectv1.launch` and `~/workspace/maya_archaeology/rtabmap/rtabmap_kinectv2.launch`). Kinect v1 is handled with [freenect_stack](http://wiki.ros.org/freenect_stack) and Kinect v2 is handled with [libfreenect2](https://github.com/OpenKinect/libfreenect2).

### Portability/lighting (Ghostbusters backpack)

Students from Spring 2017 CSE 145/245 made a backpack setup to make it easier to bring and use our equipment in the field.  Prior to this,  scanning the tunnels of the Maya temple required holding a laptop in one hand and holding a Kinect camera in the other, which was cumbersome.  The backpack setup allowed us to run SLAM algorithms from a laptop in the backpack; a tablet was remotely connected to the laptop for the user to hold in order to access the laptop.  This tablet was attached to a rig that included an LED panel for lighting.

Lighting for SLAM/SfM is important for the quality of the outputted model.  Hard shadows can be mistakened for features, and the range of the light limits how much the camera can pick up, so ideally we want our lighting to have as far of a range as possible, eliminating/softening as many shadows as possible, but still be low-powered and portable.

A [quick Google search on rendering light](https://blender.stackexchange.com/questions/18697/lighting-without-highly-visible-shadows) suggests
 - Large light source
 - Multiple lights
 - Environment lighting

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

Source: https://github.com/ethz-asl/libpointmatcher

libpointmatcher runs regular ICP but has many [preprocessing filtering options](http://libpointmatcher.readthedocs.io/en/latest/Datafilters/).  Registration is quick compared to Super4PCS and Go-ICP.  Note that libpointmatcher works with .vtk files.

To run libpointmatcher:
Prepare your workspace:
```
mkdir libpointmatcher-ws
cd libpointmatcher-ws
```

Grab the [Docker image](https://hub.docker.com/r/proudh/libpointmatcher-docker/) for libpointmatcher:
```
docker pull proudh/libpointmatcher-docker
```

Prepare a folder in the workspace for input models, and copy over the models needed.
Make sure that the models are in `.vtk` format.  If not, then use PCL to convert your models, i.e. `pcl_pcd2vtk`.
Note that `pcl_ply2vtk` might run into errors.  A workaround is to use `pcl_ply2pcd` then `pcl_pcd2vtk` instead, and/or make sure you're using the latest version of PCL (at the time of this writing it is PCL 1.8).
```
mkdir models
cp lidar1.vtk models/.
cp slam1.vtk models/.
```

Then make a config file with your desired data filters, and store this in your workspace.  Here are the contents of a config file `pointtoplane.yaml` we used, specifically setting the errorMinimizer to `PointToPlaneErrorMinimizer`:
```
readingDataPointsFilters:
  - SamplingSurfaceNormalDataPointsFilter:
      knn: 10
      keepDensities: 1
# We tried using the MaxDensityDataPointsFilter but it seemed to filter out too many points.
#  - MaxDensityDataPointsFilter

referenceDataPointsFilters:
  - SurfaceNormalDataPointsFilter
#  - MaxDensityDataPointsFilter

matcher:
  KDTreeMatcher:
    knn: 1

outlierFilters:
  - TrimmedDistOutlierFilter:
      ratio: 0.9

errorMinimizer:
  PointToPlaneErrorMinimizer

transformationCheckers:
  - CounterTransformationChecker:
      maxIterationCount: 40
  - DifferentialTransformationChecker:
      minDiffRotErr: 0.001
      minDiffTransErr: 0.01
      smoothLength: 4

inspector:
  NullInspector
# When uncommented, the following generates the point clouds step by step during the registration process.
#  VTKFileInspector:
#     baseFileName : vissteps
#     dumpDataLinks : 1
#     dumpReading : 1
#     dumpReference : 1

logger:
  FileLogger
```

Then to run the Docker container:
```
docker run -v ~/libpointmatcher-ws/:/libpointmatcher-ws/ -w=/libpointmatcher-ws/ proudh/libpointmatcher-docker time -p /Libraries/libpointmatcher/build/examples/pmicp -v --config /libpointmatcher-ws/pointtoplane.yaml /libpointmatcher-ws/lidar1.vtk /libpointmatcher-ws/slam1.vtk 
```

#### Go-ICP

Source: http://jlyang.org/go-icp/#code

Note that Go-ICP takes in a text file as input.  We have a Docker image for running Go-ICP as well as a script that will convert your point clouds to the text file needed for Go-ICP.  To use Go-ICP:


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

NICP is a library for point cloud registration. We have Docker images for running some sample NICP programs such as the NICP viewer. However, due to time constraints it was easier to work with the other registration algorithms we set up already, so we ended up not using it.


### Other work

#### Computing cloud error scripts

PCL has a small binary `pcl_compute_cloud_error` that can compute the root mean square error (RMSE) between two point clouds, which allows us to quantify how "correct" a generated model is by summing up distances between the point clouds.  The RMSE can be calculated with point-to-point distances (finding the distance between point A in the SLAM model against the closest point B in the LIDAR model) or with point-to-plane distances (generating a plane tangent to the surface including point B and a few of its neighbors in the LIDAR model, and finding the distance between point A in the SLAM model to this plane).  We expect that the point-to-plane calculation is more accurate for our usage, because although the tunnels in Maya temples have bumpy, rocky walls, the walls are overall still generally flat; point-to-point calculations would be better for situations that don't have such room-like structure, such as comparing two spherical objects.

Since `pcl_compute_cloud_error` can only work with `.pcd` files, for convenience, we have scripts that take in `.ply` and `.vtk` files, automatically convert them to `.pcd`, find the RMSE between two models, and converts the output to `.ply`, which can be opened in CloudCompare.

#### Comparing SfM vs. LIDAR

#### Literature review 

### Viewing point clouds

#### CloudCompare
CloudCompare can open up point clouds for viewing, and is good for viewing many point clouds once.  It also can perform operations on them; what we've used are:
- Translation/rotation for roughly aligning models together for comparison.
- Inputting matrix transformation for scaling. For example, to scale a point cloud to be 5 times larger, input the matrix:
5 0 0 0
0 5 0 0
0 0 5 0
1 0 0 0
- Matrix transformations can also be used to quickly visualize the result of a registration algorithm. Copy and paste the transformation matrix outputted from registration onto the original model to see how well the registration algorithm did in moving it.
- Segmentation (scissor tool in top menu) to cut out unnecessary or noisy parts of models.
- Computing normals and curvature, which are fields used for finding the point-to-plane error using PCL.
- Registration. Given two roughly aligned models, you can use CloudCompare's built-in ICP to register them.  The quality of this registration is worse than other stand-alone registration algorithms however.

Note that CloudCompare doesn't work on a few laptops in the SEALab, i.e. Thinkpad and Dell.

#### Meshlab
Meshlab can also visualize point clouds, open multiple point clouds at once, and translate/rotate/scale point clouds.  It also has some nifty options for filtering which we haven't explored too deeply yet.  Meshlab is on all of the laptops in the SEALab that we've used (MSI, Dell, Thinkpad).

#### Vidware
Vid's viewer is the best at visualizing large, dense point clouds and being able to control the camera in order to "walk" through the point cloud tunnels.  It is accessible on the desktop in the SEALab.

#### pcl_viewer
PCL provides a simple viewer where you can look at the error intensities generated by calculating the error from `pcl_cloud_compute_error`.  Note that this only works with `.pcd` point cloud files.

To run `pcl_viewer` on your reference model `error.pcd`:
```
$ pcl_viewer error.pcd
```

Press `l` to see all options for colorings in your open model.
```
List of available geometry handlers for actor error.pcd-0: xyz(1) 
List of available color handlers for actor error.pcd-0: [random](1) x(2) y(3) z(4) intensity(5)
```

In this case, pressing `5` will show the error intensity of the model (how far apart the reading/SLAM model was from this reference/LIDAR model).

Press `u` to show a lookup table that quantifies these colors.
Note that toggling this on using the MSI laptop outputs this error:
```
ERROR: In /build/vtk6-dmAaMa/vtk6-6.2.0+dfsg1/Rendering/OpenGL/vtkOpenGLTexture.cxx, line 200
vtkOpenGLTexture (0x203a780): No scalar values found for texture input!
```
However everything still looks fine and the viewer doesn't crash, so it's probably ok :)

To open multiple models at the same time, i.e. `error.pcd` and `slam1.pcd`:
```
$pcl_viewer error.pcd slam1.pcd
```

Note that there are no options for translating/rotating/scaling models.


### Notes

#### Tips

#### Other notes
