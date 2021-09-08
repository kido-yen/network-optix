#!/bin/sh
help (){
echo "host network mode (h),port mapping (p),quit (q)"
}
instruction (){
echo "run following command to access the container"
echo "# docker run exec -it mediaserver bash"
echo "Please note, storage need to be mounted at /mnt for nx to recognize as local storage"
}
while [ 1 ];do
    help
    read -p "" opt 
    opt=${opt:-q}
    case "$opt" in
        h) echo "start container using host network"
	   # use host network
           docker run -it -d --rm --privileged --name mediaserver --net=host kidoyen/mediaserver
	   instruction
	   exit
            ;;
        p) echo "start container using port mapping"
           # map container port to host port
           docker run -it -d --rm --privileged --name mediaserver -p 7001:7001 kidoyen/mediaserver
	   instruction
	   exit
            ;;
        q) echo "Quit"
	   exit
            ;;
        *) echo "Unknown option"
    esac
done
