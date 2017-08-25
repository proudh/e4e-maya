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

#### libpointmatcher

#### Go-ICP

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
