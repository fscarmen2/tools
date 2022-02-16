name: Test
on:
  workflow_dispatch:

  push:
    branches:
      - '*'
    paths:
      - '**'
      - '!**.md'

  pull_request:
    branches:
      - '*'
    paths:
      - '**'
      - '!**.md'


jobs:
  Ubuntu:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Build image
      run: docker build -t wg . -f Dockerfile
    - name: Test single container
      run:  |
      	docker run -dit --restart=always --cap-add net_admin --cap-add sys_module --log-opt max-size=1m -v /lib/modules:/lib/modules fscarmen/netfilx_unlock:latest

        
        
        
        
        docker run --rm -id \
        --name wgcf \
        --sysctl net.ipv6.conf.all.disable_ipv6=0 \
        --privileged --cap-add net_admin \
        --cap-add sys_module \
        --log-opt max-size=1m \
        -v /lib/modules:/lib/modules \
        fscarmen/netfilx_unlock:latest
        while ! docker logs wgcf | grep "route.go"; do
          echo wait
          sleep 1
        done
        docker exec -i wgcf curl -4 ipget.net
        docker exec -i wgcf curl -4 ip.gs
        docker run --rm   --network container:wgcf  curlimages/curl curl -4 ipget.net
        docker run --rm   --network container:wgcf  curlimages/curl curl -4 ip.gs
        docker stop wgcf