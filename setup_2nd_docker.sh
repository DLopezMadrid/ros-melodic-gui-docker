XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -



nvidia-docker run -it \
    --name="ros-docker-g2o" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume=`pwd`/catkin_ws_g2o:/root/catkin_ws \
    --volume=`pwd`/gazebo_worlds:/root/gazebo_worlds \
    --runtime=nvidia \
    dlopezmadrid/ros-melodic-gui-docker



