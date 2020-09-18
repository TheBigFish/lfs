#!/bin/bash
set -e

# 配置 Make
./configure --prefix=/usr

# 编译 Make
make

# 测试 Make
# make check

# 安装 Make
make install
