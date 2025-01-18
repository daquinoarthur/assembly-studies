# Use Ubuntu as base image with x86_64 architecture
FROM --platform=linux/amd64 ubuntu:22.04

# Avoid prompts during packages installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    nasm \
    gcc \
    gdb \
    make \
    vim \
    nano \
    binutils \
    libc6-dev-i386 \
    && rm -rf /var/lib/opt/lists/*

# Create a working directory
WORKDIR /asm-work

# Create a script to set up permissions
RUN echo "#!/bin/bash\n\
    if [ ! -d \"/asm-work/src\" ]; then\n\
    mkdir -p /asm-work/src\n\
    fi\n\
    chown -R \$(id -u):\$(id -g) /asm-work\n\
    exec \"\$@\"" > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
