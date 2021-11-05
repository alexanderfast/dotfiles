FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y git python3 sudo

ENV USER user
ENV HOME /home/$$USER
RUN useradd -m $USER
RUN usermod -aG sudo $USER
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR $HOME
COPY . .dotfiles
RUN chown -R $USER:$USER .
USER $USER
WORKDIR .dotfiles
RUN git submodule update --init
RUN ./install
RUN sudo usermod -s /bin/zsh $USER
WORKDIR $HOME
