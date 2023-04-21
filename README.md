欢迎来到Lean的Openwrt源码仓库！
=

[English](./README_EN.md)

## 注意：

1. **不**要用 **root** 用户 git 和编译！！！
2. 国内用户编译前最好准备好梯子
3. 默认登陆IP 192.168.2.1, 密码 无

## Ubuntu: 

#### 首次编译: 
1. 首先装好 Ubuntu 64bit，推荐 Ubuntu 20.04 LTS x64

2. 命令行分别输入
```bash

sudo apt-get update

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync aria2 ca-certificates python3-pyelftools python3-setuptools yasm libpython3-dev

```
3. 拉取源码
```bash

git clone https://github.com/WYC-2020/lede

cd lede

```

4. 拉取第三方库
```bash

./scripts/feeds update -a

./scripts/feeds install -a

make menuconfig

```

5.下载第三方库源码（国内请尽量全局科学上网）
```bash

make -j8 download V=s

```
6. 编译
```bash

make -j1 V=s

```

#### 二次编译：
```bash

cd lede

git pull

./scripts/feeds update -a && ./scripts/feeds install -a

make defconfig

make -j8 download

make -j$(($(nproc) + 1)) V=s

```

#### 重新配置：
```bash

rm -rf ./tmp && rm -rf .config

make menuconfig

make -j$(($(nproc) + 1)) V=s

```

#### 输出路径：
```bash

bin/targets

```

## WSL或WSL2进行编译：
>> 由于wsl的PATH路径中包含带有空格的Windows路径，有可能会导致编译失败，请在将make -j1 V=s或make -j$(($(nproc) + 1)) V=s改为

#### 首次编译：
```bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j1 V=s 
```
#### 二次编译：
```bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make -j$(($(nproc) + 1)) V=s
```

## macOS 原生系统进行编译：
1、安装xcode
```bash
xcode-select --install  or Command_Line_Tools_for_Xcode_11.5
```
2、安装Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3、安装编译环境
```bash
brew install coreutils findutils gawk grep gnu-getopt gnu-tar wget diffutils git-extras quilt svn make ncurses pkg-config
```
4、更新环境变量
```bash
echo 'export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/gettext/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.bashrc
echo 'export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"' >> ~/.bashrc
```
5、生效环境变量
```bash
source ~/.bashrc
```
>> 然后输入 bash 命令，进入bash shell，就可以和 Ubuntu(第三步开始)一样正常编译了

6、可能遇到问题:
```bash
SSL certificate problem: certificate has expire in macOS
Rename /etc/ssl/cert.pem to something else. (I suggest /etc/ssl/cert.pem.org)
Download the latest cacert.pem from https://curl.se/docs/caextract.html
Rename it to cert.pem
Copy it to /etc/ssl/cert.pem
```
## HASH更新
#### 第一种方法(自动生成):

1、
修改Makefile中让此项写成以下这样，(如果不加上skip,那么在第三步填充哈希值时会直接删除"PKG_MIRROR_HASH:="这一行)
```bash 
PKG_MIRROR_HASH:=skip
``` 
2、
下载软件包(如软件包名为hello,包的Makefile放在package/network/services/hello下)
```bash
make package/network/services/hello/download V=s
```
3、
填充哈希值
```bash
make package/network/services/hello/check FIXUP=1 V=s
```
#### 第二种方法(手动生成):

1、
首先在软件包的Makefile中让此项空着，如下：
```bash 
PKG_MIRROR_HASH:=
```
然后下载软件包（如软件包名为hello,包的Makefile放在package/network/services/hello下）
```bash
make package/network/services/hello/download V=s
```

2、
在第一步完成之后会在dl目录下发现一个新模块相关的压缩包，直接使用以下命令来生成哈希值,如:
```bash 
sha256sum 包名.tar.xz
```
  
3、
将第二步生成的哈希值填充到Makefile的PKG_MIRROR_HASH即可

