FROM centos:7.3.1611

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum clean all
RUN yum --releasever=7.3.1611 -y update
RUN yum --releasever=7.3.1611 -y install epel-release
RUN yum --releasever=7.3.1611 -y install \
  sudo which lshw pciutils less tcsh wget gzip tar samba-winbind-clients bind-utils \
  unzip vim net-tools lsof strace gvfs mesa-demos mesa-dri-drivers mesa-filesystem \
  mesa-libEGL mesa-libGLES mesa-libGL mesa-libGLU mesa-libOSMesa \
  mesa-libgbm mesa-private-llvm mesa-lib* openmotif glx-utils rpm tcl tk perl python gcc \
  SDL blas compat-gcc-44 compat-gcc-44-c++ compat-libstdc++-33.i686 \
  compat-libstdc++-33 compat-libtiff3 ftgl gcc-c++ glib2.i686 glib2 glibc.i686 glibc \
  gstreamer gtk2 gtk2.i686 libSM libSM.i686 libXfont libXft.i686 libXft libXp \
  libXp.i686 libXpm libXScrnSaver libXt libXt.i686 libXxf86vm libXxf86vm.i686 \
  libjpeg-turbo libjpeg-turbo.i686 libmng libnotify libpng.i686 libpng libpng12 \
  libpng12.i686 librdmacm libstdc++ libstdc++.i686 libstdc++-devel \
  libstdc++-devel.i686 libtiff libtiff.i686 libxkbfile libxkbfile-devel motif motif.i686 \
  openssl11-libs postgresql-libs python-libs redhat-lsb sssd-client.i686 sssd-client \
  tbb xalan-c xerces-c xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-cyrillic xterm \
  zlib giflib bzip2-libs qwt expat xorg-x11-apps mlocate libicu \
  xcb-util-renderutil xcb-util xcb-util-image xcb-util-keysyms xcb-util-wm \
  pcre pcre-{static,devel,tools} \
  qt5-qtbase-common.noarch qt5-qtbase qt5-qtbase-gui qt5-qtxmlpatterns \
  qt5-qtdeclarative qt5-qtlocation qt5-qtsensors qt5-qtwebchannel \
  libvorbis 1:libtheora 2:libogg \
  cdparanoia-libs libXv libvisual xml-common iso-codes orc \
  gstreamer-plugins-base libxslt libwebp gdk-pixbuf2 libbsd libcanberra-gtk2 \
  gstreamer1-plugins-bad-free gstreamer1-plugins-base openssh-server openssh-clients
RUN yum clean all

RUN ln -sf /opt/ansys_inc /ansys_inc

ENV ANSYS190_BASE_DIR=/ansys_inc/v190
ENV ANSYS190_DIR=$ANSYS190_BASE_DIR/ansys
ENV PATH=$ANSYS190_BASE_DIR/fluent/bin:$PATH
ENV PATH=$ANSYS190_BASE_DIR/CFX/bin:$PATH
ENV PATH=$ANSYS190_BASE_DIR/TurboGrid/bin:$PATH
ENV PATH=$ANSYS190_BASE_DIR/icemcfd/linux64_amd/bin:$PATH
ENV PATH=$ANSYS190_BASE_DIR/Framework/bin/Linux64:$PATH
ENV LD_LIBRARY_PATH=$ANSYS190_BASE_DIR/Framework/bin/Linux64/Mesa:$LD_LIBRARY_PATH
ENV XLIB_SKIP_ARGB_VISUALS=1
