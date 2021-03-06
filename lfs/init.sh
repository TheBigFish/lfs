#!/bin/bash
set -e

# 由于在 .bash_profile 中新建了 shell
# 所以无法通过管道的方式来让新建的 shell 继续执行命令
# 修改官方手册的 .bash_profile，让它自动调用 ~/scripts/build.sh（lfs/build.sh的拷贝）
# 把相关的配置放在 build.sh 执行
# 为了实现自动构建，调整了这一块指令的流程
# 同时为了与官方手册比对，该文件的后半部分通过注释列出了官方手册的操作
cat > ~/.bash_profile << "EOF"
set -e

exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash -c "bash ~/scripts/build.sh"
EOF
source ~/.bash_profile

# 我们在 .bash_profile 中使用 exec env -i.../bin/bash 命令
# 新建一个除了 HOME, TERM 以及 PS1 外没有任何环境变量的 shell，替换当前 shell
# 防止宿主环境中不必要和有潜在风险的环境变量进入编译环境
# cat > ~/.bash_profile << "EOF"
# exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
# EOF

# 新的 shell 实例是 非登录 shell，它不会读取和执行 /etc/profile 或者 .bash_profile 的内容
# 而是读取并执行 .bashrc 文件
# cat > ~/.bashrc << "EOF"
# set +h
# umask 022
# LFS=/mnt/lfs
# LC_ALL=POSIX
# LFS_TGT=$(uname -m)-lfs-linux-gnu
# PATH=/usr/bin
# if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
# PATH=$LFS/tools/bin:$PATH
# export LFS LC_ALL LFS_TGT PATH
# EOF

# 为了完全准备好编译临时工具的环境，指示 shell 读取刚才创建的配置文件
# source ~/.bash_profile
