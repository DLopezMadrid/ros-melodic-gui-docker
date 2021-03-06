XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -



nvidia-docker run -it \
    --name="ros-docker" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --cap-add=SYS_PTRACE \
    --volume=`pwd`/vscode_dir:/root/vscode_dir \
    --volume=`pwd`/catkin_ws:/root/catkin_ws \
    --volume=`pwd`/gazebo_worlds:/root/gazebo_worlds \
    --runtime=nvidia \
    dlopezmadrid/ros-melodic-gui-docker



