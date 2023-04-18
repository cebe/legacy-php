#!/bin/sh -e

#PHP="php-7.1.4"
#PHP="php-7.0.25"
#PHP="php-5.6.32"
#PHP="php-7.2.29"
#PHP="php-7.4.24"
PHP="php-5.3.29"
BUILD_NAME=$1

URL="http://de2.php.net/get/$PHP.tar.bz2/from/this/mirror"
SIG="http://de2.php.net/get/$PHP.tar.bz2.asc/from/this/mirror"

echo "preparing to build PHP $PHP with config $BUILD_NAME..."
# get build conf
if [ ! -f $BUILD_NAME.conf ] ; then
	echo "$BUILD_NAME.conf does not exist!"
	exit 1
fi
MAKECONFIG=$(while read line; do echo -n "$line "; done < $BUILD_NAME.conf)

mkdir -p build
cd build

# download sources if not already done
if [ ! -d $PHP ] ; then

	wget --no-check-certificate $URL -O $PHP.tar.bz2
	wget --no-check-certificate $SIG -O $PHP.tar.bz2.asc

	gpg --trust-model always --verify $PHP.tar.bz2.asc

	tar xjf $PHP.tar.bz2
fi

cd $PHP

apt-get -y install libicu-dev libmcrypt-dev libreadline-dev

# get pecl packages to compile statically into the binary
if [ -f "../../$BUILD_NAME.pecl.conf" ] ; then
	apt-get -y install autoconf automake
	while read line
	do
		cd ext
		# remove any version info from the extension
		lineV=$(echo "$line" | grep -oP "^\w+")
		echo "$lineV"
		if [ -z "$lineV" ] ; then
			echo "failed to parse value from pecl.conf"
			exit 1
		fi
		if [ ! -d $lineV ] ; then
			pecl download $line
			mv $lineV*.tgz $lineV.tgz
			gzip -d < $lineV.tgz | tar -xvf -
			mv $lineV-* $lineV
		fi
		cd ..
	done < ../../$BUILD_NAME.pecl.conf
	rm configure
	./buildconf --force
fi

# conigure PHP
echo ""
echo "running configure..."
echo ""
PREFIX="/srv/php/${PHP}_$BUILD_NAME"
./configure --prefix=$PREFIX --sysconfdir=/etc --mandir=$PREFIX/man --with-config-file-path=$PREFIX/conf $MAKECONFIG

echo ""
echo "make..."
echo ""
make
make install

echo ""
echo "success!"
echo ""

cd .. # exit $PHP
cd .. # exit build


