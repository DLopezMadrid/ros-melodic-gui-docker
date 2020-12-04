## ROS Melodic docker image with X11 forwarding

Based on instructions from the [ROS wiki](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration)  

[GitHub repo](https://github.com/DLopezMadrid/ros-melodic-gui-docker)  
[DockerHub repo](https://hub.docker.com/repository/docker/dlopezmadrid/ros-melodic-gui-docker)  

You will need the latest nvidia-drivers (tested with 455) and nvidia-docker2  

This image also contains sublime text, zsh and a bunch of other common utilities  

1. Build image with `build_image.sh`  
2. Setup container with `setup_docker.sh`  
3. Launch container with `start_docker.sh`  
4. Test that the environment is properly loaded by running
`roscd roscpp`
5. To test that you can run GUI apps, run the following command from within the container  
`roscore > /dev/null & rosrun rviz rviz`  
  
Note: you can also source the ROS environment by running  
`source /opt/ros/melodic/setup.zsh`  
or the `rs` alias  

