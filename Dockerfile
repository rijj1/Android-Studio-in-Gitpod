FROM gitpod/workspace-full-vnc@sha256:331a933c3bce7d7cb3e78f8cfac93ae706091575758adeba3a86072d585e52b0

ARG ANDROID_STUDIO_URL=https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.28/android-studio-2023.1.1.28-linux.tar.gz
ARG ANDROID_STUDIO_VERSION=2023.1.1

USER root

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      coreutils            \
      curl                 \
      expect               \
      lib32gcc1            \
      lib32ncurses5-dev    \
      lib32stdc++6         \
      lib32z1              \
      libc6-i386           \
      pv                   \
      unzip                \
      wget  && \
  apt-get clean && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /tmp/* && \
  rm -rf /var/tmp/*

RUN \
  wget -O /opt/android-studio-ide.tar.gz $ANDROID_STUDIO_URL && \
  export sha="$(sha256sum /opt/android-studio-ide.tar.gz)" ; \
  if [ "$sha" != "139d0dbb4909353b68fbf55c09b6d31a34512044a9d4f02ce0f1a9accca128f9  /opt/android-studio-ide.tar.gz" ]; then \
      echo "SHA-256 Checksum mismatch, aborting installation"; \
      rm -f /opt/android-studio-ide.tar.gz; exit 1; \
    else \
      cd /opt && tar xf android-studio-ide.tar.gz && rm android-studio-ide.tar.gz; \
    fi

# fix display resolution
RUN \
  sed -i 's/1920x1080/1280x720/' /usr/bin/start-vnc-session.sh

USER gitpod

RUN \
  mkdir -p $HOME/.local/bin && \
  printf '\nPATH=$HOME/.local/bin:$PATH\n' | \
      tee -a /home/gitpod/.bashrc && \
  ln -s /opt/android-studio/bin/studio.sh \
    /home/gitpod/.local/bin/android_studio && \
  : "if running locally (vs using gitpod in cloud) need to create /workspace " && \
  sudo mkdir -p /workspace/.gradle && \
  sudo chown -R gitpod:gitpod /workspace

ARG ANDROID_INSTALLATION_URL=https://github.com/phlummox/android-studio-docker/releases/download/v0.1/android-studio-installation.tar.xz

RUN \
  cd $HOME && \
  wget -O - $ANDROID_INSTALLATION_URL | tar x --xz