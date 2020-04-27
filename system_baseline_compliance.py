import sys
import os
import socket
import subprocess
import datetime
from argparse_prompt import PromptParser
import logging
import json
import redfish.ris.gen_compat
from redfish import AuthMethod, redfish_logger, RedfishClient, LegacyRestClient

# Config logger used by HPE Restful library
LOGGERFILE = "ILO_API.log"
LOGGERFORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
LOGGER = redfish_logger(LOGGERFILE, LOGGERFORMAT, logging.INFO)
LOGGER.info("Restful API logs")


class ilo5RedfishObj(object):
    """
    Redfish client object for iLO5 connection only.
    """

    def __init__(self, host, login_account, login_password):
        try:
            self.RedfishClient = RedfishClient(
                base_url=host, username=login_account, password=login_password)
        except:
            raise
        self.typepath = redfish.ris.gen_compat.Typesandpathdefines()
        self.typepath.getgen(url=host, logger=LOGGER)
        self.typepath.defs.redfishchange()
        self.RedfishClient.login(auth=AuthMethod.SESSION)
        self.SYSTEMS_RESOURCES = self.get_resource_directory()
        self.MESSAGE_REGISTRIES = self.get_base_registry()
        self.SN = self.get_sn()
        self.model = self.get_model()
        self.ilo_version = self.check_ilo_version()
        self.bios = {"data": None, "type": "bios"}
        self.fw_inventory = {"data": None, "type": "firmware_inventory"}

    def check_ilo_version(self):
        """
        Determine iLO firmware version by checking the iLO firmware version string.
        """
        response = self.redfish_get("/redfish/v1/Managers/1/")
        ilo_version = response.dict["FirmwareVersion"]
        if "iLO 4" in ilo_version:
            return 4
        elif "iLO 5" in ilo_version:
            return 5
        else:
            return -1

    def logout(self):
        self.RedfishClient.logout()

    def get_resource_directory(self):
        """
        Retrieve the top level resource directory through iLO Redfish REST API.
        """
        response = self.redfish_get("/redfish/v1/resourcedirectory/")
        resources = {}
        if response.status == 200:
            resources["resources"] = response.dict["Instances"]
            return resources
        else:
            sys.stderr.write(
                "\tResource directory missing at /redfish/v1/resourcedirectory" + "\n")

    def search_for_type(self, type):
        """
        Search and retrieve the specific "type" resource from the resource directory.
        """
        instances = []
        for item in self.SYSTEMS_RESOURCES["resources"]:
            foundsettings = False
            if "@odata.type" in item and type.lower() in item["@odata.type"].lower():
                for entry in self.SYSTEMS_RESOURCES["resources"]:
                    if (item["@odata.id"] + "settings/").lower() == (entry["@odata.id"]).lower():
                        foundsettings = True

                if not foundsettings:
                    instances.append(item)
        if not instances:
            sys.stderr.write(
                "\t'%s' resource or feature is not supported on this system\n" % type)
        return instances

    def redfish_get(self, suburi):
        """REDFISH GET"""
        return self.RedfishClient.get(path=suburi)

    def get_base_registry(self):
        response = self.redfish_get("/redfish/v1/Registries/")
        messages = {}
        location = None
        for entry in response.dict["Members"]:
            if not [x for x in ["/Base/", "/iLO/"] if x in entry["@odata.id"]]:
                continue
            else:
                registry = self.redfish_get(entry["@odata.id"])
            for location in registry.dict["Location"]:
                if "extref" in location["Uri"]:
                    location = location["Uri"]["extref"]
                else:
                    location = location["Uri"]
                reg_resp = self.redfish_get(location)
                if reg_resp.status == 200:
                    messages[reg_resp.dict["RegistryPrefix"]
                             ] = reg_resp.dict["Messages"]
                else:
                    sys.stdout.write(
                        "\t" + reg_resp.dict["RegistryPrefix"] + " not found at " + location + "\n")
        return messages

    def get_sn(self):
        '''
        Retrieve iLO serial number.
        '''
        res = self.redfish_get('/redfish/v1/systems/1/')
        if "SerialNumber" in res.dict.keys():
            sn = res.dict["SerialNumber"]
            return sn
        else:
            raise Exception(
                "Could not get iLo serial number. Serial number not found in data model")

    def get_model(self):
        '''
        Retrieve system model.
        '''
        res = self.redfish_get('/redfish/v1/systems/1/')
        if "Model" in res.dict.keys():
            model = res.dict["Model"]
            model = model.replace(" ", "_")
            return model
        else:
            raise Exception("Could not retrieve model.")

    def download_bios_settings(self):
        """
        Retrieve BIOS configs from iLO. The BIOS configs are by default in dictionary format.
        """
        href = self.search_for_type("Bios.")[0]["@odata.id"]
        temp = self.redfish_get(href)
        data = temp.dict["Attributes"]
        return data

    def download_fw_inventory(self):
        """
        Retrieve firmware inventory from iLO. Returns a firmware inventory dictionary, with device description as the keys, and the values contain only the device name and the firmware versions. If the device does not have a description, for an example, the disk drives, create a custom key from the device name and the device ID number.
        """
        href = self.search_for_type("UpdateService.")[0]["@odata.id"]
        temp = self.redfish_get(href)
        odata_link = temp.dict["FirmwareInventory"]
        temp = self.redfish_get(odata_link["@odata.id"])
        members = temp.dict["Members"]
        firmware_inventory = {}
        for member in members:
            temp = self.redfish_get(member["@odata.id"])
            temp = temp.dict
            device_id = temp["Name"] + temp["Id"]
            description = temp.pop("Description", None)
            if len(description) == 0:
                description = device_id
            temp.pop("@odata.context", None)
            temp.pop("@odata.etag", None)
            temp.pop("@odata.id", None)
            temp.pop("Oem", None)
            temp.pop("@odata.type", None)
            temp.pop("Status", None)
            temp.pop("Id")
            firmware_inventory[description] = temp
        return firmware_inventory


class ilo4RedfishObj(object):
    '''
    REST client object for Gen9 and Gen8 systems with iLO4.
    '''

    def __init__(self, host, login_account, login_password):
        self.LegacyRestClient = LegacyRestClient(
            base_url=host, username=login_account, password=login_password)
        self.LegacyRestClient.login(auth=AuthMethod.SESSION)
        self.SYSTEMS_RESOURCES = self.get_resource_directory()
        self.MESSAGE_REGISTRIES = self.get_base_registry()
        self.SN = self.get_sn()
        self.model = self.get_model()
        self.bios = {"data": None, "type": "bios"}
        self.fw_inventory = {"data": None, "type": "firmware_inventory"}

    def logout(self):
        self.LegacyRestClient.logout()

    def get_resource_directory(self):
        """
        Retrieve the top level resource directory through iLO REST API.
        """
        response = self.rest_get("/rest/v1/resourcedirectory")
        resources = {}
        if response.status == 200:
            resources["resources"] = response.dict["Instances"]
            return resources
        else:
            sys.stderr.write(
                "\tResource directory missing at /rest/v1/resourcedirectory\n")

    def rest_get(self, suburi):
        """REST GET"""
        return self.LegacyRestClient.get(path=suburi)

    def search_for_type(self, type):
        """
        Search and retrieve the specific "type" resource from the resource directory.
        """
        instances = []
        for item in self.SYSTEMS_RESOURCES["resources"]:
            foundsettings = False
            if type and type.lower() in item["Type"].lower():
                for entry in self.SYSTEMS_RESOURCES["resources"]:
                    if (item["href"] + "/settings").lower() == (entry["href"]).lower():
                        foundsettings = True
                if not foundsettings:
                    instances.append(item)
        if not instances:
            sys.stderr.write(
                "\t'%s' resource or feature is not supported on this system\n" % type)
        return instances

    def get_base_registry(self):
        response = self.rest_get("/rest/v1/Registries")
        messages = {}
        identifier = None
        for entry in response.dict["Items"]:
            if "Id" in entry:
                identifier = entry["Id"]
            else:
                identifier = entry["Schema"].split(".")[0]
            if identifier not in ["Base", "iLO"]:
                continue
            for location in entry["Location"]:
                reg_resp = self.rest_get(location["Uri"]["extref"])
                if reg_resp.status == 200:
                    messages[identifier] = reg_resp.dict["Messages"]
                else:
                    sys.stdout.write(
                        "\t" + identifier + " not found at " + location["Uri"]["extref"] + "\n")
        return messages

    def get_model(self):
        '''
        Retrieve system model information.
        '''
        res = self.rest_get('/redfish/v1/systems/1/')
        if "Model" in res.dict.keys():
            model = res.dict["Model"]
            model = model.replace(" ", "_").strip()
            return model
        else:
            raise Exception("Could not retrieve model.")

    def get_sn(self):
        '''
        Retrieve iLO serial number.
        '''
        res = self.rest_get('/redfish/v1/systems/1/')
        if "SerialNumber" in res.dict.keys():
            sn = res.dict["SerialNumber"].strip()
            return sn
        else:
            raise Exception(
                "Could not get iLo serial number. Serial number not found in data model")

    def download_bios_settings(self):
        """
        Retrieve BIOS configs from iLO.
        """
        href = self.search_for_type("Bios.")[0]['href']
        temp = self.rest_get(href)
        data = temp.dict
        del data["links"]
        return data

    def download_fw_inventory(self):
        """
        Retrieve firmware inventory from iLO. Returns a firmware inventory dictionary, with device description as the keys, and the values contain only the device name and the firmware version strings. If the device contains multiple sub devices, create a custom key from the device location and the device name.
        """
        href = self.search_for_type("FwSwVersionInventory.")[0]['href']
        temp = self.rest_get(href)
        data = temp.dict["Current"]
        keys = data.keys()
        fw_inventory = {}
        for key in keys:
            # nested list found. Iterate through each item in the list.
            if len(data[key]) > 1:
                for item in data[key]:
                    new_key = item["Location"].replace(
                        " ", "_") + "_" + item["Name"].replace(" ", "_")
                    fw_inventory[new_key] = {
                        "Name": item["Name"], "Version": item["VersionString"]}
            else:
                fw_inventory[key] = {
                    "Name": data[key][0]["Name"], "Version": data[key][0]["VersionString"]}
        return fw_inventory


def read_ilo_creds():
    """
    Read in user input for iLO IP address, username, and password using argparse. Check if the IP address or FQDN are valid, for both iLO5 and iLO4.
    """
    parser = PromptParser()
    parser.add_argument('-p', '--password', help='iLO login password',
                        required=True, secure=True)
    parser.add_argument(
        '-i', '--iloip', help='iLO IP address or FQDN (without http:// or https:// and any trailing /)', required=True)
    parser.add_argument('-u', '--username',
                        help='iLO login name', required=True)
    args = parser.parse_args()
    if is_valid_ipv4_address(args.iloip):
        # Return the iLO login information if the IP/FQDN can be resolved and able to respond to ping
        ilo_access = {
            "ip": "https://{ip}".format(ip=args.iloip),
            "username": args.username,
            "password": args.password
        }
        return ilo_access
    else:
        raise Exception(
            "The iLO IP address or FQDN either failed to be resolved, incorrectly formatted, or failed to respond to pings")


def download_configs(ilo_ip, username, password):
    """
    This method creates a redfish client object for gen10 iLO5 system and REST client object for and gen9 and gen8 iLO4s, and then downloads and saves the system BIOS settings and the firmware inventory to separate JSON files onto the current working directory.
    """
    iLO_obj = ilo5RedfishObj(host=str(ilo_ip), login_account=str(
        username), login_password=str(password))
    if iLO_obj.ilo_version == 4:  # iLO 4 found. Log out iLO 5 Redfish and login in again with iLO 4 REST API
        iLO_obj.logout()
        iLO_obj = ilo4RedfishObj(
            host=ilo_ip, login_account=username, login_password=password)
        print("iLO serial number: {sn}".format(sn=iLO_obj.SN))
        iLO_obj.download_bios_settings()
        iLO_obj.download_fw_inventory()
        iLO_obj.logout()
        return 0
    elif iLO_obj.ilo_version == -1:
        raise Exception("iLO verison not identified")
    print("iLO serial number: {sn}".format(sn=iLO_obj.SN))
    iLO_obj.download_bios_settings()
    iLO_obj.download_fw_inventory()
    iLO_obj.logout()
    return 0


def is_valid_ipv4_address(address):
    """
    Takes an IP address or a FQDN, without the 'https://' prefix. Return True if the address can be resolved, is formatted correctly, and able to respond to pings. Return False otherwise.
    """
    try:
        my_ip = socket.gethostbyname(address)
        try:
            socket.inet_aton(my_ip)
            try:
                # Test pinging the IP once, timeout at 100 ms
                timeout = 200  # ms
                cmd = ["ping", my_ip, "-n", "1", "-w", str(timeout)]
                return_code = subprocess.call(cmd, stdout=subprocess.DEVNULL)
                if return_code == 0:
                    return True
                else:
                    print("Unable to ping the IP")
                    return False
            except:
                print("Failed to execute ping")
                return False
        except:
            print("IP not correctly formatted")
            return False
    except:
        print("gethostbyname failed. Try another IP or FQDN.")
        return False


def read_json_file(file_path):
    data = None
    with open(file_path) as json_file:
        data = json.load(json_file)
    return data


def read_latest_baseline(type=None, sn=None, path=None):
    """
    Check for baseline JSON files either BIOS of firmware inventory (type) for a specific serial number in the path directory. Read in the JSON file and return the JSON content. If file does not exist, then return None.
    """
    results = []
    for root, dirs, files in os.walk(path):
        for filename in files:
            if sn in filename and type in filename and "diff" not in filename:
                # For windows system only
                results.append("{path}".format(path=root+"\\"+filename))
    if len(results) <= 0:
        return (None, None)
    results = sorted(results, reverse=True)
    latest_baseline = results[0]
    print("Latests baseline: {file}".format(file=latest_baseline))
    data = read_json_file(latest_baseline)
    return (data, latest_baseline)


def save_baseline(json_data=None, model=None, sn=None, type=None, ilo_version=None):
    """
    Save JSON data to current working direcotry. The file name contains the iLO serial number, system model, and current date time.
    """
    pwd = os.getcwd()
    filename = '{model}_iLO{ilo_version}_{serialnumber}_{type}_{datetime}.json'.format(
        model=model, ilo_version=ilo_version, serialnumber=sn, type=type, datetime=datetime.datetime.now().strftime("%Y%m%d-%H%M%S"))
    print(
        "Save baselines to {path}/{filename}".format(path=pwd, filename=filename))
    with open(filename, 'w') as fp:
        json.dump(json_data, fp, sort_keys=True,
                  indent=4, separators=(',', ': '))


def compare_bios_baseline(baseline=None, system_settings=None, baseline_filename=None):
    """
    Compare system settings in JSON to a BIOS baseline in JSON. Returns a discrepency JSON if there is any, else return None. For both iLO5 and iLO4.
    """
    diff_flag = False  # Set to True if discrepency found
    all_keys = []
    for key in system_settings.keys():
        all_keys.append(key)
    for key in baseline.keys():
        all_keys.append(key)
    all_keys = set(all_keys)
    diff_data = {}
    diff_data["baseline_file_input"] = baseline_filename
    for key in all_keys:
        try:
            system_data = system_settings[key]
        except KeyError:
            system_data = None
        try:
            baseline_data = baseline[key]
        except KeyError:
            baseline_data = None
        if system_data == baseline_data:
            pass
        else:
            diff_data[key] = {"baseline_file": baseline_data,
                              "current_system": system_data}
            diff_flag = True
    return (diff_data, diff_flag)


def compare_fw_baseline(baseline=None, system_settings=None, baseline_filename=None):
    """
    Compare system firmware settings in JSON to a firmware inventory in JSON. Returns a discrepency JSON if there is any, else return None. For both iLO5 and iLO4.
    """
    diff_flag = False
    all_keys = []
    for key in system_settings.keys():
        all_keys.append(key)
    for key in baseline.keys():
        all_keys.append(key)
    all_keys = set(all_keys)
    diff_data = {}
    diff_data["baseline_file_input"] = baseline_filename
    for key in all_keys:
        try:
            system_data = system_settings[key]
        except KeyError:
            system_data = {"Name": None, "Version": None}
        try:
            baseline_data = baseline[key]
        except KeyError:
            baseline_data = {"Name": None, "Version": None}
        if system_data["Name"] == baseline_data["Name"] and system_data["Version"] == baseline_data["Version"]:
            pass
        else:
            diff_data[key] = {"baseline_file": baseline_data,
                              "current_system": system_data}
            diff_flag = True
    return (diff_data, diff_flag)


def baseline_compliances(ilo_ip, username, password):
    """
    This method compares the iLO system settings against a JSON baseline file saved at the current working directory, for BIOS configs and firmware inventory, for iLO5 and iLO4. If multiple BIOS and firmware JSONs found in the directory, the method only reads in the baseline file with the latest timestamp. If discrepency found, this method saves a discprency report in JSON and create separate JSON files for each of the BIOS and firmware inventory. Otherwise, if discrpency not detected, it only saves JSON files for BIOS configs and for firwmare inventory, no discrepency report.
    """
    iLO_obj = None
    try:
        iLO_obj = ilo5RedfishObj(host=str(ilo_ip), login_account=str(
            username), login_password=str(password))
    except redfish.rest.v1.InvalidCredentialsError:
        raise Exception(
            "iLO login failed. Check username and password. Script exited.")
    if iLO_obj.ilo_version == 4:  # iLO 4 found. Log out iLO 5 Redfish and login in again with iLO 4 REST API
        iLO_obj.logout()
        try:
            iLO_obj = ilo4RedfishObj(
                host=ilo_ip, login_account=username, login_password=password)
        except redfish.rest.v1.InvalidCredentialsError:
            raise Exception(
                "iLO login failed. Check username and password. Script exited.")
        iLO_obj.bios["data"] = iLO_obj.download_bios_settings()
        iLO_obj.fw_inventory["data"] = iLO_obj.download_fw_inventory()
        print("iLO serial number: {sn}".format(sn=iLO_obj.SN))
        path = os.getcwd()
        (bios_baseline_json, latest_bios_baseline) = read_latest_baseline(
            type=iLO_obj.bios["type"], sn=iLO_obj.SN, path=path)
        if bios_baseline_json:
            (bios_diff_json, diff_found) = compare_bios_baseline(baseline=bios_baseline_json,
                                                                 system_settings=iLO_obj.bios["data"], baseline_filename=latest_bios_baseline)
            if diff_found:
                save_baseline(json_data=bios_diff_json, model=iLO_obj.model,
                              ilo_version="4", type=iLO_obj.bios["type"]+"_diff", sn=iLO_obj.SN)
        (fw_baseline_json, latest_fw_baseline) = read_latest_baseline(
            type=iLO_obj.fw_inventory["type"], sn=iLO_obj.SN, path=path)
        if fw_baseline_json:
            (fw_inventory_diff_json, diff_found) = compare_fw_baseline(baseline=fw_baseline_json,
                                                                       system_settings=iLO_obj.fw_inventory["data"], baseline_filename=latest_fw_baseline)
            if diff_found:
                save_baseline(json_data=fw_inventory_diff_json, model=iLO_obj.model,
                              ilo_version="4", type=iLO_obj.fw_inventory["type"]+"_diff", sn=iLO_obj.SN)
        save_baseline(json_data=iLO_obj.bios["data"], model=iLO_obj.model,
                      ilo_version="4", type=iLO_obj.bios["type"], sn=iLO_obj.SN)
        save_baseline(json_data=iLO_obj.fw_inventory["data"], model=iLO_obj.model,
                      ilo_version="4", type=iLO_obj.fw_inventory["type"], sn=iLO_obj.SN)
        iLO_obj.logout()
        return 0
    elif iLO_obj.ilo_version == -1:
        raise Exception("iLO verison not identified")
    iLO_obj.bios["data"] = iLO_obj.download_bios_settings()
    iLO_obj.fw_inventory["data"] = iLO_obj.download_fw_inventory()
    print("iLO serial number: {sn}".format(sn=iLO_obj.SN))
    path = os.getcwd()
    # print(path)
    (bios_baseline_json, latest_bios_baseline) = read_latest_baseline(
        type=iLO_obj.bios["type"], sn=iLO_obj.SN, path=path)
    if bios_baseline_json:
        (bios_diff_json, diff_found) = compare_bios_baseline(baseline=bios_baseline_json,
                                                             system_settings=iLO_obj.bios["data"], baseline_filename=latest_bios_baseline)
        if diff_found:
            save_baseline(json_data=bios_diff_json, model=iLO_obj.model,
                          ilo_version=iLO_obj.ilo_version, type=iLO_obj.bios["type"]+"_diff", sn=iLO_obj.SN)
    (fw_baseline_json, latest_fw_baseline) = read_latest_baseline(
        type=iLO_obj.fw_inventory["type"], sn=iLO_obj.SN, path=path)
    if fw_baseline_json:
        (fw_inventory_diff_json, diff_found) = compare_fw_baseline(baseline=fw_baseline_json,
                                                                   system_settings=iLO_obj.fw_inventory["data"], baseline_filename=latest_fw_baseline)
        if diff_found:
            save_baseline(json_data=fw_inventory_diff_json, model=iLO_obj.model,
                          ilo_version=iLO_obj.ilo_version, type=iLO_obj.fw_inventory["type"]+"_diff", sn=iLO_obj.SN)
    save_baseline(json_data=iLO_obj.bios["data"], model=iLO_obj.model,
                  ilo_version=iLO_obj.ilo_version, type=iLO_obj.bios["type"], sn=iLO_obj.SN)
    save_baseline(json_data=iLO_obj.fw_inventory["data"], model=iLO_obj.model,
                  ilo_version=iLO_obj.ilo_version, type=iLO_obj.fw_inventory["type"], sn=iLO_obj.SN)
    iLO_obj.logout()
    return 0


if __name__ == "__main__":
    try:
        iLO_creds = read_ilo_creds()
        print(iLO_creds["ip"])
        #download_configs(ilo_ip=iLO_creds["ip"], username=iLO_creds["username"], password=iLO_creds["password"])
        baseline_compliances(
            ilo_ip=iLO_creds["ip"], username=iLO_creds["username"], password=iLO_creds["password"])
    except Exception as err:
        print(err)
