## CPU篇

#### ps 命令

```sh
➜  ~ ps -aux            
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.2 171092 10776 ?        Ss   Oct12   0:55 /sbin/init
root           2  0.0  0.0      0     0 ?        S    Oct12   0:01 [kthreadd]
root           3  0.0  0.0      0     0 ?        I<   Oct12   0:00 [rcu_gp]
root           4  0.0  0.0      0     0 ?        I<   Oct12   0:00 [rcu_par_gp]
root           6  0.0  0.0      0     0 ?        I<   Oct12   0:00 [kworker/0:0H-kblockd]
root           8  0.0  0.0      0     0 ?        I<   Oct12   0:00 [mm_percpu_wq]
root           9  0.0  0.0      0     0 ?        S    Oct12   0:02 [ksoftirqd/0]
root          10  0.0  0.0      0     0 ?        I    Oct12  22:55 [rcu_sched]
root          11  0.0  0.0      0     0 ?        S    Oct12   0:12 [migration/0]
root          12  0.0  0.0      0     0 ?        S    Oct12   0:00 [idle_inject/0]
root          14  0.0  0.0      0     0 ?        S    Oct12   0:00 [cpuhp/0]
root          15  0.0  0.0      0     0 ?        S    Oct12   0:00 [cpuhp/1]
```

#### 进程id最大值

```sh
➜  ~ sysctl -a |grep pid_max
kernel.pid_max = 4194304
```

