import sys, os, socket
from argparse_prompt import PromptParser
import logging
import json
import redfish.ris.tpdefs
from redfish import AuthMethod, redfish_logger, redfish_client, rest_client

#Config logger used by HPE Restful library
LOGGERFILE = "ILO_API.log"
LOGGERFORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
LOGGER = redfish_logger(LOGGERFILE, LOGGERFORMAT, logging.INFO)
LOGGER.info("HPE Restful API logs")

class Gen10RedfishObj(object):
    def __init__(self, host, login_account, login_password):
        try:
            self.redfish_client = redfish_client(base_url=host, username=login_account, password=login_password)
        except:
            raise
        self.typepath = redfish.ris.tpdefs.Typesandpathdefines()
        self.typepath.getgen(url=host, logger=LOGGER)
        self.typepath.defs.redfishchange()
        self.redfish_client.login(auth=AuthMethod.SESSION)
        self.SYSTEMS_RESOURCES = self.get_resource_directory()
        self.MESSAGE_REGISTRIES = self.get_base_registry()
        self.SN = self.get_sn()
        self.model = self.get_model()
        self.ilo_version = self.check_ilo_version()

    def check_ilo_version(self):
        """
        Determine iLO firmware version by checking the iLO firmware version stringg.
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
        #print("Redfish log out")
        self.redfish_client.logout()

    def get_resource_directory(self):
        response = self.redfish_get("/redfish/v1/resourcedirectory/")
        resources = {}
        if response.status == 200:
            resources["resources"] = response.dict["Instances"]
            return resources
        else:
            sys.stderr.write("\tResource directory missing at /redfish/v1/resourcedirectory" + "\n")

    def search_for_type(self, type):
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
            sys.stderr.write("\t'%s' resource or feature is not supported on this system\n" % type)
        return instances

    def redfish_get(self, suburi):
        """REDFISH GET"""
        return self.redfish_client.get(path=suburi)  
    
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
                    messages[reg_resp.dict["RegistryPrefix"]] = reg_resp.dict["Messages"]
                else:
                    sys.stdout.write("\t" + reg_resp.dict["RegistryPrefix"] + " not found at " + location + "\n")
        return messages

    def get_sn(self):
        '''
        Retrieve iLO serial number
        '''
        res = self.redfish_get('/redfish/v1/systems/1/')
        #print(res)
        if "SerialNumber" in res.dict.keys():
            sn = res.dict["SerialNumber"]
            #print(sn)
            return sn
        else:
            raise Exception("Could not get iLo serial number. Serial number not found in data model")
    
    def get_model(self):
        '''
        Retrieve system information
        '''
        res = self.redfish_get('/redfish/v1/systems/1/')
        #print(res)
        if "Model" in res.dict.keys():
            model = res.dict["Model"]
            model = model.replace(" ", "_")
            #print(model)
            return model
        else:
            raise Exception("Could not retrieve model.")

    def download_bios_settings(self):
        href = self.search_for_type("Bios.")[0]["@odata.id"]
        #print(href)
        temp = self.redfish_get(href)
        data = temp.dict["Attributes"]
        #print(data)
        pwd = os.getcwd()
        filename = '{model}_iLO5_{serialnumber}_bios.json'.format(model=self.model,serialnumber=self.SN)
        print("Save BIOS settings to {path}/{filename}".format(path=pwd, filename=filename))
        with open(filename, 'w') as fp:
            json.dump(data, fp, sort_keys=True, indent=4, separators=(',', ': '))

    def download_fw_inventory(self):
        href = self.search_for_type("UpdateService.")[0]["@odata.id"]
        #print(href)
        temp = self.redfish_get(href)
        #print(temp.dict["FirmwareInventory"])
        odata_link = temp.dict["FirmwareInventory"]
        #print(fw_inventory_odata)
        temp = self.redfish_get(odata_link["@odata.id"])
        members = temp.dict["Members"]
        firmware_inventory = []
        for member in members:
            temp = self.redfish_get(member["@odata.id"])
            temp = temp.dict
            #print(temp)
            del temp["@odata.context"]
            del temp["@odata.etag"]
            del temp["@odata.id"]
            del temp["Oem"]
            #print(temp)
            firmware_inventory.append(temp)
        #print(firmware_inventory)
        pwd = os.getcwd()
        filename = '{model}_iLO5_{serialnumber}_firmware_inventory.json'.format(model=self.model,serialnumber=self.SN)
        print("Save firmware inventory to {path}/{filename}".format(path=pwd, filename=filename))
        with open(filename, 'w') as fp:
            json.dump(firmware_inventory, fp, sort_keys=True, indent=4, separators=(',', ': '))

class Gen9RestObj(object):
    '''
    This is for accessting the RESTful APIs for Gen9 system using the rest client from the Python ilorest library.
    '''
    def __init__(self, host, login_account, login_password):
        self.rest_client = rest_client(base_url=host, username=login_account, password=login_password)
        self.rest_client.login(auth=AuthMethod.SESSION)
        self.SYSTEMS_RESOURCES = self.get_resource_directory()
        self.MESSAGE_REGISTRIES = self.get_base_registry()
        self.SN = self.get_sn()
        self.model = self.get_model()

    def logout(self):
        #print("Rest logout")
        self.rest_client.logout()

    def get_resource_directory(self):
        response = self.rest_get("/rest/v1/resourcedirectory")
        resources = {}
        if response.status == 200:
            resources["resources"] = response.dict["Instances"]
            return resources
        else:
            sys.stderr.write("\tResource directory missing at /rest/v1/resourcedirectory\n")
    
    def rest_get(self, suburi):
        """REST GET"""
        return self.rest_client.get(path=suburi)
    
    def search_for_type(self, type):
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
            sys.stderr.write("\t'%s' resource or feature is not supported on this system\n" % type)
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
                    sys.stdout.write("\t" + identifier + " not found at " + location["Uri"]["extref"] + "\n")
        return messages
    
    def get_model(self):
        '''
        Retrieve system information
        '''
        res = self.rest_get('/redfish/v1/systems/1/')
        #print(res)
        if "Model" in res.dict.keys():
            model = res.dict["Model"]
            model = model.replace(" ", "_")
            #print(model)
            return model
        else:
            raise Exception("Could not retrieve model.")
    
    def get_sn(self):
        '''
        Retrieve iLO serial number
        '''
        res = self.rest_get('/redfish/v1/systems/1/')
        #print(res)
        if "SerialNumber" in res.dict.keys():
            sn = res.dict["SerialNumber"]
            #print(sn)
            return sn
        else:
            raise Exception("Could not get iLo serial number. Serial number not found in data model")

    def download_bios_settings(self):
        href = self.search_for_type("Bios.")[0]['href']
        #print(href)
        temp = self.rest_get(href)
        data = temp.dict
        del data["links"]
        pwd = os.getcwd()
        filename = '{model}_iLO4_{serialnumber}_bios.json'.format(model=self.model,serialnumber=self.SN)
        print("Save BIOS settings to {path}/{filename}".format(path=pwd, filename=filename))
        with open(filename, 'w') as fp:
            json.dump(data, fp, sort_keys=True, indent=4, separators=(',', ': '))
    
    def download_fw_inventory(self):
        href = self.search_for_type("FwSwVersionInventory.")[0]['href']
        #print(href)
        temp = self.rest_get(href)
        data = temp.dict["Current"]
        pwd = os.getcwd()
        filename = '{model}_iLO4_{serialnumber}_firmware_inventory.json'.format(model=self.model,serialnumber=self.SN)
        print("Save firmware inventory to {path}/{filename}".format(path=pwd, filename=filename))
        with open(filename, 'w') as fp:
            json.dump(data, fp, sort_keys=True, indent=4, separators=(',', ': '))

def read_ilo_creds():
    """
    Read in user input for iLO IP address, username, and password using argparse.
    """
    parser = PromptParser()
    parser.add_argument('--password', help='iLO login password', secure=True)
    parser.add_argument('--iloip', help='iLO IP address', required=True, prompt=False)
    parser.add_argument('--username', help='iLO login name', required=True, prompt=False) 
    args  = parser.parse_args()
    if is_valid_ipv4_address(args.iloip):
        ilo_access = {
            "ip": "https://{ip}".format(ip=args.iloip),
            "username": args.username,
            "password": args.password
        }
        return ilo_access
    else:
        raise Exception("User input error")
    

def download_configs(ilo_ip, username, password):
    """
    The master script to call gen10 and gen9 iLOs.
    """
    iLO_obj = Gen10RedfishObj(host=str(ilo_ip), login_account=str(username), login_password=str(password))
    if iLO_obj.ilo_version == 4: # iLO 4 found. Log out iLO 5 Redfish and login in again with iLO 4 REST API
        iLO_obj.logout()
        iLO_obj = Gen9RestObj(host=ilo_ip, login_account=username, login_password=password)
        print(iLO_obj.SN)
        iLO_obj.download_bios_settings()
        iLO_obj.download_fw_inventory()
        iLO_obj.get_model()
        iLO_obj.logout()
        return 0
    elif iLO_obj.ilo_version == -1:
        raise Exception("iLO verison not identified")
    print(iLO_obj.SN)
    iLO_obj.download_bios_settings()
    iLO_obj.download_fw_inventory()
    iLO_obj.get_model()
    iLO_obj.logout()
    return 0

def is_valid_ipv4_address(address):
    try:
        socket.inet_pton(socket.AF_INET, address)
    except AttributeError: # no inet_pton here, sorry
        try:
            socket.inet_aton(address)
        except socket.error:
            return False
        return address.count('.') == 3
    except socket.error: # not a valid address
        try: 
            socket.gethostbyname(address)
            return True
        except:    
            return False
    return True

def TEST_is_valid_ipv4_address():
    address = "FICRUX1HMJ.americas.hpqcorp.net" #Return True
    print("{address} is valid? {valid}".format(address=address, valid=is_valid_ipv4_address(address)))
    
    address = "127.0.0.1" # returns True
    print("{address} is valid? {valid}".format(address=address, valid=is_valid_ipv4_address(address)))
    
    address = "127.0.0" # returns False
    print("{address} is valid? {valid}".format(address=address, valid=is_valid_ipv4_address(address)))
    
    address = "runners-MacBook-Air.local" # returns True
    print("{address} is valid? {valid}".format(address=address, valid=is_valid_ipv4_address(address)))

if __name__ == "__main__":
    TEST_is_valid_ipv4_address()
    #iLO_creds = read_ilo_creds()
    #print(iLO_creds)
    #download_configs(ilo_ip=iLO_creds["ip"], username=iLO_creds["username"], password=iLO_creds["password"])
    

