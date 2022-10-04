from boto3 import resource, client
#from flask import Flask



def get_subnet():
    ec2 = resource('ec2', region_name="eu-central-1")
    return ec2.Subnet('subnet-0461fe2e1d6e601b1')

def main():
    subnet = get_subnet()
    print("List of resources in private_subnet_1")
    print(subnet.get_available_subresources())
    print("All:")
    print(subnet.instances.all())
    print("Monitoring:")
    print(subnet.instances.monitor(DryRun=True))

def unmain():
    clinet = client('ec2')
    print(client.describe_instances())


if __name__ == "__main__":
    main()
