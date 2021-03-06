
vv=5.46

# Script to update bluez, works on Ubuntu 16.0 and 16.10.
# See next comment for Raspbian jessie

sudo apt-get update
sudo apt-get install -yqq build-essential curl git unzip wget \
  libglib2.0-dev libical-dev libreadline-dev libudev-dev libdbus-1-dev \
  libdbus-glib-1-dev udev rfkill

rm -rf /tmp/bluez-up
mkdir -p /tmp/bluez-up
cd /tmp/bluez-up

wget "http://www.kernel.org/pub/linux/bluetooth/bluez-$vv.tar.xz" && \
    tar xJvf bluez-$vv.tar.xz && cd bluez-$vv && \
    ./configure --prefix=/usr/local --enable-experimental && \
    make -j 2 && \
    sudo make install

# For Raspbian jessie
# sudo rm /usr/sbin/bluetoothd
# sudo ln -s /usr/local/libexec/bluetooth/bluetoothd /usr/sbin/bluetoothd

sudo systemctl daemon-reload
sudo service bluetooth restart

cd ../
rm -rf /tmp/bluez-up


echo ""
echo "---"
echo "Bluez installation completed. Ensure \`bluetoothd -v\` print the correct version (Eg. `bluetoothd -v` == $vv)."
echo "If not, try to locate the legacy version and remove / substitute them. Eg. \`whereis bluetoothd\` : `whereis bluetoothd`"
echo "To enable enable experimental features, edit \`/etc/systemd/system/bluetooth.target.wants/bluetooth.service\` adding --experimental to the bluetoothd command"
echo "After that, reload the service eg. \`sudo systemctl daemon-reload && sudo service bluetooth restart\`"
