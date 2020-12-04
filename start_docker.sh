XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# allow x server connection
xhost +local:root

# to set up the right environment variables in CLion
echo "Set \$DISPLAY parameter to $DISPLAY" 

docker start ros-melodic-nv
#export containerId=$(docker ps -l -q)
docker exec ros-melodic-nv bash -c 'source /ros_entrypoint.sh' 
docker attach ros-melodic-nv 

# disallow x server connection
xhost -local:root
