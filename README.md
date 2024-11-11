# SRSRAN gNb

The `aether-srsran` repository allows SRSRAN (both physical and simulated) to work with the Aether core using Docker.
It has been tested in simulation mode.

To download the 'aether-srsran' repository, use the following command:
```
git clone https://github.com/opennetworkinglab/aether-srsran.git
```

## Step-by-Step Installation
To install srsran-gNb, follow these steps:

1. Install Docker by running `make srsran-docker-install`.
   Note: If docker already installed then ignore this step
2. Configure the network for srsran-gNb:
   - Set the "data_iface" parameter to the network interface name of the machine.
   - Set "network.name" to the name of the Docker network to be created.
   - Set "network.bridge.name" to the name of the interface to be created.
   - Set "subnet", which should correspond to the "ran_subnet" of 5g-core or the machine's subnet.
   - run `srsran-router-install` to create the network.
      - To remove the network, run `srsran-router-uninstall`.
3. Start the SRSRAN-gNb Docker containers:
   - Set the container image "gnb_image" for gNb.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for coresponding conf file for gNb i.e for simulation.
   - Set "ip" for gNb container, it should in same subnet as network.
   - Set "core.amf.ip" with IP address of Aether core.
   - Start docker container using `make srsran-gnb-install`.
      - To stop the gNb, run `make srsran-gnb-stop`.
4. Start the UE simulation:
   - Set the container image "ue_image" for UeSimulation.
   - Set "network" same as the network name used for gNb.
   - Set "gnb.ip" with the IP address of the gNb container.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for coresponding conf file for UeSimulation.
   - Run `make srsran-uesim-start`.
      - To stop the UE simulation, run `make srsran-uesim-stop`.
5. Check the results:
   - Enter the UE Docker container using `docker exec -it rfsim5g-srsran-nr-ue bash`.
   - Use `ip netns exec ue1 ping -c 5 192.168.250.1` to view the success result.

### One-Step Installation
To install SRSRAN gNb in one go, run `make aether-srsran-gnb-install`.

### Uninstall
To uninstall SRSRAN gNb, run `make aether-srsran-gnb-uninstall`.
