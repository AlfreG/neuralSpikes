#!bin/sh


## Python3.8 Local installation
./configure --version
./configure --enable-optimizations --with-ensurepip=install
./configure --prefix=$HOME --exec-prefix=$HOME --enable-optimizations --with-ensurepip=install --enable-loadable-sqlite-extensions --enable-ipv6
make
make test
make altinstall

python3.8 -m pip install --upgrade pip setuptools wheel

python3.8 -m pip install --user Cython==0.29.16
python3.8 -m pip install --user numpy==1.18.1
python3.8 -m pip install --user scipy==1.4.1
python3.8 -m pip install --user matplotlib==3.1.2
python3.8 -m pip install --user django==3.0.0
python3.8 -m pip install --user prompt-toolkit==2.0.9
python3.8 -m pip install --user sqlparse


## Make executable globally
#export PATH="$HOME/bin:$PATH"


## Virtual envirnoment
## https://docs.python.org/3/tutorial/venv.html
## This will create the tutorial-env directory if it doesn’t exist,
## and also create directories inside it containing a copy of the Python interpreter,
## the standard library, and various supporting files.
#PRJ_NAME="spikes-env"
#python3.8 -m venv ${PRJ_NAME}
## activate environment
#source ${PRJ_NAME}/bin/activate
## install required modules
#sudo pip install -r ./requirements.txt
