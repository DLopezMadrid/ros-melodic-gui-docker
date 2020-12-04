XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# allow x server connection
xhost +local:root

# to set up the right environment variables in CLion
echo "Set \$DISPLAY parameter to $DISPLAY" 

docker start ros-docker
docker attach ros-docker 

# disallow x server connection
xhost -local:root
