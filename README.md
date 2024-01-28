# CODESYS Control for Linux Docker Configuration

Developed and tested under NixOS 23.11/x86_64.

Note: Settings from `/opt/codesys/scripts/init-vars` and `/opt/codesys/scripts/init-functions` will not be evaluated!

## NixOS configuration

```nix
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      codesyscontrol = {
        image = "cscontrol:4.10.0.0";
        volumes = [
          "/dev:/dev"
          "/var/lib/codesys:/var/opt"
        ];
        extraOptions = [ "--privileged" "--network=host" ];
      };
    };
  };
```

## Better approaches

Docker is not really necessary, I suspect. More light-weight integrations might be:

* patchelf
  * https://nixos.wiki/wiki/Packaging/Binaries
* FHSUserEnv
  * https://reflexivereflection.com/posts/2015-02-28-deb-installation-nixos.html

## docker logs example output

```
2024-01-26 14:28:18,846 INFO Set uid to user 0 succeeded
2024-01-26 14:28:18,852 INFO supervisord started with pid 1
2024-01-26 14:28:19,857 INFO spawned: 'codemeter' with pid 7
2024-01-26 14:28:19,863 INFO spawned: 'codemeter-webadmin' with pid 8
2024-01-26 14:28:19,869 INFO spawned: 'codesyscontrol' with pid 9
2024-01-26 14:28:19: proxy: system proxy - host: '', user: ''
2024-01-26 14:28:19: Named User: License Tracking not activated
2024-01-26 14:28:20: CodeMeter for Linux (B7.60.5625.503.64.1405)
2024-01-26 14:28:20: Running on Debian GNU/Linux 11.8 (Kernel 6.1.71)
2024-01-26 14:28:20: CodeMeter runs inside a container, e.g. Docker.
2024-01-26 14:28:20: Execution path: /usr/sbin
2024-01-26 14:28:20: Found IPv4 address: <redacted>
2024-01-26 14:28:20: Found IPv6 address: <redacted>
2024-01-26 14:28:20: Used Communication Mode (Client): IPv6 IPv4
2024-01-26 14:28:20: Used Communication Mode (Server): IPv6 IPv4
2024-01-26 14:28:20: Used IP address: default address
2024-01-26 14:28:20: Used IP port: 22350
2024-01-26 14:28:20: Used CmWAN port: 22351
2024-01-26 14:28:20: Run as network server: no
2024-01-26 14:28:20: Run as CmWAN server: no
2024-01-26 14:28:20: Run as system service: yes
2024-01-26 14:28:20: TMR-Mode: disabled
2024-01-26 14:28:20: CodeMeterAct diagnosis is disabled.
2024/01/26 14:28:20 Running in CM mode
2024/01/26 14:28:20 Starting HTTP-Server...
	HTTP:Listening on port 22352...
2024-01-26 14:28:20: UBL-Trace Port USB:
2024-01-26 14:28:20: The list of available CmContainers has been updated!
2024-01-26 14:28:20: Error (curl-easy): Couldn't connect to server

2024-01-26 14:28:20,332 INFO reaped unknown pid 33 (exit status 127)
2024-01-26 14:28:20,333 INFO reaped unknown pid 36 (exit status 127)
2024-01-26 14:28:20: The list of available CmContainers has been updated!
2024-01-26 14:28:20: HashTree opened ok.
2024-01-26 14:28:20: The list of available CmContainers has been updated!
2024-01-26 14:28:20: The list of available CmContainers has been updated!
2024-01-26 14:28:20: Server ready
2024-01-26 14:28:20: Startup duration: 1 seconds
2024-01-26 14:28:20: Access from local(IPV4) to SubSystem (Handle 16)
2024-01-26 14:28:20: Handle 16 released
2024-01-26 14:28:20: Entry (6000437:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:20: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:20: Entry (101597:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:20: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:20: Entry (5000304:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:20: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:20: Entry (6000437:12289) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with NoUserLimit
2024-01-26 14:28:20: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:20: Access from local(IPV4) to SubSystem (Handle 21)
2024-01-26 14:28:20: API Event WB201 (BOX NOT FOUND) occurred (returned to caller)
2024-01-26 14:28:20: Handle 21 released
2024-01-26 14:28:20: Access from local(IPV4) to SubSystem (Handle 22)
2024-01-26 14:28:20: Access from local(IPV4) to SubSystem (Handle 23)
2024-01-26 14:28:20,904 INFO success: codemeter entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2024-01-26 14:28:20,904 INFO success: codemeter-webadmin entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2024-01-26 14:28:20,904 INFO success: codesyscontrol entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2024-01-26 14:28:21: Entry (6000437:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:21: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:21: Entry (101597:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:21: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:21: Entry (5000304:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:28:21: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:21: Entry (6000437:12289) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with NoUserLimit
2024-01-26 14:28:21: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:28:22: Removable Device has been plugged IN/OUT!
2024-01-26 14:28:22: UBL-Trace Port USB:
2024-01-26 14:28:22: The list of available CmContainers has been updated!
2024-01-26 14:28:22: The list of available CmContainers has been updated!
2024-01-26 14:29:22: Entry (6000437:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:29:22: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:29:22: Entry (101597:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:29:22: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:29:22: Entry (5000304:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:29:22: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:29:22: Entry (6000437:12289) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with NoUserLimit
2024-01-26 14:29:22: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:30:22: Entry (6000437:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:30:22: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:30:23: Entry (101597:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:30:23: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:30:23: Entry (5000304:8755) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with UserLimit
2024-01-26 14:30:23: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:30:23: Entry (6000437:12289) not found - Event WB0200 (ENTRY NOT FOUND), Request IP-Address local(IPV4) with NoUserLimit
2024-01-26 14:30:23: API Error 200 (ENTRY NOT FOUND) occurred!
2024-01-26 14:31:23: <...>
```

## Other implementations

* https://github.com/joyja/docker-codesys-control
* https://github.com/HilscherAutomation/netPI-codesys-basis
* https://forge.codesys.com/tol/codesys-4-linux/docker/ci/master/tree/codesys-control/
