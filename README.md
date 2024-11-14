# srsRAN gNB

The `aether-srsran` repository allows srsRAN (both physical and simulated) to work with the Aether core using Docker.
It has been tested in simulation mode.

To download the 'aether-srsran' repository, use the following command:
```
git clone https://github.com/opennetworkinglab/aether-srsran.git
```

## Step-by-Step Installation
To install srsran-gNB, follow these steps:

1. Install Docker by running `make srsran-docker-install`.
   Note: If docker already installed then ignore this step
2. Configure the network for srsran-gNB:
   - Set the "data_iface" parameter to the network interface name of the machine which runs gNB.
   - Set "network.name" to the name of the Docker network to be created.
   - Set "network.bridge.name" to the name of the interface to be created.
   - Set "subnet", which should correspond to the "ran_subnet" of 5g-core or the machine's subnet.
   - run `srsran-router-install` to create the network.
      - To remove the network, run `srsran-router-uninstall`.
3. Start the srsRAN-gNB Docker containers:
   - Set the container image "gnb_image" for gNB.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for corresponding conf file for gNB i.e for simulation.
   - Set "ip" for gNB container, it should in same subnet as network.
   - Set "core.amf.ip" with IP address of Aether core.
   - Start docker container using `make srsran-gnb-install`.
      - To stop the gNB, run `make srsran-gnb-stop`.
4. Start the UE simulation:
   - Set the container image "ue_image" for UeSimulation.
   - Set "network" same as the network name used for gNB.
   - Set "gnb.ip" with the IP address of the gNB container.
   - Set "simulation" to true to run in simulation mode.
   - Set "conf_file" path for corresponding conf file for UeSimulation.
   - Run `make srsran-uesim-start`.
      - To stop the UE simulation, run `make srsran-uesim-stop`.
5. Check the results:
   - Enter the UE Docker container using `docker exec -it rfsim5g-srsran-nr-ue bash`.
   - Use `ip netns exec ue1 ping -c 5 192.168.250.1` to view the success result.

### One-Step Installation
To install srsRAN gNB in one go, run `make aether-srsran-gnb-install`.

### Uninstall
To uninstall srsRAN gNB, run `make aether-srsran-gnb-uninstall`.
