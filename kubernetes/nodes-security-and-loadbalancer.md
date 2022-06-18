### master node security group
    Priority Name               Port        Protocol        Source              Destination action
    300      SSH                22          TCP             156.198.130.216     Any         allow
    320      Port_6443          6443        Any             10.1.0.0/16         Any         Allow
    330      Port_2379-2380     2379-2380   Any             10.1.0.0/16         Any         Allow
    340      Port_10250-10252   10250-10252 Any             10.1.0.0/16         Any         Allow

### worker node security group
    Priority Name               Port        Protocol        Source              Destination action
    300      SSH                22          TCP             156.198.130.216     Any         allow
    310      Port_10250         10250       Any             10.1.0.0/16         Any         Allow
    320      Port_30000-32767   30000-32767 Any             Any                 Any         Allow

### loadBalancer
    1. configure load balancer and add the worker node in the backend pool
    2. add dns name for the load balancer ip
    3. create a load balancing rule to forward the traffic to the backend pool on port 31519 (ingress controller is listening on this port for http traffic)
