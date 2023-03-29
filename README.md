# About

A step-by-step guide for running ANSYS v190 on any Linux distribution within a CentOS 7.3 docker container.

## Requirements
* [docker](https://www.docker.com)
* [x11docker][1] (optional, but recommended)
* Ansys v19.0 installation files

## Install

### Install and setup docker

1. Install docker.<br>
   For more information on how to complete this step, visit <https://docs.docker.com/get-docker/>.

1. Create the `docker` group
    ```{bash}
    sudo groupadd docker
    ```

1. Add users to the `docker` group. For that, replace `<username>` with the actual username
    ```{bash}
    sudo usermod -aG docker <username>
    ```

   Log out and log back in so that group membership is re-evaluated.   
   > **Note**<br/>
   > If you’re running Linux in a virtual machine, it may be necessary to
   > restart the virtual machine for changes to take effect.

1. Verify that you can run `docker` commands without `sudo`.

    ```{bash}
    docker run --rm hello-world:latest && docker image rm hello-world:latest
    ```

### Setup the docker container

1. Build the CentOS 7.3 docker image.

    ```{bash}
    docker build - --no-cache --tag local/centos7.3-ansys-v190:latest < Dockerfile
    ```

1. Put the ANSYS installation files somewhere you can access, e.g., `$HOME/Downloads`. It is likely that the files are compressed (e.g., `zip` or `tar.gz`). If so, decompress them.

1. Create the installation directory in the host machine.

    ```{bash}
    sudo mkdir /opt/ansys/v190
    ```

1. Run a docker instance to perform the installation. The easiest way is using `run-install.sh`. The script requires the installation directory as its first argument.

    ```{bash}
    ./run-install.sh <PATH_TO_ANSYS_INSTALL_DIR>
    ```

1. It will prompt a shell inside the container. The shell will start at the installation directory. Go to the desired folder and run the installation script.

    ```{bash}
    ./INSTALL -debug
    ```

    > **Note**<br>
    > Remember to install it into `/opt/ansys_inc`.

6. After installing, exit the container.

### Running Ansys workbench (optional)

This step depends on [x11docker][1]. `x11docker` is a convenient way of running GUI application inside docker containers. If you choose to skip this step, then you are on your own.

After installing `x11docker`, run `./ansys190-wb2` to use access the Ansys Workbench.
    
## Troubleshooting
 
 1. It may happen that ANSYS will complain about `libfontconfig.so.1`. If it happens, search for `libfreetype` in your `/ansys_inc` directory and rename it to something else. It really does not matter the new name. The intention is to remove this library from LD_LIBRARY_PATH. The following code snippet will search for the library in your `ansys_inc` directory and rename it by appending `.bak`.

    ```
    find <PATH_TO_ANSYS_INC> -iname libfreetype* -type f -exec mv {}{,.bak} \;
    ```
 2. If fonts appear to be weird, try to install some fonts on the host. On Ubuntu 20.04 and 22.04, the following works fine
 
    ```
    sudo apt install fontconfig xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic
    ```

## License

This repository is licensed under the terms of the MIT license. For further information, see the [LICENSE](./LICENSE).

[1]: https://github.com/mviereck/x11docker
