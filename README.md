# tf-github-kitchen
TF skills map 200 - GitHub provider + KitchenCI test

# Introduction
The GitHub provider is used to interact with GitHub organization resources. See detailed description here : [GitHub Provider](https://www.terraform.io/docs/providers/github/index.html)

The provider allows you to manage your GitHub organization's members and teams easily. It needs to be configured with the proper credentials before it can be used. 

This repo demonstrates the usage of some basic features of the GitHub provider, not all of them. 

# Requirements
This repo assumes general knowledge about Terraform and GitHub, if not, please get yourself accustomed first by going through [getting started guide for Terraform](https://learn.hashicorp.com/terraform?track=getting-started#getting-started) and [Quick Start Guide for GitHub](https://guides.github.com/activities/hello-world/)

We also going to use [KitchenCI](https://kitchen.ci/), but all instructions and tests are provided in a dedicated section in README on [How to install KitchenCI](#how-to-install-kitchenci).

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)

# How to use

- Download copy of the code (*clone* in Git terminology) - go to the location of your choice (normally some place in home folder) and run in terminal; in case you are using alternative Git Client - please follow appropriate instruction for it and download(*clone*) [this repo](https://github.com/Galser/tf-github-kitchen.git). 
    ```
    git clone https://github.com/Galser/tf-github-kitchen.git
    ```
- The previous step should create a folder that contains a copy of the repository. The default name is going to be the same as the name of repository e.g. `tf-github-kitchen`. Locate and open it.
    ```
    cd tf-github-kitchen
    ```
- You will need first to create Personal Access Token in GitHub, use [this link](https://github.com/settings/tokens), write down the token, as you are going to see it only once! And note also your organization name. 
> Note, if yu don't have an organization. you can create one by visiting [this link](https://github.com/settings/organizations), pressing button "New organization" and following all the steps.
- Export token as an environment variable, execute : 
    ```
    export GITHUB_TOKEN=YOUR_TOKEN_HERE
    ```
- The next step is to install KitchenCI, the task includes multiple steps so it is been provided in a separate section. Please follow instructions in [How to install KitchenCI](#how-to-install-kitchenci)

## How to test 

- To prepare our test repository execute :
    ```
    bundle exec kitchen converge
    ```
    The output will start with lines :
    ```
    bundle exec kitchen converge      
    -----> Starting Kitchen (v1.25.0)
    -----> Creating <default-github>...
        Terraform v0.12.9
        + provider.github v2.2.1
        
        Your version of Terraform is out of date! The latest version
        is 0.12.10. You can update by downloading from www.terraform.io/downloads.html
    $$$$$$ Running command `terraform init -input=false -lock=true -lock-timeout=0s  -upgrade -force-copy -backend=true  -get=true -get-plugins=true -verify-plugins=true` in directory /Users/andrii/labs/skills/tf-github-kitchen
        
        Initializing the backend...
        
        Initializing provider plugins...
        - Checking for available provider plugins...
        - Downloading plugin for provider "github" (hashicorp/github) 2.2.1...

    ```
    And should end with : 
    ```
       Outputs:
       
       full_repo_web_path = https://github.com/ORGatization/example
       repo_description = Example codebase repo
       ssh_clone_url = git@github.com:ORGatization/example.git
       Finished converging <default-github> (0m5.46s).
    -----> Kitchen is finished. (0m9.61s)
    ```    
- To run tests execute : 
    ```
    bundle exec kitchen verify
    ```
    The output going to look like : 
    ```
    -----> Starting Kitchen (v1.25.0)
    -----> Setting up <default-github>...
        Finished setting up <default-github> (0m0.00s).
    -----> Verifying <default-github>...
    $$$$$$ Running command `terraform workspace select kitchen-terraform-default-github` in directory /Users/andrii/labs/skills/tf-github-kitchen
    $$$$$$ Running command `terraform output -json` in directory /Users/andrii/labs/skills/tf-github-kitchen
    default: Verifying

    Profile: Default Kitchen-Terraform (default)
    Version: 0.1.0
    Target:  local://

    ✔  check_github_repo_url: HTTP GET on https://github.com/ORGatization/example
        ✔  HTTP GET on https://github.com/ORGatization/example status is expected to cmp == 200
        ✔  HTTP GET on https://github.com/ORGatization/example body is expected to match "Example codebase repo"


    Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
    Test Summary: 2 successful, 0 failures, 0 skipped
        Finished verifying <default-github> (0m3.51s).
    -----> Kitchen is finished. (0m5.54s)    
    ```
    As you can see all tests had passed e.g. our Terraform code indeed had created repo within the designated organization with required description.
- When you've done with checking and all tests, please, do not forget to free resources by running : 
    ```
    bundle exec kitchen destroy
    ```
    The output should look similar to the following : 
    ```
    -----> Starting Kitchen (v1.25.0)
    -----> Destroying <default-github>...
        Terraform v0.12.9
        + provider.github v2.2.1
        
        Your version of Terraform is out of date! The latest version
        is 0.12.10. You can update by downloading from www.terraform.io/downloads.html
    $$$$$$ Running command `terraform init -input=false -lock=true -lock-timeout=0s  -force-copy -backend=true  -get=true -get-plugins=true -verify-plugins=true` in directory /Users/andrii/labs/skills/tf-github-kitchen
        
        Initializing the backend...
        
        Initializing provider plugins...
        
        The following providers do not have any version constraints in configuration,
        so the latest version was installed.
        
        To prevent automatic upgrades to new major versions that may contain breaking
        changes, it is recommended to add version = "..." constraints to the
        corresponding provider blocks in configuration, with the constraint strings
        suggested below.
        
        * provider.github: version = "~> 2.2"
        
        Terraform has been successfully initialized!
    $$$$$$ Running command `terraform workspace select kitchen-terraform-default-github` in directory /Users/andrii/labs/skills/tf-github-kitchen
    $$$$$$ Running command `terraform destroy -auto-approve -lock=true -lock-timeout=0s -input=false  -parallelism=10 -refresh=true  ` in directory /Users/andrii/labs/skills/tf-github-kitchen
        github_repository.example: Refreshing state... [id=example]
        github_repository.example: Destroying... [id=example]
        github_repository.example: Destruction complete after 0s
        
        Destroy complete! Resources: 1 destroyed.
    $$$$$$ Running command `terraform workspace select default` in directory /Users/andrii/labs/skills/tf-github-kitchen
        Switched to workspace "default".
    $$$$$$ Running command `terraform workspace delete kitchen-terraform-default-github` in directory /Users/andrii/labs/skills/tf-github-kitchen
        Deleted workspace "kitchen-terraform-default-github"!
        Finished destroying <default-github> (0m2.54s).
    -----> Kitchen is finished. (0m4.61s)    
    ```
    All done, this concludes the instructions section.

# How to install KitchenCI

In order to run our tests we need an isolated Ruby environment, for this purpose we are going to install and use rbenv - tool that lets you install and run multiple versions of Ruby side-by-side. 
- **On macOS use HomeBrew** (check [Technologies section](#technologies) for more details) to install rbenv.  Execute from command-line :
    ```
    brew install rbenv
    ```
   To succesfully utilize rbenv you will need also to make appropiate env changes :
   - macOs with BASH as the default  shell, run the commands
   ```
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
   source ~/.bash_profile
   rbenv init
   echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
   source ~/.bash_profile
   ```
   - macOS with ZSH as default shell (credits to :  [Rod Wilhelmy](https://coderwall.com/wilhelmbot) ), run the commands :
   ```
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshenv
   echo 'eval "$(rbenv init -)"' >> ~/.zshenv
   echo 'source $HOME/.zshenv' >> ~/.zshrc
   exec $SHELL
   ```
- **On Linux (Debian flavored)**:

 > Note: On Graphical environments, when you open a shell, sometimes ~/.bash_profile doesn't get loaded You may need to source ~/.bash_profile manually or use ~/.bashrc
 ```
 apt update
 apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
 wget -q https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer -O- | bash
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
 source ~/.bash_profile
 rbenv init
 echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
 source ~/.bash_profile
 ```
For other distributions please refer to your system's appropriate manuals 

- Install the required Ruby version and choose it as default local. Run from the command line : 
```
rbenv install 2.3.1
rbenv local 2.3.1
```
- Check that your settings are correct by executing :
```
rbenv versions
```
Output should like something like this : 
```
 system
* 2.3.1 (set by /Users/.../kitchen-vagrant/.ruby-version)
  2.6.0
```
Your output can list other versions also, due to the difference in environments, but the important part is that you should have that asterisk (*) symbol in front of the Ruby version 2.3.1 marking it as active at the current moment
- To simplify our life and to install required Ruby packages we are going to use **Ruby bundler** (See: https://bundler.io/ ). Let's install it. Execute : 
```
gem install bundler
```
- We going to use KitchenCI for our test, to install it and other required **Ruby Gems**, the repository comes with the [Gemfile](Gemfile) that list all that required. Run :
```
bundle install
```
Output going to span several pages, but the last part should be : 
```
Fetching test-kitchen 2.3.3
Installing test-kitchen 2.3.3
Fetching kitchen-inspec 1.2.0
Installing kitchen-inspec 1.2.0
Fetching kitchen-vagrant 1.6.0
Installing kitchen-vagrant 1.6.0
Bundle complete! 4 Gemfile dependencies, 107 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
Now KitchenCI is ready for usage, you can go back and continue with tests from [this section](#how-to-test). 


# To do
- [ ] update readme 


# Done
- [x] initial README
- [x] introduction section
- [x] prepare environment (create tokens and etc)
- [x] create demo code
- [x] test code
- [x] put basic instructions in readme
- [x] prepare Ruby and KitchenCI env
- [x] create Kitchen test
- [x] run and tune Kitchen test


# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 
2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 
3. **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. For more details please check the product site : [KitchenCI](https://kitchen.ci/). There is a dedicated section in README on [How to install KitchenCI](#how-to-install-kitchenci)

# Tools that are going to be used indirectly

5. **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More here: https://rubygems.org/
