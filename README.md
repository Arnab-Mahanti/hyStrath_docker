# HYSTRATH DOCKER
This is a dockerized container for running the hyStrath module for OpenFOAM-v1706 built on top of a Ubuntu Focal image.

To use this follow the following instructions:

1. Clone this repository using the following:

    ``` 
    git clone https://github.com/arnab-mahanti/hyStrath_docker.git 
    ``` 

2. Change directory to hyStrath_docker:

    ``` 
    cd hyStrath_docker
    ```

3. Create directory for persistant storage. If you want to change the name or location, change the docker-compose.yaml, Dockerfile and .dockerignore accordingly. This will essentially become the $WM_PROJECT_USER_DIR and $FOAM_RUN of OpenFOAM.

    ``` 
    mkdir openfoam-data && mkdir openfoam-data/run
    ```

4. Download the source .tgz files for Ubuntu (30/06/2017: OpenFOAM v1706) for both [OpenFOAM](https://sourceforge.net/projects/openfoam/files/v1706/OpenFOAM-v1706.tgz) and the [ThirdParty](https://sourceforge.net/projects/openfoam/files/v1706/ThirdParty-v1706.tgz)

5. Untar them.

    ```
    tar -xzvf ./OpenFOAM-v1706.tgz && tar -xzvf ./ThirdParty-v1706.tgz 
    ```

6. (Optional) Clean up the archives.

    ```
    rm ./OpenFOAM-v1706.tgz ./ThirdParty-v1706.tgz
    ```

7. Clone the hyStrath repository master branch into openfoam-data.

    ```
    cd ./openfoam-data && git clone https://github.com/hystrath/hyStrath.git --branch master --single-branch && cd ..
    ```

8. Build and deploy the docker image. This can take a long time (apprx. 1 hr. depending on the system configuration).

    ``` 
    docker-compose up -d
    ```

9. Check for the name of the running container. Probably hyStrath_docker_openfoam_1.

    ```
    docker ps 
    ```

10. Enter into the container to install hyStath

    ```
    docker exec -it NAME_OF_DOCKER_CONTAINER /bin/bash
    ```

11. Install the required hyStrath modules. Replace NUMPROCS with the number of processors used during compilation.

    ```
    cd $WM_PROJECT_USER_DIR/hyStrath && ./install.sh NUMPROCS 2>/dev/null
    ```
