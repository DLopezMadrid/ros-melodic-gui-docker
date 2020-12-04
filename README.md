### ROS Melodic docker container with X11 forwarding

Based on instructions from http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration

You will need the latest nvidia-drivers (tested with 455) and nvidia-docker2

1. Build image with `build_image.sh`  
2. Setup container with `setup_docker.sh`  
3. Launch container with `start_docker.sh`  
4. To test that you can run GUI apps, run the following command from within the container  
`roscore > /dev/null & rosrun rviz rviz`

