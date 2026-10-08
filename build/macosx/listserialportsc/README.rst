list serial ports
=================

A more Linux approach of https://github.com/arduino/listSerialPortsC/

The *arduino approach* is *build many binaries* on the **same** machine.

Here just two C source files, *main.c* and *jnilib.c*, plus a real *Makefile*.

That means upstream tarball (with all libserialport files) is _not_ used.

License: LGPL-3  same as upstream
Copyright: 2018 Geert Stappers <stappers@stappers.it>

build dependency
----------------

.. code:: shell
  sudo apt install libserialport-dev

up to date
----------

Keep up to date with
.. code:: shell
  script/update_upstream_files

Then check with
.. code:: shell
  git diff


Distribute
----------

The command
.. code:: shell
  make dist

will create a tarball.
Which can be use for further distribution
and for packaging for your favorite distribution.
