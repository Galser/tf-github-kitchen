# tf-github-kitchen
TF skills map 200 - GitHub provider + KitchenCI test

# Introduction
The GitHub provider is used to interact with GitHub organization resources. See detailed desciption here : [GitHub Provider](https://www.terraform.io/docs/providers/github/index.html)

The provider allows you to manage your GitHub organization's members and teams easily. It needs to be configured with the proper credentials before it can be used. 

This repo demonstrates usage of some basic feature of the GitHub provider , not all of them. 

# Requirements
This repo assumes general knowledge about Terraform and GitHub, if not, please get yourself accustomed first by going through [getting started guide for Terraform](https://learn.hashicorp.com/terraform?track=getting-started#getting-started) and [Quick Start Guide for GitHub](https://guides.github.com/activities/hello-world/)

We also going to use [KitchenCI](https://kitchen.ci/), but all instructions and tests are provided dedicated section in README on [How to install KitchenCI](#how-to-install-kitchenci).

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)

# How to use

- Download copy of the code (*clone* in Git terminology) - go to the location of your choice (normally some place in home folder) and run in terminal; in case you are using alternative Git Client - please follow appropriate instruction for it and download(*clone*) [this repo](https://github.com/Galser/tf-github-kitchen.git). 
    ```
    git clone https://github.com/Galser/tf-github-kitchen.git
    ```
- Previous step should create the folder that contains a copy of the repository. Default name is going to be the same as the name of repository e.g. `tf-github-kitchen`. Locate and open it.
    ```
    cd tf-github-kitchen
    ```
- You will need first to create Personal Access Token in GitHub, use [this link](https://github.com/settings/tokens), write down the token, as you are going to see it only once! And note also your organization name. 
> Note, if yu don't have an organization. you can create one by visiting [this link](https://github.com/settings/organizations), pressing button "New organization" and following all the steps.
- Export token as environment variable, execute : 
    ```
    export GITHUB_TOKEN=YOUR_TOKEN_HERE
    ```
- Next step is to install KitchenCI, the task includes multiple steps so it is been provided in a separate section. Please follow instructions in [How to install KitchenCI](#how-to-install-kitchenci)



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

- Install required Ruby version and choose it as default local. Run from command line : 
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
- To simplify our life and to install required Ruby packages we are going to use **Ruby bundler** (See : https://bundler.io/ ). Let's install it. Execute : 
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
- [ ] put basic instructions in readme
- [ ] prepare Ruby and KitchenCI env
- [ ] create Kitchen test
- [ ] run and tune Kitchen test
- [ ] update readme 


# Done
- [x] initial README
- [x] introduction section
- [x] prepare environment (create tokens and etc)
- [x] create demo code
- [x] test code


# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 
2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 
3. **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. For more details please check the product site : [KitchenCI](https://kitchen.ci/). There is a dedicated section in README on [How to install KitchenCI](#how-to-install-kitchenci)

# Tools that are going to be used indirectly

5. **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More here: https://rubygems.org/
