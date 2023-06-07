FROM ubuntu:focal AS builder
ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y curl sudo build-essential && useradd --user-group --create-home --shell /bin/bash foam ;\
	echo "foam ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && chsh -s /bin/bash foam 
USER foam
RUN sudo apt install -y g++-7 gcc-7 && sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7 && sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7 &&\
	sudo update-alternatives --config gcc && sudo update-alternatives --config g++ &&\
	sudo DEBIAN_FRONTEND=noninteractive apt install -y  build-essential gdb autoconf autotools-dev cmake gawk flex libfl-dev libreadline-dev zlib1g-dev openmpi-bin libopenmpi-dev mpi-default-bin mpi-default-dev libgmp-dev libmpfr-dev libmpc-dev nano bc
COPY --chown=foam:foam . /home/foam/
WORKDIR /home/foam
RUN cd ./OpenFOAM-v1706 && source ./etc/bashrc && ./Allwmake -j -s -q -k
RUN echo "source ~/OpenFOAM-v1706/etc/bashrc" >> ~/.bashrc && mkdir ~/openfoam-data && mkdir ~/openfoam-data/run && sudo chown -R foam:foam ~/openfoam-data && echo "export FOAM_RUN=~/openfoam-data/run" >> ~/.bashrc && echo "export WM_PROJECT_USER_DIR=~/openfoam-data" >> ~/.bashrc && source ~/.bashrc && echo 'export FOAM_USER_APPBIN="$WM_PROJECT_USER_DIR"/platforms/"$WM_OPTIONS"/bin' >> ~/.bashrc && echo 'export FOAM_USER_LIBBIN="$WM_PROJECT_USER_DIR"/platforms/"$WM_OPTIONS"/lib' >> ~/.bashrc && echo 'export PATH="$FOAM_USER_APPBIN":"$PATH"' >> ~/.bashrc && echo 'export LD_LIBRARY_PATH="$FOAM_USER_LIBBIN":"$LD_LIBRARY_PATH"' >> ~/.bashrc && source ~/.bashrc
