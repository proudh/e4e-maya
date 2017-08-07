#!/bin/bash

mat=`tail -n +3 $1`
mat=${mat//   /,}
mat=${mat//$'\n'/,}
mat=${mat// /}
echo $mat
