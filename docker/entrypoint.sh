#!/bin/bash
CUSTOMIZATION=$1
CUSTOMIZATION=${CUSTOMIZATION:-networkoptix}
BASEDIR=/opt/$CUSTOMIZATION/mediaserver
sudo ${BASEDIR}/bin/root-tool-bin&
sudo ${BASEDIR}/bin/mediaserver-bin  -e
