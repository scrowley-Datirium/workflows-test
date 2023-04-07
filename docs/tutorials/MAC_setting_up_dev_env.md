# MAC: Setting up dev env

## Mac

Steps: 

- [install brew](https://brew.sh/)
- [install zsh](#mac-install-zsh)
- [install and configure git](#mac-install-git)




### Mac: Install zsh
Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

The installation script should set zsh to your default shell, but if it doesn't you can do it manually:

```bash
chsh -s $(which zsh)
```

### Mac: Install git

To install, run:


```bash
brew install git
```

When done, to test that it installed properly you can run:

```bash
git --version
```

And which git should output ```/usr/local/bin/git```.

Next, we'll define your Git user (should be the same name and email you use for GitHub):

```bash
git config --global user.name "Your Name Here"
git config --global user.email "your_email@youremail.com"
```

They will get added to your .gitconfig file.

To push code to your GitHub repositories, we recommend using the ssh method. There are also instructions for using HTTPS on [here](https://gist.github.com/jonjack/bf295d4170edeb00e96fb158f9b1ba3c). 

#### Configure git: Generate a new SSH key

If you don't have an SSH key you need to generate one. To do that you need to run the commands below, and make sure to substitute the placeholder with your email. The default settings are preferred, so when you're asked to enter a file in which to save the key, just press Enter to continue.

```bash
ssh-keygen -t rsa -C "your_email@example.com"
```

#### Configure git: Create a new ssh key, using the provided email as a label

Add your SSH key to the ssh-agent
Run the following commands to add your SSH key to the ssh-agent.

```bash
eval "$(ssh-agent -s)"
```

If you're running macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain:


```text
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

No matter what operating system version you run you need to run this command to complete this step:

```bash
ssh-add -K ~/.ssh/id_rsa
```

#### Configure git: Adding a new SSH key to your GitHub account

The last step is to let GitHub know about your SSH key so GitHub can recognize you. Run this command to copy your key to your clipboard:

```bash
pbcopy < ~/.ssh/id_rsa.pub
```

Then go to GitHub and input your new SSH key. Paste your key in the "Key" text-box and pick a name that represents the computer you're currently using.

---

### Mac: Install vscode

```bash
brew install --cask visual-studio-code
```

- How To
    - [Launch VS Code from the command line](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
    - [Add option to 'finder' for to open file or folder with vsCode](https://stackoverflow.com/questions/64040393/open-a-folder-in-vscode-through-finder-in-macos/64065309#64065309)

After that, you can launch VS Code from your terminal:

```code .``` will open VS Code in the current directory

```code myfile.txt``` will open myfile.txt in VS Code

#### Useful vsCode extensions

CWL (Rabix/Benten) (free)

[VS Marketplace Link](https://marketplace.visualstudio.com/items?itemName=sbg-rabix.benten-cwl)

---

### Mac: Install minconda

```bash
brew install --cask miniconda
conda init
```

#### Make a new environment

We want to set a sepcific python version for running workflows locally (conda also has a ‘base’ env that it's good to keep clean)

```bash
conda create -n workflows_env python=3.8 
conda activate workflows_env
which pip # output should path to your 'workflows_env'
pip install cwltool==3.1.20210816212154
```

---

### Mac: Install SRA toolkit

[Detailed download instructions](https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit)


```bash
#download, move tar.gz file to an app dir (e.g., ~/data/apps/src/)
# run below from within directory holding tar
tar -zxf sratoolkit.3.0.0-mac64.tar.gz
export PATH=$PATH:$PWD/sratoolkit.3.0.0-mac64/bin
```

---

# Final Notes

when running on commandline, macOS may pop-up an error message, to enable, go to:

> Preferences > Security & Privacy" > General tab > "Allow apps downloaded from:" 
> and click "Allow Anyway"

 



