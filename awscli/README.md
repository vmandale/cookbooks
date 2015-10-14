awscli Cookbook
===============
The cookbook can be used to download and install the latest awscli bundle on Linux machine. The cookbook is tested in Amazon Linux, RHEL, CentOS and Fedora.

Requirements
------------
As such there is not requirement of this cookbook because it will install all the required packages and then only setup the AWS CLI.

Attributes
----------
There are only four default attributes used as of now. The details are as below:

default[:awscli][:region] = 'us-west-2'
default[:awscli][:output] = 'json'
default[:awscli][:access_key] = ''
default[:awscli][:secret_access_key] = ''

1) The attribute "default[:awscli][:region]" is used to set the default region in Config file.
2) The attribute "default[:awscli][:output]" is used to set the default output format of AWS CLI commands. The acceptable option are json, text and table. You may change it according to your requirement.
3) The attribute "default[:awscli][:access_key]" is for AWS IAM user access key. The default value is blank. The user need to setup the value in "/root/.aws/credentials" file.
4) The attribute "default[:awscli][:secret_access_key]" is for AWS IAM user secret access key. The default value is blank. The user need to setup the value in "/root/.aws/credentials" file.

Usage
-----
#### awscli::default

Just include `awscli` in run_list of node.

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Vipin Mandale (vmandale@gmail.com)
