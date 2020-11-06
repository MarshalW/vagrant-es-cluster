#!/bin/bash

# 防止elasticsearch exit 78, https://github.com/laradock/laradock/issues/1699
# 有效的设置，https://stackoverflow.com/a/54140948/3483986
# 参见：https://docs.actian.com/vector/4.2/index.html#page/User/Increase_max_map_count_Kernel_Parameter_(Linux).htm
# mmap的上限，上述说明每单位约128KB内存， 262144相当于32GB，一般足够了
echo 'vm.max_map_count=262144' >>/etc/sysctl.conf
sysctl -p

# elasticsearch Exited (137)，是因为申请内存大于系统内存而被docker kill container
# 从docker logs无法看到报错，需要下面命令：
# sudo journalctl -k | grep -i -e memory -e oom