FROM ruby

RUN apt-get update && \
    apt-get full-upgrade --yes

ARG USERNAME=me
RUN groupadd --gid 1000 $USERNAME && \
    useradd --uid 1000 --gid $USERNAME --create-home --shell /bin/bash $USERNAME
RUN apt-get install --yes sudo && \
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME

RUN apt-get install --yes vim

USER $USERNAME
