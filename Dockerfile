FROM kasmweb/core-alpine-319:1.15.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

ARG version="3.1.6"


RUN \
   echo "---Install packages---" \
   && wget https://github.com/doug-101/TreeLine/releases/download/v$version/treeline-$version.tar.gz \
   && tar xf treeline-$version.tar.gz\
   && apk update\
   && apk upgrade\
   && apk add --no-cache \
        py3-qt5 \
        thunar-vcs-plugin \
        subversion \
        git \
        ristretto \
        evince \
   && cd TreeLine && python install.py \
   && cd .. && rm -r TreeLine && rm treeline-$version.tar.gz \
   && cp /usr/local/share/applications/treeline.desktop $HOME/Desktop/\
   && chmod +x $HOME/Desktop/treeline.desktop \
   && chown 1000:1000 $HOME/Desktop/treeline.desktop \
   && echo "---Cleanup---" \
   && apk del xterm \
   rm -rf \
         /tmp/*

COPY alpine-treeline.jpg /usr/share/backgrounds/bg_default.png
COPY mimes.txt /etc/xdg/mimeapps.list
COPY json.xml /usr/share/mime/packages/Overrides.xml
RUN  update-mime-database /usr/share/mime

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
