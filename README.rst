========================
vim-quick-radon
========================

vim-quick-radon is a Vim plugin that applies radon to your current file.
Radon is a Python tool that computes various metrics from the source code.

Required
=====================

* `radon <https://pypi.python.org/pypi/radon/>`_

Installation
=====================

Simply put the contents of this repository in your ~/.vim/bundle directory.

Usage
=====================

Call function:: 

 :QuickRadon

Result example

.. image:: https://dl.dropboxusercontent.com/spa/ghyn87yb4ejn5yy/r-p2wzdx.png

You can check the results of the three commands.

* [ Cyclomatic Complexity ] ... radon cc 
* [ Maintainability Index ] ... radon mi
* [ Raw Metrics ] ... radon raw

Customization
=====================

TODO

Alternatives
=====================

* `vim-radon <https://github.com/rubik/vim-radon>`_. Created by radon original author.

License
=====================

MIT License
