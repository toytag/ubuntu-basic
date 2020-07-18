FROM ubuntu:16.04

# mirrors
# RUN sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

# basic
RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y curl git locales man tmux vim zsh \
    && locale-gen en_US.UTF-8

# zsh config
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && chsh -s /usr/bin/zsh \
    && sed -i "2c PROMPT+='%{\$fg[cyan]%}%~%{\$reset_color%} \$(git_prompt_info)'" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting \
    && sed -i "s/(git)/(git vi-mode zsh-syntax-highlighting)/g; /^# export LANG=/c export LC_ALL=en_US.UTF-8" ~/.zshrc

# vim config
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && sh ~/.vim_runtime/install_basic_vimrc.sh

# tmux config
RUN echo "set -g mouse on" >> ~/.tmux.conf

# interface
CMD cd ~/ && /usr/bin/zsh
