Welcome to Lean's git source of OpenWrt and packages
=

[CN](./README.md)

## Note:

1. DO **NOT** USE **root** USER FOR COMPILING!!!

2. Users within China should prepare proxy before building.

3. Web admin panel default IP is 192.168.1.1 and default password is "password".

## Ubuntu: 
Let's start!

#### First compile: 
1. Install Ubuntu 64bit (Ubuntu 20.04 LTS x86 is recommended).

2. Command line input
```bash
sudo apt-get update

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync aria2 ca-certificates python3-pyelftools python3-setuptools yasm libpython3-dev
```

3. Pull the source code
```bash
git clone https://github.com/WYC-2020/lede

cd lede
```

4.Pull third-party libraries
```bash
./scripts/feeds update -a

./scripts/feeds install -a

make menuconfig
```

5. Download the source code of the third-party library (user in China should use global proxy when possible)
```bash
make -j8 download V=s
```

6. Compile the source code
```bash
make -j1 V=s
```

#### Secondary compilation：
```bash
cd lede

git pull

./scripts/feeds update -a && ./scripts/feeds install -a

make defconfig

make -j8 download

make -j$(($(nproc) + 1)) V=s
```

#### Reconfigure：
```bash
rm -rf ./tmp && rm -rf .config

make menuconfig

make -j$(($(nproc) + 1)) V=s
```

#### Output path：
```bash
bin/targets
```

## Compile with WSL or WSL2：
>> Since the PATH path of wsl contains Windows paths with spaces, it may cause compilation failure. Please change make -j1 V=s or make -j$(($(nproc) + 1)) V=s to

#### First compile：
```bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j1 V=s 
```
#### Secondary compilation：
```bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j$(($(nproc) + 1)) V=s
```

## Compile for macOS native system：
1、Install xcode
```bash
xcode-select --install  or Command_Line_Tools_for_Xcode_11.5
```
2、Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3、Install the build environment
```bash
brew install coreutils findutils gawk grep gnu-getopt gnu-tar wget diffutils git-extras quilt svn make ncurses pkg-config
```
4、Update environment variables
```bash
echo 'export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/gettext/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"' >> ~/.bashrc
```
5、Effective environment variable
```bash
source ~/.bashrc
```
>> Then enter the bash command, enter the bash shell, and you can compile normally like Ubuntu (starting in the third step)

6、May encounter problems:
```bash
SSL certificate problem: certificate has expire in macOS
Rename /etc/ssl/cert.pem to something else. (I suggest /etc/ssl/cert.pem.org)
Download the latest cacert.pem from https://curl.se/docs/caextract.html
Rename it to cert.pem
Copy it to /etc/ssl/cert.pem
```

## Update package HASH
#### The first method (automatically generated):

1、
Modify the Makefile so that this item is written as follows, (if skip is not added, the line "PKG_MIRROR_HASH:=" will be deleted directly when filling the hash value in the third step)
```bash 
PKG_MIRROR_HASH:=skip
``` 
2、
Download the package (for example, the package name is hello, and the Makefile of the package is placed under package/network/services/hello)
```bash
make package/network/services/hello/download V=s
```
3、
Fill the hash
```bash
make package/network/services/hello/check FIXUP=1 V=s
```
#### The second method (manual generation):

1、
First, leave this item empty in the Makefile of the package, as follows：
```bash 
PKG_MIRROR_HASH:=
```

Then download the package (for example, the package name is hello, and the Makefile of the package is placed under package/network/services/hello)
```bash
make package/network/services/hello/download V=s
```

2、
After the first step is completed, a compressed package related to a new module will be found in the dl directory, and the following command will be used directly to generate the hash value, such as:
```bash 
sha256sum name.tar.xz
```
  
3、
Fill the hash value generated in the second step into PKG_MIRROR_HASH of Makefile
